package com.iflytek.ms600.settings;

import android.app.ActivityManager;
import android.content.Context;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;
import android.os.Environment;
import android.os.storage.StorageManager;
import android.os.storage.StorageVolume;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * MS600 v149: USB OTG 与「弹出设备」的公共逻辑。
 *
 * 关键事实（实测）：
 *   · 主机控制器 /sys/devices/soc/7000000.ssusb/mode 只认 host / peripheral；
 *     写其它值（如 otg）内核会落成 none —— **整个口断电**，等于把所有 USB 设备硬件弹出。
 *   · 该节点默认 root:root 0644，init.ms600.usb.rc 里 chmod 0666 之后 App 才能写。
 *   · U 盘这类大容量存储被 vold 接管，`UsbManager.getDeviceList()` 看不到，
 *     必须走 StorageManager 的 StorageVolume 判断；其它设备（网卡/手柄/键鼠）才走 UsbManager。
 */
public final class UsbHelper {

    public static final String MODE_PATH = "/sys/devices/soc/7000000.ssusb/mode";

    public static final String MODE_HOST = "host";
    public static final String MODE_PERIPHERAL = "peripheral";
    /**
     * MS600 v149f: 「关闭控制器」状态（写非 host/peripheral 的值，内核落成 none）。
     * ⚠️ 单独写这个值 **不会断 VBUS** —— 见 powerOff()。
     */
    public static final String MODE_OFF = "none";

    /** 弹出结果 */
    public static final int EJECT_NONE = 0;          // 没有可弹出的设备
    public static final int EJECT_STORAGE_OK = 1;    // 存储卷已卸载
    public static final int EJECT_STORAGE_FAIL = 2;  // 存储卷卸载失败
    public static final int EJECT_APP_STOPPED = 3;   // 已停止占用应用（非存储设备）

    private UsbHelper() {
    }

    // ------------------------------------------------------------ sysfs

    public static String getMode() {
        BufferedReader r = null;
        try {
            r = new BufferedReader(new InputStreamReader(new FileInputStream(MODE_PATH)));
            String s = r.readLine();
            return s == null ? "" : s.trim();
        } catch (Throwable t) {
            return "";
        } finally {
            try {
                if (r != null) {
                    r.close();
                }
            } catch (Throwable ignored) {
            }
        }
    }

    /** 写 host / peripheral / none；返回是否写入成功（sysfs 本身不报错时几乎总能成功）。 */
    public static boolean setMode(String mode) {
        FileOutputStream fos = null;
        try {
            fos = new FileOutputStream(MODE_PATH);
            fos.write(mode.getBytes("US-ASCII"));
            fos.flush();
            return true;
        } catch (Throwable t) {
            return false;
        } finally {
            try {
                if (fos != null) {
                    fos.close();
                }
            } catch (Throwable ignored) {
            }
        }
    }

    /** OTG 是否处于可用状态（host 或者读不到节点）。 */
    /**
     * MS600 v151: 带 none 中转的模式切换。
     *
     * 实测（2026-10-18）：直接 host -> peripheral 时，mode 读回是对的、present 也变 1，
     * 但 dumpsys usb 里 kernel_state=DISCONNECTED，PC 上根本看不到设备（adbd 不枚举）。
     * 先写 none 让控制器停一下，再写目标值就正常（CONFIGURED，adb 立刻出现）。
     */
    public static boolean rebootMode(String target) {
        setMode(MODE_OFF);
        try {
            Thread.sleep(700);
        } catch (InterruptedException ignored) {
        }
        return setMode(target);
    }

    public static boolean isOtgOn() {
        String m = getMode();
        if (m.isEmpty()) {
            return true;
        }
        return !MODE_PERIPHERAL.equals(m) && !MODE_OFF.equals(m);
    }

    public static boolean setOtgOn(boolean on) {
        return setMode(on ? MODE_HOST : MODE_PERIPHERAL);
    }

    /**
     * MS600 v149f: 真正的「端口断电」。
     *
     * 实测（2026-10-17）：
     *   · host        → usb_otg=1, smbcharger_charger_otg=enabled   （VBUS 供着电）
     *   · peripheral  → usb_otg=0, smbcharger_charger_otg=disabled  （VBUS 断了）
     *   · 从 host 直接写 none → usb_otg 仍是 1，**VBUS 没断**
     *     ⇒ 手柄接收器的灯照样亮，用户实测过
     *   · 先 peripheral 再 none → usb_otg=0 且控制器停止 ✓
     *
     * 所以必须先 peripheral（这一步 dwc3 才会通知 charger 关掉 OTG 升压），
     * 再 none（把 host 控制器也停掉，插电脑也不会被识别）。
     */
    public static boolean powerOff() {
        setMode(MODE_PERIPHERAL);
        return setMode(MODE_OFF);
    }

