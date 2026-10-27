package com.iflytek.ms600.cast.mirror

import android.os.SystemClock
import timber.log.Timber
import java.io.OutputStream
import java.net.InetSocketAddress
import java.net.Socket
import java.util.concurrent.LinkedBlockingQueue
import java.util.concurrent.TimeUnit

/**
 * UibcBridge —— Miracast 反向控制（UIBC = User Input Back Channel）。
 *
 * 作用：投屏时把**本机（Sink）**上的触摸操作回传给**手机 / 电脑（Source）**，
 * 也就是"在大屏上直接操作手机"。
 *
 * ## 建立方式（WFD 规范 §4.11，已实测核对）
 * 1. Source 在 RTSP **M3** 里问 Sink 的 `wfd_uibc_capability`；
 * 2. Sink（本类）在 M3 响应里声明 `input_category_list=GENERIC;generic_cap_list=Mouse`，端口填 `none`
 *    （Sink 是主动连接的一方，不监听）；
 * 3. Source 在 **M4 / M15** 里给出 `wfd_uibc_capability: ...;port=<它监听的 TCP 端口>`
 *    并用 `wfd_uibc_setting: enable` 激活；
 * 4. 本机作为 TCP client 连过去，整个会话复用这一条连接。
 *
 * ## 包格式（公共包头 + Generic Input Body）
 * ```
 * Byte 0    [ version(3bit)=000 | T(1bit)=0 | reserved(4bit)=0 ]   固定 0x00
 * Byte 1    [ reserved(4bit)=0 | input category(4bit) ]           0 = GENERIC
 * Byte 2..3 整个包的长度（含这 4 字节包头），大端
 * Body:     [ type id(1) ] [ payload 长度(2, 大端) ] [ payload… ]
 * ```
 * Generic Input Type ID（规范 Table 5-5 / 2.1 Table 15）：
 * `0` = 鼠标左键按下 / 触摸按下，`1` = 抬起，`2` = 移动
 *
 * Pointing/触摸 payload：`[触点数(1)] [pointer id(1)] [X(2)] [Y(2)]`，
 * X/Y 是**归一化到 0~0xFFFF** 的坐标（相对 Source 画面左上角）。
 */
object UibcBridge {

    /**
     * Generic Input Type ID：**触摸**按下。
     *
     * MS600 v150b：这里原来写的是 0 / 1 / 2 —— 那是 **Mouse** 的编号
     * （0=左键按下、1=左键抬起、2=移动）。以前 M3 里同时声明了 Mouse，
     * 所以编号碰巧对得上；现在改成只声明 SingleTouch/MultiTouch，
     * 编号必须换成触摸的 4 / 5 / 6，否则 Source 按 Mouse 去解析一个触摸 payload，
     * 直接解析失败 —— 现象就是**完全没有触摸反馈**（用户 2026-10-18 实测）。
     */
    const val TYPE_DOWN = 0

    /** Generic Input Type ID：鼠标左键抬起。 */
    const val TYPE_UP = 1

    /** Generic Input Type ID：鼠标移动。 */
    const val TYPE_MOVE = 2

    /** Source 是否已经通过 `wfd_uibc_setting` 激活了反向控制。 */
    @Volatile
    var activated = false
        private set

    /** 用户开关（参数面板里的「反向控制」）；关掉后一律不发送，作为兜底。 */
    @Volatile
    var userEnabled = true

    /**
     * 报文格式（0/1/2）。
     *
     * 手机从不回 `wfd_uibc_capability`，它按自己的默认值解析 —— 到底是 Mouse 还是 Touch
     * 只能试出来。三套格式：
     *  0 = Mouse · 5 字节 payload（`btn + x + y`）：现状，实测**能点**，滑动无效；
     *  1 = Mouse · 规范格式（按下/抬起 payload 长度 0，移动 4 字节 `x + y`）；
     *  2 = Touch（type 4/5/6，payload `触点数 + 指针 id + x + y`）。
     */
    @Volatile
    var profile = 0

    /** 每两个移动事件之间的最小间隔：手指滑动一秒能出上百个 MOVE，全发会把链路刷爆。 */
    private const val MOVE_THROTTLE_MS = 20L

    /** 待发包上限，超了直接丢最老的 —— 反向控制宁可丢包也不能拖慢 UI。 */
    private const val MAX_QUEUE = 24

    private val queue = LinkedBlockingQueue<ByteArray>(MAX_QUEUE + 8)

    @Volatile
    private var socket: Socket? = null

    @Volatile
    private var output: OutputStream? = null

    /** MS600 v150d: 鼠标左键当前是否按下（拖动期间 MOVE 要一直带 button=1）。 */
    @Volatile
    private var pointerDown = false

    @Volatile
    private var running = false

    private var worker: Thread? = null
    private var lastSendMs = 0L

    /**
     * Source 在 M4 / M15 里给出 UIBC 端口并开关时调用。
     *
     * @param enabled `wfd_uibc_setting: enable/disable`
     * @param host    Source 的地址（就是 RTSP 对端）
     * @param port    Source 监听的 UIBC TCP 端口；没给出（<=0）就无法建立
     */
    fun onUibcSetting(enabled: Boolean, host: String, port: Int) {
        if (!enabled) {
            Timber.i("UIBC: source 关闭了反向控制")
            stop()
            return
        }
        if (port <= 0) {
            Timber.w("UIBC: source 没有给出 TCP 端口，反向控制不可用")
            activated = false
            return
        }
        activated = true
        start(host, port)
    }

