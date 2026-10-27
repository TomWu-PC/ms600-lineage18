package com.iflytek.ms600.settings;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.provider.Settings;

/**
 * MS600 v151: 开机后把 USB 模式选择写给守护脚本。
 *
 * v149 时这里是"无条件按开关写 mode"，现在改成：
 *   · auto       —— 什么都不做，交给 init 里的 ms600_usb_auto 服务（它按 VBUS 自动切）
 *   · host/从机  —— 立即写一次（none 中转），之后守护脚本会保持
 * 选择同时落到 files/usb_mode，脚本每秒读一次，避免它去碰 Settings（太慢）。
 */
public class BootReceiver extends BroadcastReceiver {

    private static final String KEY_USB_MODE = "ms600_usb_mode";

    @Override
    public void onReceive(Context c, Intent i) {
        if (c == null || i == null) {
            return;
        }
        if (!Intent.ACTION_BOOT_COMPLETED.equals(i.getAction())) {
            return;
        }
        try {
            String v = Settings.Global.getString(c.getContentResolver(), KEY_USB_MODE);
            if (!"host".equals(v) && !"peripheral".equals(v)) {
                v = "auto";
            }
            try {
                java.io.FileOutputStream out =
                        new java.io.FileOutputStream(new java.io.File(c.getFilesDir(), "usb_mode"), false);
                out.write(v.getBytes("UTF-8"));
                out.close();
            } catch (Throwable ignored) {
            }
            if (!"auto".equals(v)) {
                UsbHelper.rebootMode("host".equals(v) ? UsbHelper.MODE_HOST
                        : UsbHelper.MODE_PERIPHERAL);
            }
            android.util.Log.i("MS600Usb", "boot: usb_mode=" + v + " mode=" + UsbHelper.getMode());
        } catch (Throwable ignored) {
        }
    }
}