    // ------------------------------------------------------ MS600 v154 双 VBUS

    /** 充电器的 OTG 升压节点：1 = 正在向 USB 口输出 5V，0 = 已关。 */
    public static final String OTG_PATH = "/sys/class/power_supply/usb/usb_otg";

    /** 读 OTG 升压状态（读不到返回空串）。 */
    public static String getOtgBoost() {
        BufferedReader r = null;
        try {
            r = new BufferedReader(new InputStreamReader(new FileInputStream(OTG_PATH)));
            String s = r.readLine();
            return s == null ? "" : s.trim();
        } catch (Throwable t) {
            return "";
        } finally {
            try {
                if (r != null) {
                    r.close();
                }
            } catch (Throwable ignored) {
            }
        }
    }

    private static boolean writeSysfs(String path, String val) {
        FileOutputStream fos = null;
        try {
            fos = new FileOutputStream(path);
            fos.write(val.getBytes("US-ASCII"));
            fos.flush();
            return true;
        } catch (Throwable t) {
            return false;
        } finally {
            try {
                if (fos != null) {
                    fos.close();
                }
            } catch (Throwable ignored) {
            }
        }
    }

    private static void sleepQuiet(long ms) {
        try {
            Thread.sleep(ms);
        } catch (InterruptedException ignored) {
        }
    }

    /**
     * 是否处于「双 VBUS」：端口在当从机，但 OTG 升压还开着。
     *
     * 实测（2026-10-26 12:44）：写 usb_otg=1 后立刻变成
     *     mode=peripheral / usb_otg=1 / online=1 / android_usb state=DISCONNECTED
     * 也就是说 online 仍读 1，光看 online 永远发现不了，必须直接看 usb_otg。
     * 后果：VBUS 上两个 5V 源并联，主机的限流开关关断端口，
     * 表现为「设备压根不出现」（连未知设备都不是）。
     */
    public static boolean isDualVbus() {
        return MODE_PERIPHERAL.equals(getMode()) && "1".equals(getOtgBoost());
    }

    /**
     * 修复 USB 连接：关升压 -> none -> peripheral（让主机重新枚举）。
     *
     * 顺序不能反：先关升压才切得动角色；切完还要复查一次，
     * 因为 dwc3 有时不会把「退出 host」的事件通知到 charger（实测踩过）。
     */
    public static boolean healUsb() {
        writeSysfs(OTG_PATH, "0");
        sleepQuiet(500);
        setMode(MODE_OFF);
        sleepQuiet(700);
        boolean ok = setMode(MODE_PERIPHERAL);
        sleepQuiet(500);
        if ("1".equals(getOtgBoost())) {
            writeSysfs(OTG_PATH, "0");
        }
        return ok;
    }

    // ------------------------------------------------------------ 存储卷

    public static StorageVolume removableVolume(Context c) {
        try {
            StorageManager sm = (StorageManager) c.getSystemService(Context.STORAGE_SERVICE);
            if (sm == null) {
                return null;
            }
            List<StorageVolume> vols = sm.getStorageVolumes();
            if (vols == null) {
                return null;
            }
            for (StorageVolume v : vols) {
                if (v != null && v.isRemovable()) {
                    return v;
                }
            }
        } catch (Throwable ignored) {
        }
        return null;
    }

    public static boolean storageMounted(StorageVolume v) {
        if (v == null) {
            return false;
        }
        try {
            return Environment.MEDIA_MOUNTED.equals(v.getState());
        } catch (Throwable t) {
            return false;
        }
    }

    // ------------------------------------------------------------ 其它 USB 设备

    public static List<UsbDevice> devices(Context c) {
        List<UsbDevice> out = new ArrayList<UsbDevice>();
        try {
            UsbManager um = (UsbManager) c.getSystemService(Context.USB_SERVICE);
            if (um == null) {
                return out;
            }
            Map<String, UsbDevice> m = um.getDeviceList();
            if (m != null) {
                out.addAll(m.values());
            }
        } catch (Throwable ignored) {
        }
        return out;
    }

    private static String devName(Context c, UsbDevice d) {
        String name = null;
        try {
            name = d.getProductName();
        } catch (Throwable ignored) {
        }
        if (name == null || name.trim().isEmpty()) {
            try {
                name = d.getManufacturerName();
            } catch (Throwable ignored) {
            }
        }
        if (name == null || name.trim().isEmpty()) {
            name = String.format("USB %04X:%04X", d.getVendorId(), d.getProductId());
        }
        return name.trim();
    }

