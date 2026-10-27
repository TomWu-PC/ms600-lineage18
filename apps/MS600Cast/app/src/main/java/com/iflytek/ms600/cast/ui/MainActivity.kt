package com.iflytek.ms600.cast.ui

import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import android.text.InputType
import android.view.View
import android.widget.EditText
import android.widget.FrameLayout
import android.widget.ProgressBar
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.SwitchCompat
import androidx.core.content.ContextCompat
import com.iflytek.ms600.cast.R
import com.iflytek.ms600.cast.discovery.DeviceInfoProvider
import com.iflytek.ms600.cast.service.CastReceiverService
import com.iflytek.ms600.cast.util.AppSettings
import timber.log.Timber

/**
 * 投屏接收主界面（系统原生分栏样式）。
 *
 * 运行模型：
 *  - **按需运行**：默认不接收 —— 无常驻服务、无通知、不占用系统资源；
 *    打开「接收投屏」开关才开始接收，关闭立即完全停止。
 *  - 可修改投屏设备名称（Miracast / DLNA / AirPlay 共用）。
 */
class MainActivity : AppCompatActivity() {

    private lateinit var tvDeviceName: TextView
    private lateinit var tvStatus: TextView
    private lateinit var pbStatus: ProgressBar
    private lateinit var switchReceiving: SwitchCompat
    private lateinit var rowDeviceName: View
    private lateinit var rowWfdRes: View
    private lateinit var tvWfdRes: TextView

    private val handler = Handler(Looper.getMainLooper())

    /** 程序化改开关时抑制回调，避免和用户操作互相触发。 */
    private var suppressToggle = false

