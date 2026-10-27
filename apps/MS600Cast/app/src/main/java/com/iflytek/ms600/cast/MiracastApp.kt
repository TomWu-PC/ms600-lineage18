package com.iflytek.ms600.cast

import android.app.Application
import timber.log.Timber

/**
 * Miracast Receiver Application
 */
class MiracastApp : Application() {

    override fun onCreate() {
        super.onCreate()

        // MS600: release 版也输出到 logcat —— 原版只在 debug 输出，
        // 导致现场出问题时（如 P2P 建组失败）完全没有日志可查。
        Timber.plant(Timber.DebugTree())

        Timber.i("MiracastApp initialized")
    }
}