    /**
     * 当前接入设备的名字（磁贴标题 / 设备设置里显示）。
     * 没有设备时返回 null。
     */
    public static String deviceLabel(Context c) {
        StorageVolume v = removableVolume(c);
        if (v != null) {
            String d = null;
            try {
                d = v.getDescription(c);
            } catch (Throwable ignored) {
            }
            if (d != null && d.trim().length() > 0) {
                return d.trim();
            }
            return c.getString(R.string.tile_usb_idle);
        }
        List<UsbDevice> devs = devices(c);
        if (!devs.isEmpty()) {
            String name = devName(c, devs.get(0));
            if (devs.size() > 1) {
                name = name + " +" + (devs.size() - 1);
            }
            return name;
        }
        return null;
    }

    /** 是否有任何 USB 设备（存储或其它）。 */
    public static boolean hasAnyDevice(Context c) {
        if (removableVolume(c) != null) {
            return true;
        }
        return !devices(c).isEmpty();
    }

    // ------------------------------------------------------------ 弹出

    /**
     * 弹出设备：
     *   · 存储卷 —— 卸载（A11 的「弹出」），失败时先关掉正在占用它前台的 App 再试一次；
     *   · 其它设备 —— 没有可卸载的文件系统，只能把占用它的前台 App 关掉，然后由调用方
     *     决定是否断电（写 none）。
     * ⚠️ 会阻塞（最多约 1.5s 等卷状态），调用方请在后台线程执行。
     */
    public static int eject(Context c) {
        StorageVolume v = removableVolume(c);
        if (v != null) {
            if (!storageMounted(v)) {
                return EJECT_STORAGE_OK;   // 已经是卸载/弹出状态
            }
            if (unmount(c, v)) {
                return EJECT_STORAGE_OK;
            }
            stopForegroundApp(c);
            if (unmount(c, v)) {
                return EJECT_STORAGE_OK;
            }
            return EJECT_STORAGE_FAIL;
        }
        if (!devices(c).isEmpty()) {
            stopForegroundApp(c);
            return EJECT_APP_STOPPED;
        }
        return EJECT_NONE;
    }

    private static boolean unmount(Context c, StorageVolume v) {
        try {
            StorageManager sm = (StorageManager) c.getSystemService(Context.STORAGE_SERVICE);
            if (sm == null) {
                return false;
            }
            sm.unmount(v.getId());
        } catch (Throwable ignored) {
        }
        for (int i = 0; i < 8; i++) {
            String st = null;
            try {
                st = v.getState();
            } catch (Throwable ignored) {
            }
            if (Environment.MEDIA_UNMOUNTED.equals(st)
                    || Environment.MEDIA_REMOVED.equals(st)
                    || Environment.MEDIA_EJECTING.equals(st)
                    || Environment.MEDIA_UNMOUNTABLE.equals(st)
                    || Environment.MEDIA_BAD_REMOVAL.equals(st)) {
                return true;
            }
            try {
                Thread.sleep(180);
            } catch (Throwable ignored) {
            }
        }
        return false;
    }

    /**
     * 关掉正在前台、且可能占着这个 USB 设备的 App。
     * 需要 FORCE_STOP_PACKAGES（platform 签名即可获得）。
     * 系统界面 / 桌面 / 本应用一律跳过。
     */
    public static void stopForegroundApp(Context c) {
        try {
            ActivityManager am =
                    (ActivityManager) c.getSystemService(Context.ACTIVITY_SERVICE);
            if (am == null) {
                return;
            }
            List<ActivityManager.RunningAppProcessInfo> ps = am.getRunningAppProcesses();
            if (ps == null) {
                return;
            }
            for (ActivityManager.RunningAppProcessInfo p : ps) {
                if (p == null
                        || p.importance != ActivityManager.RunningAppProcessInfo.IMPORTANCE_FOREGROUND) {
                    continue;
                }
                String pkg = null;
                if (p.pkgList != null && p.pkgList.length > 0) {
                    pkg = p.pkgList[0];
                }
                if (pkg == null || pkg.isEmpty()) {
                    pkg = p.processName;
                }
                if (pkg == null || pkg.isEmpty() || !pkg.contains(".")) {
                    continue;
                }
                if (pkg.startsWith("com.android.systemui")
                        || pkg.startsWith("com.android.settings")
                        || pkg.startsWith("com.iflytek.ms600.settings")) {
                    continue;
                }
                try {
                    am.forceStopPackage(pkg);
                    android.util.Log.i("MS600Usb", "eject: force-stop " + pkg);
                } catch (Throwable ignored) {
                }
            }
        } catch (Throwable ignored) {
        }
    }
}
