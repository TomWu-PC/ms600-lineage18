package com.iflytek.ms600.cast.miracast

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.wifi.WifiManager
import android.net.wifi.p2p.WifiP2pDevice
import android.net.wifi.p2p.WifiP2pGroup
import android.net.wifi.p2p.WifiP2pManager
import android.net.wifi.p2p.nsd.WifiP2pDnsSdServiceInfo
import androidx.core.content.ContextCompat
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.os.Message
import android.os.Messenger
import com.iflytek.ms600.cast.airplay.StreamStats
import timber.log.Timber

/**
 * Wi-Fi Direct (P2P) 管理器 —— Miracast/WFD 设备发现。
 *
 * MS600 相对上游的修正（原版在真机上"时好时坏"都源于这些时序问题）：
 *  1. **等 P2P 进入 ENABLED 再 createGroup** —— 刚 enable 的瞬间调用会返回 BUSY；
 *  2. **广播接收器只注册一次** —— 重试时重复注册会叠加监听、加剧状态抖动；
 *  3. **createGroup 未返回前不并发重发** —— 否则 BUSY；
 *  4. **WFD IE 在建组成功之后设置** —— 建组会重置 wfdInfo（实测原顺序导致 wfdInfo=null）；
 *  5. **建组成功后再注册本地服务** —— 同样避免 BUSY。
 *
 * @param deviceName 对外显示的 P2P 设备名（手机/Windows 投屏列表里显示的即它）。
 */