    private fun start(host: String, port: Int) {
        if (running) {
            Timber.d("UIBC: 连接已存在，忽略重复激活")
            return
        }
        running = true
        queue.clear()
        worker = Thread({
            var s: Socket? = null
            try {
                s = Socket()
                s.tcpNoDelay = true                 // 反向控制是交互操作，延迟优先
                s.connect(InetSocketAddress(host, port), 4000)
                socket = s
                output = s.getOutputStream()
                Timber.i("UIBC: 已连接 source $host:$port")

                while (running) {
                    val packet = queue.poll(500, TimeUnit.MILLISECONDS) ?: continue
                    val out = output ?: break
                    out.write(packet)
                    out.flush()
                }
            } catch (e: Exception) {
                if (running) Timber.w("UIBC: 连接/发送失败（${e.message}）")
            } finally {
                closeQuietly()
                running = false
                activated = false
                Timber.i("UIBC: 连接已关闭")
            }
        }, "UibcBridge").apply {
            isDaemon = true
            start()
        }
    }

    /**
     * 发一个指针事件（按下 / 抬起 / 移动）。
     *
     * @param type  [TYPE_DOWN] / [TYPE_UP] / [TYPE_MOVE]
     * @param xNorm 归一化 X，0~0xFFFF
     * @param yNorm 归一化 Y，0~0xFFFF
     */
    fun sendPointer(type: Int, xNorm: Int, yNorm: Int) {
        if (!activated || !userEnabled || !running) return

        val now = SystemClock.elapsedRealtime()
        if (type == TYPE_MOVE && now - lastSendMs < MOVE_THROTTLE_MS) return
        lastSendMs = now

        if (queue.size >= MAX_QUEUE) return            // 积压了就丢，绝不阻塞调用方

        val x = xNorm.coerceIn(0, 0xFFFF)
        val y = yNorm.coerceIn(0, 0xFFFF)

        // 规范 Mouse 格式里"按下/抬起"不带坐标，Source 用的是上一次移动落点。
        // 所以点之前先补一个 MOVE，把光标挪到位，否则会点在光标原来的位置。
        if (profile == 1 && type == TYPE_DOWN) {
            buildPacket(TYPE_MOVE, x, y)
        }
        buildPacket(type, x, y)
    }

    /** 按当前 [profile] 组包并入队。 */
    private fun buildPacket(type: Int, x: Int, y: Int) {
        val packet = when (profile) {
            1 -> {
                // Mouse 规范格式：移动 = 4 字节 x+y；按下/抬起 = 长度 0（坐标取上次移动）
                if (type == TYPE_MOVE) {
                    body(0x02, byteArrayOf(hi(x), lo(x), hi(y), lo(y)))
                } else {
                    body(if (type == TYPE_DOWN) 0x00 else 0x01, ByteArray(0))
                }
            }
            2 -> {
                // 触摸：4=按下 5=抬起 6=移动，payload = 触点数 + 指针 id + x + y
                val tid = when (type) {
                    TYPE_DOWN -> 4
                    TYPE_UP -> 5
                    else -> 6
                }
                body(tid, byteArrayOf(1, 0, hi(x), lo(x), hi(y), lo(y)))
            }
            else -> {
                // 现状：Mouse 5 字节（btn + x + y），实测能点
                val btn = when (type) {
                    TYPE_DOWN -> 1
                    TYPE_UP -> 0
                    else -> if (pointerDown) 1 else 0
                }
                body(type, byteArrayOf(btn.toByte(), hi(x), lo(x), hi(y), lo(y)))
            }
        }
        if (type == TYPE_DOWN) pointerDown = true
        if (type == TYPE_UP) pointerDown = false
        if (type != TYPE_MOVE) {
            Timber.i(
                "UIBC >> profile=$profile type=$type x=$x y=$y len=${packet.size} " +
                    "hex=${packet.joinToString("") { "%02x".format(it) }}"
            )
        }
        queue.offer(packet)
    }

    private fun hi(v: Int) = ((v shr 8) and 0xFF).toByte()
    private fun lo(v: Int) = (v and 0xFF).toByte()

    /** 公共包头（4 字节）+ Generic Input Body。 */
    private fun body(typeId: Int, payload: ByteArray): ByteArray {
        val total = 4 + 3 + payload.size
        val p = ByteArray(total)
        p[0] = 0x00                                    // version=0, T=0, reserved=0
        p[1] = 0x00                                    // reserved=0, category=0 (GENERIC)
        p[2] = hi(total)
        p[3] = lo(total)
        p[4] = typeId.toByte()
        p[5] = hi(payload.size)
        p[6] = lo(payload.size)
        System.arraycopy(payload, 0, p, 7, payload.size)
        return p
    }

    private fun enqueue(packet: ByteArray) {
        if (queue.size >= MAX_QUEUE) return
        queue.offer(packet)
    }

    /** 会话结束 / 出错时清干净。 */
    fun stop() {
        running = false
        worker?.interrupt()
        worker = null
        queue.clear()
        closeQuietly()
        activated = false
    }

    private fun closeQuietly() {
        try {
            output?.close()
        } catch (_: Exception) {
        }
        try {
            socket?.close()
        } catch (_: Exception) {
        }
        output = null
        socket = null
    }
}
