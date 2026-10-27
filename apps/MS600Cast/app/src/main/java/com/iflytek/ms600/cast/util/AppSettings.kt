package com.iflytek.ms600.cast.util

import android.content.Context

/**
 * 应用设置（用户可在主界面里改的开关）。
 *
 * 单独放在 SharedPreferences 里，和 AirPlay 配对信息、设备 UUID 那几个
 * 内部用的 prefs 文件分开，避免清配对时误删用户设置。
 */
object AppSettings {

    private const val PREFS_NAME = "miracast_settings"
    private const val KEY_AUTO_START_ON_BOOT = "auto_start_on_boot"
    private const val KEY_DEVICE_NAME = "device_name"
    private const val KEY_WFD_RESOLUTION = "wfd_resolution"
    private const val KEY_MIRROR_SCALE_MODE = "mirror_scale_mode"
    private const val KEY_MIRROR_CUT_W = "mirror_cut_w_index"
    private const val KEY_MIRROR_CUT_H = "mirror_cut_h_index"
    private const val KEY_UIBC_ENABLED = "mirror_uibc_enabled"
    private const val KEY_UIBC_PROFILE = "mirror_uibc_profile"

    /**
     * 是否开机自动启动接收服务。
     *
     * 默认开启：这个应用装在电视上就是当常驻投屏接收器用的，
     * 每次重启电视都要手动打开一次不符合使用场景。
     */
    fun isAutoStartOnBoot(context: Context): Boolean =
        prefs(context).getBoolean(KEY_AUTO_START_ON_BOOT, true)

    fun setAutoStartOnBoot(context: Context, enabled: Boolean) {
        prefs(context).edit().putBoolean(KEY_AUTO_START_ON_BOOT, enabled).apply()
    }

    /**
     * MS600: 用户自定义的投屏设备名（Miracast / DLNA / AirPlay 都会用这个名字）。
     * 未设置时返回 null，由 [com.iflytek.ms600.cast.discovery.DeviceInfoProvider] 回退到系统名。
     */
    fun getCustomDeviceName(context: Context): String? =
        prefs(context).getString(KEY_DEVICE_NAME, null)?.trim()?.takeIf { it.isNotEmpty() }

    /** 传入空白或 null 表示恢复使用系统默认名称。 */
    fun setCustomDeviceName(context: Context, name: String?) {
        val trimmed = name?.trim()
        prefs(context).edit().apply {
            if (trimmed.isNullOrEmpty()) remove(KEY_DEVICE_NAME) else putString(KEY_DEVICE_NAME, trimmed)
        }.apply()
    }

    /**
     * MS600: 镜像画面的缩放模式。
     * 0 = 适应（等比留边）1 = 铺满（等比裁切）2 = 16:9 3 = 拉伸
     *
     * 旧的「自动裁切(4)」已移除（探测在这台机器上无法稳定：第二个解码器硬件实例渲染不出、
     * 软件实例解一帧就进错误态，PixelCopy 方案又会卡顿）。读到越界值一律回退到"适应"。
     */
    fun getMirrorScaleMode(context: Context): Int {
        val v = prefs(context).getInt(KEY_MIRROR_SCALE_MODE, MIRROR_SCALE_FIT)
        return if (v in 0 until MIRROR_SCALE_COUNT) v else MIRROR_SCALE_FIT
    }

    fun setMirrorScaleMode(context: Context, mode: Int) {
        prefs(context).edit().putInt(KEY_MIRROR_SCALE_MODE, mode).apply()
    }

    /**
     * MS600: 向 Source（手机 / 电脑）广播的投屏分辨率。
     *
     * 0 = 1920×1080（默认，手机通用，CEA 标准档）
     * 1 = 1920×1200（VESA 档，PC 投屏用 —— 正好等于本机面板，PC 那边把分辨率设成
     *     1920×1200 就能用满整块屏，不会上下留黑边）
     * 2 = 设备原生（从面板实际尺寸算，本机也是 1920×1200）
     *
     * ⚠️ 只广播选中的那一档：选了 1200 但 Source 不支持 VESA 就会协商失败，
     * 那时改回 1080 即可。
     */
    fun getWfdResolution(context: Context): Int {
        val v = prefs(context).getInt(KEY_WFD_RESOLUTION, 0)
        return if (v in 0..2) v else 0
    }

