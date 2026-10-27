package com.iflytek.ms600.cast.miracast

import android.content.Context
import android.content.Intent
import com.iflytek.ms600.cast.util.AppSettings
import timber.log.Timber
import java.io.InputStream
import java.io.OutputStream
import java.net.Socket
import java.nio.charset.StandardCharsets

/**
 * Wi-Fi Display RTSP 会话处理器（Sink 侧）。
 *
 * 重要：WFD 里 **Source 才是 RTSP 监听方**，Sink 必须主动连到 Source 的 7236 端口。
 * 这一点已对 Windows 11 的 MSMiracastSource 实测确认。连接建立后，双方在同一条 TCP 上
 * 互为客户端和服务端：
 *
 * ```
 * M1  Source → Sink   OPTIONS         本类回 200 + Public
 * M2  Sink   → Source OPTIONS         本类主动发
 * M3  Source → Sink   GET_PARAMETER   本类回能力集（必须含 wfd_client_rtp_ports）
 * M4  Source → Sink   SET_PARAMETER   选定格式 + presentation URL
 * M5  Source → Sink   SET_PARAMETER   wfd_trigger_method: SETUP
 * M6  Sink   → Source SETUP           本类主动发，带 client_port
 * M7  Sink   → Source PLAY            本类主动发，之后 RTP 开始流入
 * ```
 *
 * @param socket 已连接到 Source 的 TCP 连接
 * @param rtpPort 本机用于接收 RTP 的 UDP 端口，会在 M3 和 M6 里告知 Source
 */