    private val poller = object : Runnable {
        override fun run() {
            refresh()
            handler.postDelayed(this, 1500)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        tvDeviceName = findViewById(R.id.tv_device_name)
        tvStatus = findViewById(R.id.tv_status)
        pbStatus = findViewById(R.id.pb_status)
        switchReceiving = findViewById(R.id.switch_receiving)
        rowDeviceName = findViewById(R.id.row_device_name)
        rowWfdRes = findViewById(R.id.row_wfd_res)
        tvWfdRes = findViewById(R.id.tv_wfd_res)

        refreshDeviceName()
        refreshWfdRes()

        rowDeviceName.setOnClickListener { showRenameDialog() }
        rowWfdRes.setOnClickListener { showWfdResDialog() }

        switchReceiving.setOnCheckedChangeListener { _, checked ->
            if (suppressToggle) return@setOnCheckedChangeListener
            if (checked) startReceiving() else stopReceiving()
            handler.postDelayed({ refresh() }, 400)
        }

        // 回显当前状态：服务在跑就把开关置为打开
        val running = isServiceRunning()
        suppressToggle = true
        switchReceiving.isChecked = running
        suppressToggle = false

        // 把当前真实状态同步回 Settings.Global（供「设备设置」显示）
        writeEnabled(running)

        // 服务没跑时清掉 Settings.Global 里可能残留的旧状态（进程被杀时来不及写 off）
        if (!running) {
            try {
                Settings.Global.putString(
                    contentResolver, CastReceiverService.SETTING_STATE, CastReceiverService.STATE_OFF
                )
            } catch (e: Exception) { }
        }
    }

    override fun onResume() {
        super.onResume()
        handler.post(poller)
    }

    override fun onPause() {
        super.onPause()
        handler.removeCallbacks(poller)
    }

    private fun refreshDeviceName() {
        tvDeviceName.text = DeviceInfoProvider(this).getDeviceName()
    }

    /**
     * 面板真实分辨率（横屏取向）。
     *
     * ⚠️ 不能用 `resources.displayMetrics`：它给的是**可用区域**（实测 1920×1178，
     * 少了状态栏那条），面板实际是 1920×1200。必须走 getRealSize。
     */
    @Suppress("DEPRECATION")
    private fun nativePanelSize(): Pair<Int, Int> {
        val p = android.graphics.Point()
        val wm = getSystemService(android.content.Context.WINDOW_SERVICE) as android.view.WindowManager
        wm.defaultDisplay.getRealSize(p)
        return maxOf(p.x, p.y) to minOf(p.x, p.y)
    }

    private fun refreshWfdRes() {
        tvWfdRes.text = when (AppSettings.getWfdResolution(this)) {
            1 -> getString(R.string.wfd_res_1200)
            2 -> getString(R.string.wfd_res_native)
            else -> getString(R.string.wfd_res_1080)
        }
    }

    /** 选广播分辨率。改完重启服务，下次投屏生效。 */
    private fun showWfdResDialog() {
        val labels = arrayOf(
            getString(R.string.wfd_res_1080),
            getString(R.string.wfd_res_1200),
            getString(R.string.wfd_res_native)
        )
        val current = AppSettings.getWfdResolution(this)
        AlertDialog.Builder(this)
            .setTitle(R.string.wfd_res_dialog_title)
            .setSingleChoiceItems(labels, current) { dialog, which ->
                AppSettings.setWfdResolution(this, which)
                refreshWfdRes()
                dialog.dismiss()
                // 一条提示就够（两条会叠在一起显示）
                val msg = when (which) {
                    0 -> getString(R.string.wfd_res_changed, labels[which])
                    1 -> getString(R.string.wfd_res_changed_warn, labels[which])
                    else -> getString(R.string.wfd_res_changed_native, labels[which])
                }
                Toast.makeText(this, msg, Toast.LENGTH_LONG).show()
                restartServiceIfRunning()
            }
            .setNegativeButton("取消", null)
            .show()
    }

    /** MS600: 修改投屏设备名称；服务在跑时自动重启一次让新名字立即生效。 */
    private fun showRenameDialog() {
        val current = DeviceInfoProvider(this).getDeviceName()
        val input = EditText(this).apply {
            inputType = InputType.TYPE_CLASS_TEXT
            setText(current)
            setSelection(text.length)
            hint = getString(R.string.device_name_label)
        }
        val container = FrameLayout(this).apply {
            val pad = (resources.displayMetrics.density * 20).toInt()
            setPadding(pad, pad / 2, pad, 0)
            addView(input)
        }

        AlertDialog.Builder(this)
            .setTitle(R.string.rename_dialog_title)
            .setMessage(R.string.rename_dialog_message)
            .setView(container)
            .setPositiveButton(R.string.ok) { _, _ ->
                val newName = input.text.toString().trim()
                if (newName.isEmpty()) {
                    Toast.makeText(this, R.string.rename_empty_toast, Toast.LENGTH_SHORT).show()
                    return@setPositiveButton
                }
                AppSettings.setCustomDeviceName(this, newName)
                refreshDeviceName()
                Toast.makeText(this, getString(R.string.rename_done_toast, newName), Toast.LENGTH_SHORT).show()
                restartServiceIfRunning()
            }
            .setNegativeButton(R.string.cancel, null)
            .show()
    }

    /** 名字在服务启动时读取，重启服务才能让 Miracast / DLNA / AirPlay 都换上新名字。 */
    private fun restartServiceIfRunning() {
        if (!isServiceRunning()) return
        Timber.i("MS600: 设备名称已改，重启接收服务")
        stopService(Intent(this, CastReceiverService::class.java))
        handler.postDelayed({
            ContextCompat.startForegroundService(
                this, Intent(this, CastReceiverService::class.java)
            )
            handler.postDelayed({ refresh() }, 500)
        }, 800)
    }

    private fun startReceiving() {
        Timber.i("MS600: 开始接收投屏")
        writeEnabled(true)
        ContextCompat.startForegroundService(
            this, Intent(this, CastReceiverService::class.java)
        )
    }

    private fun stopReceiving() {
        Timber.i("MS600: 停止接收投屏")
        writeEnabled(false)
        stopService(Intent(this, CastReceiverService::class.java))
    }

    /** 把"用户是否要接收"同步到 Settings.Global，供「设备设置」读取。 */
    private fun writeEnabled(on: Boolean) {
        try {
            Settings.Global.putInt(
                contentResolver, CastReceiverService.SETTING_ENABLED, if (on) 1 else 0
            )
        } catch (e: Exception) {
            Timber.w(e, "writeEnabled failed")
        }
    }

    /** 服务是否在运行：用同进程内的静态标志判断（进程被杀后不会残留旧状态）。 */
    private fun isServiceRunning(): Boolean = CastReceiverService.isRunning

    private fun readState(): String? = try {
        Settings.Global.getString(contentResolver, CastReceiverService.SETTING_STATE)
    } catch (e: Exception) {
        null
    }

    private fun refresh() {
        val running = isServiceRunning()
        if (switchReceiving.isChecked != running) {
            suppressToggle = true
            switchReceiving.isChecked = running
            suppressToggle = false
        }

        // 状态以"服务是否运行"为准 —— Settings.Global 在进程被杀时可能残留旧值
        when {
            !running -> {
                tvStatus.text = getString(R.string.status_stopped)
                pbStatus.visibility = View.GONE
            }
            readState() == CastReceiverService.STATE_CONNECTED -> {
                tvStatus.text = getString(R.string.status_connected)
                pbStatus.visibility = View.GONE
            }
            else -> {
                tvStatus.text = getString(R.string.status_waiting)
                pbStatus.visibility = View.VISIBLE
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        handler.removeCallbacksAndMessages(null)
    }
}