    fun setWfdResolution(context: Context, mode: Int) {
        prefs(context).edit().putInt(KEY_WFD_RESOLUTION, mode.coerceIn(0, 2)).apply()
    }

    /**
     * 左右 / 上下裁切挡位（索引指向 [CUT_W_STEPS] / [CUT_H_STEPS]）。
     *
     * 手动挡位取代原来的自动探测：用户点一下换一档，零开销、零抖动、零卡顿。
     * 竖屏手机投横屏时左右约 37%，横屏全屏视频常见左右各 10% + 上下各 10%。
     */
    fun getMirrorCutW(context: Context): Int =
        prefs(context).getInt(KEY_MIRROR_CUT_W, 0).coerceIn(0, CUT_W_STEPS.size - 1)

    fun setMirrorCutW(context: Context, index: Int) {
        prefs(context).edit().putInt(KEY_MIRROR_CUT_W, index).apply()
    }

    fun getMirrorCutH(context: Context): Int =
        prefs(context).getInt(KEY_MIRROR_CUT_H, 0).coerceIn(0, CUT_H_STEPS.size - 1)

    fun setMirrorCutH(context: Context, index: Int) {
        prefs(context).edit().putInt(KEY_MIRROR_CUT_H, index).apply()
    }

    /**
     * 反向控制（UIBC）总开关。默认开 —— 只有 Source 主动激活 UIBC 时才会真正生效，
     * 不支持 UIBC 的设备完全不受影响；参数面板里可以随时关掉兜底。
     */
    fun isUibcEnabled(context: Context): Boolean =
        prefs(context).getBoolean(KEY_UIBC_ENABLED, true)

    fun setUibcEnabled(context: Context, enabled: Boolean) {
        prefs(context).edit().putBoolean(KEY_UIBC_ENABLED, enabled).apply()
    }

    /**
     * 反向控制（UIBC）报文格式。
     *
     * Source 到底按 Mouse 还是 Touch 解析我们的包，各家实现不一致（手机不回 M4 的
     * wfd_uibc_capability，就无从得知）。所以留三套格式在菜单里切换，实测哪套能点又能滑。
     * 0 = Mouse 5 字节（现状，实测能点）｜1 = Mouse 规范格式（按下/抬起无 payload，移动 4 字节）
     * ｜2 = Touch（type 4/5/6 + 触点数/指针 id/xy）
     */
    fun getUibcProfile(context: Context): Int =
        prefs(context).getInt(KEY_UIBC_PROFILE, 0)

    fun setUibcProfile(context: Context, profile: Int) {
        prefs(context).edit().putInt(KEY_UIBC_PROFILE, profile).apply()
    }

    const val MIRROR_SCALE_FIT = 0
    const val MIRROR_SCALE_FILL = 1
    const val MIRROR_SCALE_16_9 = 2
    const val MIRROR_SCALE_STRETCH = 3
    const val MIRROR_SCALE_COUNT = 4

    /**
     * 左右裁切挡位：每边裁掉的百分比。0 表示不裁。
     *
     * 33/35/37 这三档是专门留给竖屏手机的：9:20 的手机塞进 16:9 流，左右各空
     * (1 - 0.45/1.778) / 2 ≈ 37%，9:16 的约 34%。挡位只给 5% 步进时只能选到 35 或 40，
     * 前者留一条 2% 的残边、后者会切掉一点画面，所以中间补细。
     */
    val CUT_W_STEPS = intArrayOf(0, 5, 10, 15, 20, 25, 30, 33, 35, 37, 40)

    /** 上下裁切挡位：每边裁掉的百分比（黑边一般比左右窄，挡位细一些）。 */
    val CUT_H_STEPS = intArrayOf(0, 3, 5, 8, 10, 12, 15, 20)

    private fun prefs(context: Context) =
        context.applicationContext.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
}