class WfdSessionHandler(
    private val context: Context,
    private val socket: Socket,
    private val rtpPort: Int
) {
    private val input: InputStream = socket.getInputStream()
    private val output: OutputStream = socket.getOutputStream()

    private var outCseq = 0                  // 我们主动发起的请求用的 CSeq
    private var sessionId = ""
    private var presentationUrl = ""
    private var playRequested = false

    var onSessionEstablished: ((sessionId: String) -> Unit)? = null
    var onStreamStart: ((rtpPort: Int) -> Unit)? = null
    var onStreamStop: (() -> Unit)? = null

    /** MS600: Source 开关反向控制（UIBC）时回调：(是否启用, source 地址, source 的 UIBC TCP 端口)。 */
    var onUibcSetting: ((enabled: Boolean, host: String, port: Int) -> Unit)? = null

    /** Source 在 M4/M15 里给出的 UIBC TCP 端口；0 = 还没给出。 */
    private var uibcPort = 0

    companion object {
        /**
         * 本机作为 Sink 声明的能力集。字段依次为：
         * native / preferred-display-mode / profile / level / CEA / VESA / HH /
         * latency / min-slice-size / slice-enc-params / frame-rate-control / max-hres / max-vres
         *
         * CEA 位图只声明三档，Windows 实测会挑其中最高的一档：
         * ```
         * bit 8 (0x100) = 1920x1080p60   ← 目标：帧间隔 16ms
         * bit 7 (0x080) = 1920x1080p30      链路撑不住时的退路
         * bit 6 (0x040) = 1280x720p60       再退一档
         * ```
         * 之前用的 0x0001DEFF 看着覆盖很广，但**恰好没有 bit 8**，所以 Windows 只能选到
         * 1080p30，帧间隔 33ms —— 而视频 PES 不定长，必须等下一帧首包才知道当前帧结束，
         * 这个等待直接等于帧间隔，是延迟的大头。
         *
         * level 同步提到 0x10（H.264 Level 4.2）：1080p60 超出了 Level 4.0 的上限。
         */
        /** 默认档（1920×1080）—— 实际用 [videoFormats] 按用户设置生成 */
        private const val VIDEO_FORMATS_1080P =
            "00 00 02 10 000001C0 00000000 00000000 00 0000 0000 00 none none"
        private const val AUDIO_CODECS = "AAC 00000001 00"
    }

    fun handleSession() {
        try {
            Timber.i("WFD session started with source ${socket.inetAddress.hostAddress}")
            while (!socket.isClosed) {
                val msg = readMessage() ?: break
                if (msg.startsWith("RTSP/1.0")) handleResponse(msg) else handleRequest(msg)
            }
        } catch (e: Exception) {
            Timber.e(e, "Error in WFD session")
        } finally {
            Timber.i("WFD session ended")
            onStreamStop?.invoke()
            close()
        }
    }

    // ─── 读取一条完整 RTSP 消息（头部 + 按 Content-Length 读 body）────────────
    private fun readMessage(): String? {
        val buf = StringBuilder()
        val one = ByteArray(1)

        // 读到头部结束
        while (!buf.endsWith("\r\n\r\n")) {
            val n = input.read(one)
            if (n <= 0) return null
            buf.append(one[0].toInt().toChar())
            if (buf.length > 64 * 1024) {
                Timber.w("WFD: header too large, dropping session")
                return null
            }
        }

        // 按 Content-Length 读 body（不能用 readLine，长度不足会静默截断）
        val contentLength = Regex("(?i)Content-Length:\\s*(\\d+)")
            .find(buf)?.groupValues?.get(1)?.toIntOrNull() ?: 0
        if (contentLength > 0) {
            val body = ByteArray(contentLength)
            var read = 0
            while (read < contentLength) {
                val n = input.read(body, read, contentLength - read)
                if (n <= 0) return null
                read += n
            }
            buf.append(String(body, StandardCharsets.UTF_8))
        }

        val msg = buf.toString()
        Timber.d("WFD >> ${msg.lineSequence().first()}")
        Timber.v("WFD >> full:\n$msg")
        return msg
    }

    private fun send(msg: String) {
        Timber.d("WFD << ${msg.lineSequence().first()}")
        Timber.v("WFD << full:\n$msg")
        output.write(msg.toByteArray(StandardCharsets.UTF_8))
        output.flush()
    }

    // ─── 处理 Source 发来的请求 ──────────────────────────────────────────────
    private fun handleRequest(msg: String) {
        val method = msg.substringBefore(' ')
        val cseq = header(msg, "CSeq") ?: "0"

        when (method) {
            "OPTIONS" -> {
                sendOk(cseq, "Public: org.wfa.wfd1.0, GET_PARAMETER, SET_PARAMETER\r\n")
                sendOptions()                                    // M2
            }
            "GET_PARAMETER" -> {
                if (msg.contains("wfd_")) sendCapabilities(cseq)  // M3
                else sendOk(cseq)                                 // keep-alive
            }
            "SET_PARAMETER" -> {
                // M4 里的 presentation URL 有两个值（"<url> none"），只能取第一个，
                // 否则拼出的 SETUP 请求行会多一段，Source 判定畸形直接断链。
                param(msg, "wfd_presentation_URL")
                    ?.substringBefore(' ')
                    ?.takeIf { it.startsWith("rtsp://") }
                    ?.let {
                        presentationUrl = it
                        Timber.i("WFD: presentation URL = $it")
                    }
                // M4 里 Source 回选的格式，第 5 个字段就是它选中的 CEA 分辨率位
                param(msg, "wfd_video_formats")?.let { selected ->
                    Timber.i("WFD: source selected video format = $selected")
                    val ceaBit = selected.split(' ').getOrNull(4)?.toLongOrNull(16) ?: 0L
                    val mode = when (ceaBit) {
                        0x100L -> "1920x1080p60"
                        0x080L -> "1920x1080p30"
                        0x040L -> "1280x720p60"
                        0x020L -> "1280x720p30"
                        else -> "CEA 0x%08X".format(ceaBit)
                    }
                    Timber.i("WFD: negotiated mode = $mode")
                }
                param(msg, "wfd_audio_codecs")?.let {
                    Timber.i("WFD: source selected audio codec = $it")
                }
                // MS600: 反向控制（UIBC）协商。Source 在 M4 / M15 里给出它监听的 TCP 端口，
                // 并用 wfd_uibc_setting: enable 激活 —— 两者都在 SET_PARAMETER 消息里。
                // MS600 v150e: 手机到底回了哪些 UIBC 参数？之前只打"解析后"的 port，
                //   capability 那行在日志里查不到 —— 直接把 M4 原始报文打出来，避免再靠猜。
                if (msg.contains("wfd_uibc", ignoreCase = true)) {
                    Timber.i("WFD M4 raw body: " + msg.replace("\r\n", " | ").trim())
                }
                param(msg, "wfd_uibc_capability")?.let { cap ->
                    // Source 回的这一串就是它**实际选中**的输入类型（Mouse / SingleTouch / MultiTouch…），
                    // 直接决定反控支持哪些手势，所以用 INFO 级打出来，方便随时核对。
                    Timber.i("WFD: source UIBC capability = $cap")
                    Regex("port=(\\d+)").find(cap)?.groupValues?.getOrNull(1)
                        ?.toIntOrNull()?.takeIf { it > 0 }?.let {
                            uibcPort = it
                            Timber.i("WFD: source UIBC TCP port = $it")
                        }
                }
                param(msg, "wfd_uibc_setting")?.let { setting ->
                    val enabled = setting.startsWith("enable", ignoreCase = true)
                    Timber.i("WFD: UIBC setting = $setting (port=$uibcPort)")
                    onUibcSetting?.invoke(enabled, socket.inetAddress?.hostAddress ?: "", uibcPort)
                }

                sendOk(cseq)
                if (msg.contains("wfd_trigger_method: SETUP")) sendSetup()      // M5 → M6
                if (msg.contains("wfd_trigger_method: TEARDOWN")) close()
            }
            "TEARDOWN" -> {
                sendOk(cseq)
                onStreamStop?.invoke()
                close()
            }
            else -> sendOk(cseq)
        }
    }

    // ─── 处理 Source 对我们请求的响应 ────────────────────────────────────────
    private fun handleResponse(msg: String) {
        val session = header(msg, "Session")?.substringBefore(';')
        if (!session.isNullOrBlank() && sessionId.isEmpty()) {
            sessionId = session
            Timber.i("WFD: session id = $sessionId")
            onSessionEstablished?.invoke(sessionId)
            sendPlay()                                           // M7
        } else if (playRequested) {
            Timber.i("WFD: PLAY acknowledged, RTP should start on $rtpPort")
            onStreamStart?.invoke(rtpPort)
            startPlayerActivity()
            playRequested = false
        }
    }

    // ─── 我们主动发起的请求 ──────────────────────────────────────────────────
    private fun sendOptions() = send(
        "OPTIONS * RTSP/1.0\r\n" +
            "CSeq: ${++outCseq}\r\n" +
            "Require: org.wfa.wfd1.0\r\n\r\n"
    )

    private fun sendSetup() {
        if (presentationUrl.isEmpty()) {
            presentationUrl = "rtsp://${socket.inetAddress.hostAddress}/wfd1.0/streamid=0"
        }
        send(
            "SETUP $presentationUrl RTSP/1.0\r\n" +
                "CSeq: ${++outCseq}\r\n" +
                "Transport: RTP/AVP/UDP;unicast;client_port=$rtpPort\r\n\r\n"
        )
    }

    private fun sendPlay() {
        playRequested = true
        send(
            "PLAY $presentationUrl RTSP/1.0\r\n" +
                "CSeq: ${++outCseq}\r\n" +
                "Session: $sessionId\r\n\r\n"
        )
    }

    /**
     * v1.2.36：按设置生成 wfd_video_formats。
     *
     * 字段：native / preferred-display-mode / profile / level / CEA / VESA / HH /
     *      latency / min-slice-size / slice-enc-params / frame-rate-control /
     *      max-hres / max-vres
     *
     * 1920×1200 走 **VESA 位图**（bit24 = p30，bit25 = p60 → 0x03000000）。
     * CEA 表里没有 16:10 的分辨率，所以这一档必须清空 CEA 位、只用 VESA。
     */
    private fun videoFormats(): String {
        // 调试口子：/data/local/tmp/wfd_formats.txt 存在时直接用它（免重编译试不同能力集）
        val override = readFormatOverride()
        if (override != null) {
            Timber.i("Advertise WFD (override): $override")
            return override
        }
        // ⚠️ displayMetrics 是「可用区域」（少状态栏），面板真实尺寸要 getRealSize
        val pt = android.graphics.Point()
        @Suppress("DEPRECATION")
        (context.getSystemService(Context.WINDOW_SERVICE) as android.view.WindowManager)
            .defaultDisplay.getRealSize(pt)
        val nw = maxOf(pt.x, pt.y)
        val nh = minOf(pt.x, pt.y)

        when (AppSettings.getWfdResolution(context)) {
            // 1 = 1920×1200（VESA 档，PC 用）
            1 -> {
                // v1.2.41：**根因找到了 —— 是位表写错了，不是 Windows 的问题。**
                //   Wi-Fi Display 规范 Table 35（VESA 表）：
                //     bit 24/25 = 1680×1024（p30/p60）
                //     bit 28/29 = **1920×1200**（p30/p60）
                //   之前一直报的是 03000000（bit24/25，即 1680×1024）—— 所以 Windows
                //   永远只给到 1600×1024 那个档位（1680 系），根本不存在 1920×1200。
                //   现在只报 bit28/29，CEA 清零，上限卡 1920×1200
                //   ⇒ Windows 的「显示器分辨率」下拉里应只剩 1920×1200。
                Timber.i("Advertise WFD 1920x1200 (vesa bit28/29, no cea, cap 1920x1200)")
                return "00 00 02 10 00000000 30000000 00000000 00 0000 0000 00 0780 04B0"
            }
            // 2 = 源设备原生：由 Source 按它自己的面板分辨率编码（手机 3200×1440 就是 1440p）
            2 -> {
                // native 置 1；后两项 max-hres/max-vres 是**本机解码上限**，防止 Source 直接怼 4K。
                // 3840×2160 = 0F00 0870 —— 这是 vendor media_codecs.xml 里 AVC 硬解的 hard limit。
                // CEA/VESA 仍然保留作退路：Source 不认 native 时还能退回 1080P/1200P，
                // 不至于协商失败黑屏。
                Timber.i("Advertise WFD native (source native, cap 3840x2160)")
                return "01 00 02 10 000001C0 03000000 00000000 00 0000 0000 00 0F00 0870"
            }
            else -> {
                Timber.i("Advertise WFD 1920x1080 (cea)")
                return "00 00 02 10 000001C0 00000000 00000000 00 0000 0000 00 none none"
            }
        }
    }

    /** 调试用：读 /data/local/tmp/wfd_formats.txt 覆盖能力集（一行，写完重连即生效）。 */
    private fun readFormatOverride(): String? = try {
        val f = java.io.File("/data/local/tmp/wfd_formats.txt")
        if (f.isFile) f.readText().trim().replace("\n", "").takeIf { it.isNotEmpty() } else null
    } catch (t: Throwable) {
        null
    }

    // ─── 响应构造 ───────────────────────────────────────────────────────────
    private fun sendOk(cseq: String, extraHeaders: String = "") =
        send("RTSP/1.0 200 OK\r\nCSeq: $cseq\r\n$extraHeaders\r\n")

    /**
     * M3 能力响应：Source 问什么答什么，不认识的参数直接不答。
     * 实测 Windows 会问 27 项（含 wfd2_* / intel_* / microsoft_* 私有扩展），
     * 只回下面这几项标准参数它照样接受并推进到 M4。
     */
    private fun sendCapabilities(cseq: String) {
        val body = buildString {
            append("wfd_video_formats: ${videoFormats()}\r\n")
            append("wfd_audio_codecs: $AUDIO_CODECS\r\n")
            // 关键：告诉 Source 往哪个 UDP 端口发 RTP，缺了这项收不到画面
            append("wfd_client_rtp_ports: RTP/AVP/UDP;unicast $rtpPort 0 mode=play\r\n")
            append("wfd_content_protection: none\r\n")
            append("wfd_display_edid: none\r\n")
            // MS600: 声明支持反向控制（UIBC）。端口填 none —— Sink 不监听；
            // 是 Source 在 M4/M15 里给出它自己的端口让本机去连。
            //
            // capability 同时报 Mouse / SingleTouch / MultiTouch：只报 Mouse 的话 Source 会把
            // 本机输入当"鼠标指针"处理，只有点击/双击/长按这类操作，滑动等触摸手势不完整；
            // 报上触摸类型后由 Source 挑它支持的那一个（它的选择会出现在 M4 响应里）。
            // MS600 v150a: **不再声明 Mouse**。
            //   实测教训：本机发包用的是 13 字节的**触摸**格式
            //   （[type][len2][触点数][id][x2][y2]），而 Mouse 的 payload 是
            //   [button][x2][y2] 共 5 字节。两者不兼容 —— 只要 Source 选了 Mouse，
            //   点击可能碰巧生效，**滑动则完全无效**（正是 C2 现象）。
            //   只报触摸后，Source 只能选 SingleTouch/MultiTouch，格式就唯一了。
            append(
                "wfd_uibc_capability: input_category_list=GENERIC;" +
                    "generic_cap_list=Mouse;" +
                    "hidc_cap_list=none;port=none\r\n"
            )
            append("wfd_connector_type: 05\r\n")
        }
        val bytes = body.toByteArray(StandardCharsets.UTF_8)
        send(
            "RTSP/1.0 200 OK\r\n" +
                "CSeq: $cseq\r\n" +
                "Content-Type: text/parameters\r\n" +
                "Content-Length: ${bytes.size}\r\n\r\n" +
                body
        )
    }

    // ─── 解析辅助 ───────────────────────────────────────────────────────────
    private fun header(msg: String, name: String): String? =
        Regex("(?i)^$name:\\s*(.+)$", RegexOption.MULTILINE)
            .find(msg)?.groupValues?.get(1)?.trim()

    private fun param(msg: String, name: String): String? =
        Regex("(?i)^$name:\\s*(.+)$", RegexOption.MULTILINE)
            .find(msg)?.groupValues?.get(1)?.trim()

    private fun startPlayerActivity() {
        val intent = Intent(context, com.iflytek.ms600.cast.ui.PlayerActivity::class.java).apply {
            putExtra(com.iflytek.ms600.cast.ui.PlayerActivity.EXTRA_SOURCE_TYPE, "MIRACAST")
            putExtra(com.iflytek.ms600.cast.ui.PlayerActivity.EXTRA_RTP_PORT, rtpPort)
            putExtra(com.iflytek.ms600.cast.ui.PlayerActivity.EXTRA_SESSION_ID, sessionId)
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP
        }
        context.startActivity(intent)
    }

    fun close() {
        try {
            socket.close()
        } catch (e: Exception) {
            Timber.e(e, "Error closing WFD session socket")
        }
    }
}