class WifiDirectManager(
    private val context: Context,
    private val deviceName: String
) {
    /**
     * 不少老电视（尤其非 Android TV 认证的整机）根本没有 Wi-Fi Direct，
     * `getSystemService` 会返回 null。非空强转会在启动时直接闪退 ——
     * 而 Miracast 只是三种投屏方式之一，不该拖垮整个应用。
     */
    private val manager: WifiP2pManager? by lazy {
        context.getSystemService(Context.WIFI_P2P_SERVICE) as? WifiP2pManager
    }

    private var channel: WifiP2pManager.Channel? = null
    private var receiver: BroadcastReceiver? = null

    private var isStarted = false
    private var groupReady = false
    private var receiverRegistered = false
    private var groupRequestPending = false
    private var p2pEnabled = false
    private var localServiceRegistered = false

    /** 连续建组失败次数 —— 达到阈值就说明不是"等一会儿就好"，改用 WiFi 重启兜底。 */
    private var groupFailCount = 0

    /** 正在进行 WiFi 重启兜底，避免并发重入。 */
    private var wifiRestartPending = false

    var onDeviceConnected: ((WifiP2pDevice) -> Unit)? = null
    var onDeviceDisconnected: (() -> Unit)? = null
    var onGroupCreated: ((WifiP2pGroup) -> Unit)? = null

    fun start() {
        if (isStarted && groupReady) {
            Timber.w("Wi-Fi Direct already started (group ready)")
            return
        }
        val retrying = isStarted && !groupReady
        if (retrying) {
            Timber.w("Wi-Fi Direct previously started but group not ready, retrying（已连续失败 $groupFailCount 次）")
        }

        val p2p = manager
        if (p2p == null) {
            Timber.w("本机不支持 Wi-Fi Direct，Miracast 不可用（AirPlay / DLNA 不受影响）")
            return
        }

        try {
            if (channel == null) {
                channel = p2p.initialize(context, Looper.getMainLooper(), null)
            }
            if (channel == null) {
                Timber.e("Failed to initialize Wi-Fi P2P channel")
                return
            }

            registerReceiver()   // 内部只注册一次
            isStarted = true
            Timber.i("Wi-Fi Direct started for Miracast")

            // MS600 自愈：安装 APK / force-stop 应用后，系统会把 P2P 打成 P2pDisabledState，
            // 而且**不会再补发** ENABLED 广播 ⇒ 只等广播的实现会永久卡死（createGroup 一直 BUSY、
            // 手机搜不到本机、只能靠重启 Wi-Fi 或重启设备恢复）。这里主动调一次 enableP2p
            // （@SystemApi，需 NETWORK_SETTINGS；已启用时重复调用无副作用）。
            ensureP2pEnabled()

            // 连续多次建组失败 ⇒ 多半是内核里残留了一个 DOWN 状态的 p2p0，supplicant 建不出新接口
            // （日志 `Failed to setup P2p iface in supplicant`）。这种残留只能靠重启 wpa_supplicant
            // 清掉，也就是 `svc wifi disable/enable` 之所以有效的原因 —— 这里用 WiFi 重启兜底。
            if (retrying && groupFailCount >= 3) tryWifiRestartFallback()

            // MS600: 不在此处直接建组 —— 等 P2P ENABLED 广播后再建（见 maybeCreateGroup）
            maybeCreateGroup()
        } catch (e: Exception) {
            Timber.e(e, "Failed to start Wi-Fi Direct")
        }
    }

    /**
     * MS600 自愈：主动把 Wi-Fi Direct 打回 ENABLED。
     *
     * 背景：`enableP2p` 是 Android 10 起加入的 @SystemApi（需要 `NETWORK_SETTINGS`，本应用已声明）。
     * P2P 一旦被系统关成 `P2pDisabledState`（安装 APK / force-stop 应用后就会这样），
     * **不会再补发** ENABLED 广播，只"等"是等不来的。
     *
     * 不同版本的签名不一致（Android 10/11 是 `enableP2p(Channel)`，没有 ActionListener），
     * 所以这里**按方法名遍历**挑重载，不硬编码参数列表。
     */
    private fun ensureP2pEnabled() {
        val p2p = manager ?: return
        val ch = channel ?: return
        if (tryEnableP2pViaApi(p2p, ch)) return
        // 本机（LineageOS 18.1 / Android 11）的 WifiP2pManager 没有 enableP2p，
        // 只能走状态机这条路。
        tryEnableP2pViaStateMachine(p2p)
    }

    /** 首选路径：新版系统上的 `enableP2p`（按方法名遍历，兼容不同签名）。 */
    private fun tryEnableP2pViaApi(p2p: WifiP2pManager, ch: WifiP2pManager.Channel): Boolean {
        return try {
            val method = WifiP2pManager::class.java.methods
                .filter {
                    it.name == "enableP2p" &&
                        it.parameterTypes.isNotEmpty() &&
                        WifiP2pManager.Channel::class.java.isAssignableFrom(it.parameterTypes[0])
                }
                .minByOrNull { it.parameterTypes.size } ?: return false

            val args = arrayOfNulls<Any?>(method.parameterTypes.size)
            args[0] = ch
            for (i in 1 until args.size) {
                args[i] = object : WifiP2pManager.ActionListener {
                    override fun onSuccess() = Timber.i("P2P 自愈：enableP2p 回调成功")
                    override fun onFailure(reason: Int) =
                        Timber.w("P2P 自愈：enableP2p 回调失败（${reasonText(reason)}）")
                }
            }
            method.invoke(p2p, *args)
            Timber.i("P2P 自愈：已调用 enableP2p(${method.parameterTypes.joinToString { it.simpleName }})")
            Handler(Looper.getMainLooper()).postDelayed({ maybeCreateGroup() }, 1500)
            true
        } catch (e: Exception) {
            Timber.w("P2P 自愈：enableP2p 调用失败（${e.javaClass.simpleName}: ${e.message}）")
            false
        }
    }

    /**
     * 兜底路径：通过 `getP2pStateMachineMessenger()`（@hide，需要 NETWORK_SETTINGS）拿到
     * P2P 状态机的 Messenger，直接给它发"启用 P2P"消息。
     *
     * what 值 0x23010 是从本机 `dumpsys wifip2p` 的状态迁移记录反推出来的：
     * ```
     * P2pDisabledState → InactiveState   what=143376(0x23010)
     * ```
     * 语义完全吻合（启用后进入 InactiveState，随后才能建组）。即使这个值在别的版本上不对，
     * 最坏也只是状态机记录一条"未处理消息"后忽略，不会崩。
     */
    private fun tryEnableP2pViaStateMachine(p2p: WifiP2pManager) {
        try {
            val method = WifiP2pManager::class.java.getMethod("getP2pStateMachineMessenger")
            val messenger = method.invoke(p2p) as? Messenger
            if (messenger == null) {
                Timber.w("P2P 自愈：拿不到 P2P 状态机 Messenger")
                return
            }
            messenger.send(Message.obtain(null, P2P_ENABLE_WHAT))
            Timber.i("P2P 自愈：已向 P2P 状态机发送 ENABLE_P2P(0x${P2P_ENABLE_WHAT.toString(16)})")
            Handler(Looper.getMainLooper()).postDelayed({ maybeCreateGroup() }, 2000)
        } catch (e: Exception) {
            Timber.w("P2P 自愈：状态机兜底失败（${e.javaClass.simpleName}: ${e.message}）")
        }
    }

    /** MS600: P2P 已就绪、且没有未返回的建组请求时，才发起 createGroup。 */
    private fun maybeCreateGroup() {
        if (groupReady) return
        if (groupRequestPending) {
            Timber.d("createGroup already pending, skip")
            return
        }
        val ch = channel ?: return
        // MS600: 不能只等 ENABLED 广播 —— App 启动时 P2P 往往已启用，那条广播早已发过、
        // 不会再补发（实测始终收不到，导致永远不建组）。这里只要 WiFi 处于开启状态就尝试建组，
        // 失败（如刚 enable 时的 BUSY）由上层的定时重试兜底。
        if (!p2pEnabled && !isWifiEnabled()) {
            Timber.i("WiFi/P2P 尚未就绪，等待")
            return
        }

        groupRequestPending = true
        try {
            manager?.createGroup(ch, object : WifiP2pManager.ActionListener {
                override fun onSuccess() {
                    groupRequestPending = false
                    groupReady = true
                    groupFailCount = 0
                    Timber.i("Wi-Fi Direct group created successfully")

                    // 建组会重置 wfdInfo ⇒ 建组之后再设 WFD IE
                    setWfdInfo()

                    manager?.requestGroupInfo(ch) { group ->
                        if (group != null) {
                            groupReady = true
                            publishGroupFrequency(group)
                            Timber.i("Group created - SSID: ${group.networkName}, Owner: ${group.isGroupOwner}")
                            onGroupCreated?.invoke(group)
                            setDeviceName(deviceName)
                        }
                    }

                    // 建组成功后再注册本地服务（避免 BUSY）
                    registerLocalService()
                }

                override fun onFailure(reason: Int) {
                    groupRequestPending = false
                    groupFailCount++
                    Timber.e("Failed to create Wi-Fi Direct group: ${reasonText(reason)}（连续 $groupFailCount 次）")
                    // MS600: 已有组存在时 createGroup 会返回 BUSY —— 直接沿用现有组，
                    // 否则重试永远 BUSY、WFD IE 也永远设不上。
                    if (reason == WifiP2pManager.BUSY) {
                        manager?.requestGroupInfo(ch) { group ->
                            if (group != null && group.isGroupOwner) {
                                groupReady = true
                                groupFailCount = 0
                                publishGroupFrequency(group)
                                Timber.i("Existing P2P group found: ${group.networkName}")
                                setWfdInfo()
                                onGroupCreated?.invoke(group)
                                registerLocalService()
                            }
                        }
                    }
                }
            })
        } catch (e: SecurityException) {
            groupRequestPending = false
            Timber.e(e, "Security exception when creating group - missing permissions?")
        } catch (e: Exception) {
            groupRequestPending = false
            Timber.e(e, "Exception when creating group")
        }
    }

    /**
     * MS600: 把 P2P 组的工作频率发布给 UI（投屏参数面板显示"投屏链路走哪个频段/信道"）。
     * WifiP2pGroup.getFrequency() 是 API 23 才有的，低版本忽略。
     */
    private fun publishGroupFrequency(group: WifiP2pGroup) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) return
        try {
            val f = group.frequency
            if (f > 0) {
                StreamStats.p2pFrequencyMhz = f
                Timber.i("P2P group frequency: ${f}MHz")
            }
        } catch (e: Exception) {
            Timber.w(e, "read group frequency failed")
        }
    }

    /**
     * 最后的兜底：重启一次 WiFi。
     *
     * 为什么需要：P2P 接口创建失败的根因是内核里**残留了一个 DOWN 状态的 `p2p0`**
     * （系统日志 `WifiP2pNative: Failed to setup P2p iface in supplicant`，
     *  `ip link` 能看到 `p2p0: <NO-CARRIER,…> state DOWN`）。删残留接口需要 NET_ADMIN，
     * 普通应用做不到，**只有重启 wpa_supplicant 才能清掉它** —— 这也正是
     * `svc wifi disable/enable` 一直能修好的原因。
     *
     * 本应用是 priv-app 且持有 `NETWORK_SETTINGS` + `CHANGE_WIFI_STATE`，
     * `setWifiEnabled` 对特权应用是放行的；返回 false（系统拒绝）就放弃，不做无意义重试。
     */
    private fun tryWifiRestartFallback() {
        if (wifiRestartPending) return
        val wm = context.getSystemService(Context.WIFI_SERVICE) as? WifiManager ?: return
        try {
            @Suppress("DEPRECATION")
            if (!wm.isWifiEnabled) {
                Timber.w("P2P 自愈：WiFi 本来就是关的，跳过 WiFi 重启兜底")
                return
            }
            wifiRestartPending = true
            Timber.w("P2P 自愈：连续建组失败，改用 WiFi 重启兜底（清理残留的 p2p0）")
            @Suppress("DEPRECATION")
            val offOk = wm.setWifiEnabled(false)
            Timber.i("P2P 自愈：setWifiEnabled(false) = $offOk")
            if (!offOk) {
                // 系统不允许（罕见：多半是权限被裁剪）—— 复位标志，等下一次重试再说
                wifiRestartPending = false
                return
            }
            Handler(Looper.getMainLooper()).postDelayed({
                try {
                    @Suppress("DEPRECATION")
                    val onOk = wm.setWifiEnabled(true)
                    Timber.i("P2P 自愈：setWifiEnabled(true) = $onOk")
                } catch (e: Exception) {
                    Timber.w("P2P 自愈：重新打开 WiFi 失败（${e.message}）")
                } finally {
                    wifiRestartPending = false
                    groupFailCount = 0
                }
            }, 4000)
        } catch (e: Exception) {
            wifiRestartPending = false
            Timber.w("P2P 自愈：WiFi 重启兜底失败（${e.javaClass.simpleName}: ${e.message}）")
        }
    }

    private companion object {
        /**
         * "启用 P2P"消息的 what 值（发给 P2P 状态机用的兜底路径）。
         *
         * 由本机 `dumpsys wifip2p` 的状态迁移记录反推：
         * ```
         * P2pDisabledState → InactiveState   what=143376(0x23010)
         * ```
         * 语义完全吻合：启用之后才会进入 InactiveState，随后才能建组。
         */
        const val P2P_ENABLE_WHAT = 0x23010
    }

    private fun reasonText(reason: Int): String = when (reason) {
        WifiP2pManager.ERROR -> "ERROR"
        WifiP2pManager.P2P_UNSUPPORTED -> "P2P_UNSUPPORTED"
        WifiP2pManager.BUSY -> "BUSY"
        else -> "UNKNOWN($reason)"
    }

    /** MS600: WiFi 是否开启（P2P 随之启用）。用于收不到状态广播时的主动判断。 */
    private fun isWifiEnabled(): Boolean = try {
        (context.getSystemService(Context.WIFI_SERVICE)
                as? android.net.wifi.WifiManager)?.isWifiEnabled ?: false
    } catch (e: Exception) {
        false
    }

    private fun setWfdInfo() {
        val ch = channel ?: return

        try {
            val wfdInfoClass = Class.forName("android.net.wifi.p2p.WifiP2pWfdInfo")
            val wfdInfo = wfdInfoClass.newInstance()

            // MS600: Android 9 起 setWfdEnabled 改名为 setEnabled，旧名反射必抛 NoSuchMethodException
            val setEnabledMethod = try {
                wfdInfoClass.getMethod("setEnabled", Boolean::class.java)
            } catch (e: NoSuchMethodException) {
                wfdInfoClass.getMethod("setWfdEnabled", Boolean::class.java)
            }
            setEnabledMethod.invoke(wfdInfo, true)

            // 注意：PRIMARY_SINK = 1, SECONDARY_SINK = 2, SOURCE = 0
            val setDeviceTypeMethod = wfdInfoClass.getMethod("setDeviceType", Int::class.java)
            setDeviceTypeMethod.invoke(wfdInfo, 1)  // 1 = PRIMARY_SINK

            val setSessionAvailableMethod = wfdInfoClass.getMethod("setSessionAvailable", Boolean::class.java)
            setSessionAvailableMethod.invoke(wfdInfo, true)

            val setControlPortMethod = wfdInfoClass.getMethod("setControlPort", Int::class.java)
            setControlPortMethod.invoke(wfdInfo, 7236)  // RTSP 端口

            val setMaxThroughputMethod = wfdInfoClass.getMethod("setMaxThroughput", Int::class.java)
            setMaxThroughputMethod.invoke(wfdInfo, 50)  // 50 Mbps

            val setWFDInfoMethod = WifiP2pManager::class.java.getMethod(
                "setWFDInfo",
                WifiP2pManager.Channel::class.java,
                wfdInfoClass,
                WifiP2pManager.ActionListener::class.java
            )

            setWFDInfoMethod.invoke(manager, ch, wfdInfo, object : WifiP2pManager.ActionListener {
                override fun onSuccess() {
                    Timber.i("WFD Info set successfully — 发送端可发现本机")
                }

                override fun onFailure(reason: Int) {
                    Timber.e("Failed to set WFD Info: ${reasonText(reason)}")
                }
            })
        } catch (e: SecurityException) {
            Timber.e(e, "SecurityException: setWFDInfo 需要 CONFIGURE_WIFI_DISPLAY 权限")
        } catch (e: ClassNotFoundException) {
            Timber.e(e, "WifiP2pWfdInfo class not found")
        } catch (e: NoSuchMethodException) {
            Timber.e(e, "setWFDInfo method not found")
        } catch (e: Exception) {
            Timber.e(e, "Error setting WFD Info")
        }
    }

    /**
     * 把 P2P 设备名改成 [deviceName]（手机投屏列表里显示的就是它）。
     * 需要 NETWORK_SETTINGS（本 ROM 已给本应用授予）。
     */
    private fun setDeviceName(name: String) {
        try {
            val setDeviceNameMethod = WifiP2pManager::class.java.getMethod(
                "setDeviceName",
                WifiP2pManager.Channel::class.java,
                String::class.java,
                WifiP2pManager.ActionListener::class.java
            )

            setDeviceNameMethod.invoke(manager, channel, name, object : WifiP2pManager.ActionListener {
                override fun onSuccess() {
                    Timber.i("Device name set to: $name")
                }

                override fun onFailure(reason: Int) {
                    Timber.w("Failed to set device name: $reason")
                }
            })
        } catch (e: Exception) {
            Timber.w(e, "Could not set device name (requires system permissions)")
        }
    }

    private fun registerLocalService() {
        if (localServiceRegistered) return
        val ch = channel ?: return

        try {
            val record = mapOf(
                "version" to "1.0",
                "type" to "miracast-sink",
                "rtsp_port" to "7236"
            )

            val serviceInfo = WifiP2pDnsSdServiceInfo.newInstance(
                "_miracast", "_tcp", record
            )

            manager?.addLocalService(ch, serviceInfo, object : WifiP2pManager.ActionListener {
                override fun onSuccess() {
                    localServiceRegistered = true
                    Timber.i("Local Miracast service registered")
                }

                override fun onFailure(reason: Int) {
                    Timber.e("Failed to register local service: $reason")
                }
            })

            manager?.discoverServices(ch, object : WifiP2pManager.ActionListener {
                override fun onSuccess() {
                    Timber.i("Service discovery started")
                }

                override fun onFailure(reason: Int) {
                    Timber.e("Failed to start service discovery: $reason")
                }
            })
        } catch (e: SecurityException) {
            Timber.w("注册 P2P 本地服务被拒绝，Miracast 不可用")
        } catch (e: Exception) {
            Timber.e(e, "Error registering local service")
        }
    }

    private fun registerReceiver() {
        if (receiverRegistered) {
            Timber.d("P2P receiver already registered, skip")
            return
        }

        val intentFilter = IntentFilter().apply {
            addAction(WifiP2pManager.WIFI_P2P_STATE_CHANGED_ACTION)
            addAction(WifiP2pManager.WIFI_P2P_PEERS_CHANGED_ACTION)
            addAction(WifiP2pManager.WIFI_P2P_CONNECTION_CHANGED_ACTION)
            addAction(WifiP2pManager.WIFI_P2P_THIS_DEVICE_CHANGED_ACTION)
        }

        receiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                when (intent.action) {
                    WifiP2pManager.WIFI_P2P_STATE_CHANGED_ACTION -> {
                        val state = intent.getIntExtra(WifiP2pManager.EXTRA_WIFI_STATE, -1)
                        p2pEnabled = state == WifiP2pManager.WIFI_P2P_STATE_ENABLED
                        Timber.d("Wi-Fi P2P state changed: ${if (p2pEnabled) "ENABLED" else "DISABLED"}")
                        // MS600: 就绪后才建组
                        if (p2pEnabled) maybeCreateGroup()
                    }

                    WifiP2pManager.WIFI_P2P_PEERS_CHANGED_ACTION -> {
                        Timber.d("Wi-Fi P2P peers changed")
                        channel?.let { ch ->
                            try {
                                manager?.requestPeers(ch) { peerList ->
                                    Timber.d("Peers discovered: ${peerList.deviceList.size}")
                                }
                            } catch (e: SecurityException) {
                                Timber.w("requestPeers 被拒绝（缺少定位权限）")
                            }
                        }
                    }

                    WifiP2pManager.WIFI_P2P_CONNECTION_CHANGED_ACTION -> {
                        Timber.d("Wi-Fi P2P connection changed")
                        channel?.let { ch ->
                            manager?.requestConnectionInfo(ch) { info ->
                                if (info.groupFormed) {
                                    Timber.i("P2P Group formed - Group Owner: ${info.isGroupOwner}")
                                    if (info.isGroupOwner) {
                                        Timber.i("This device is Group Owner, IP: ${info.groupOwnerAddress?.hostAddress}")
                                    }
                                } else {
                                    onDeviceDisconnected?.invoke()
                                }
                            }
                        }
                    }

                    WifiP2pManager.WIFI_P2P_THIS_DEVICE_CHANGED_ACTION -> {
                        val device = intent.getParcelableExtra<WifiP2pDevice>(WifiP2pManager.EXTRA_WIFI_P2P_DEVICE)
                        Timber.d("This device changed: ${device?.deviceName}, Status: ${device?.status}")
                    }
                }
            }
        }

        try {
            // 必须走 ContextCompat：带 flags 的 registerReceiver 重载是 API 26 才有的
            ContextCompat.registerReceiver(
                context, receiver, intentFilter, ContextCompat.RECEIVER_NOT_EXPORTED
            )
            receiverRegistered = true
            Timber.i("Wi-Fi P2P broadcast receiver registered")
        } catch (e: Exception) {
            Timber.e(e, "Failed to register Wi-Fi P2P receiver")
        }
    }

    fun stop() {
        if (!isStarted) return

        try {
            channel?.let { ch ->
                manager?.clearLocalServices(ch, object : WifiP2pManager.ActionListener {
                    override fun onSuccess() {
                        Timber.i("Local services cleared")
                    }

                    override fun onFailure(reason: Int) {
                        Timber.w("Failed to clear local services: $reason")
                    }
                })

                manager?.removeGroup(ch, object : WifiP2pManager.ActionListener {
                    override fun onSuccess() {
                        Timber.i("Wi-Fi Direct group removed")
                    }

                    override fun onFailure(reason: Int) {
                        Timber.w("Failed to remove group: $reason")
                    }
                })
            }

            receiver?.let {
                context.unregisterReceiver(it)
                receiver = null
            }

            channel = null
            isStarted = false
            groupReady = false
            receiverRegistered = false
            groupRequestPending = false
            localServiceRegistered = false
            p2pEnabled = false
            Timber.i("Wi-Fi Direct stopped")
        } catch (e: Exception) {
            Timber.e(e, "Error stopping Wi-Fi Direct")
        }
    }

    fun isRunning(): Boolean = isStarted && groupReady
}
