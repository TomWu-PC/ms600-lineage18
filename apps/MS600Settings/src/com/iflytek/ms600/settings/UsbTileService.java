package com.iflytek.ms600.settings;

import android.graphics.drawable.Icon;
import android.os.Handler;
import android.os.Looper;
import android.service.quicksettings.Tile;
import android.service.quicksettings.TileService;
import android.widget.Toast;

/**
 * MS600 v149 — 控制中心「USB」磁贴。
 *
 * 设计（一个磁贴同时承担 OTG 开关与「弹出」）：
 *   ① OTG 关闭时点 → 打开 OTG（host），插上就能识别
 *   ② OTG 打开且有设备：
 *        · 存储设备（U 盘）→ 卸载卷 = 安全弹出，提示可以拔线
 *        · 其它设备（网卡/手柄/键鼠）→ 关掉占用它的前台 App，再把端口断电（mode=none）
 *          实现"硬件级弹出"，磁贴随之变灰；再点一次即重新开启 OTG
 *   ③ OTG 打开但没有设备 → 关闭 OTG（切回从设备模式，可接电脑 adb）
 *
 * 标题（label）动态显示当前设备名：U 盘显示卷描述，其它设备显示 productName，
 * 取不到就退回 VID:PID。
 */
public class UsbTileService extends TileService {

    private static final long REFRESH_MS = 1500L;

    private final Handler mHandler = new Handler(Looper.getMainLooper());
    private boolean mListening = false;

    private final Runnable mRefresh = new Runnable() {
        @Override
        public void run() {
            updateTile();
            if (mListening) {
                mHandler.postDelayed(this, REFRESH_MS);
            }
        }
    };

    @Override
    public void onStartListening() {
        super.onStartListening();
        mListening = true;
        mHandler.removeCallbacks(mRefresh);
        mHandler.post(mRefresh);
    }

    @Override
    public void onStopListening() {
        mListening = false;
        mHandler.removeCallbacks(mRefresh);
        super.onStopListening();
    }

    @Override
    public void onDestroy() {
        mListening = false;
        mHandler.removeCallbacks(mRefresh);
        super.onDestroy();
    }

    // ------------------------------------------------------------ 状态刷新

    private void updateTile() {
        final Tile tile = getQsTile();
        if (tile == null) {
            return;
        }
        final boolean otg = UsbHelper.isOtgOn();
        final String dev = otg ? UsbHelper.deviceLabel(this) : null;

        String label;
        if (!otg) {
            label = getString(R.string.tile_usb_idle);
        } else if (dev != null) {
            // 用户要的：磁贴上直接显示设备名称
            label = dev;
        } else {
            label = getString(R.string.tile_usb_idle);
        }

        int state;
        if (!otg) {
            state = Tile.STATE_INACTIVE;
        } else if (dev != null) {
            state = Tile.STATE_ACTIVE;
        } else {
            state = Tile.STATE_INACTIVE;
        }

        tile.setLabel(label);
        tile.setState(state);
        tile.setIcon(Icon.createWithResource(this, R.drawable.ic_tile_usb));
        tile.updateTile();
    }

    // ------------------------------------------------------------ 点击

    @Override
    public void onClick() {
        super.onClick();

        final boolean otg = UsbHelper.isOtgOn();
        if (!otg) {
            // ① 打开 OTG
            final boolean ok = UsbHelper.setOtgOn(true);
            if (ok) {
                persistOtg(true);
            }
            toast(ok ? getString(R.string.tile_usb_otg_on) : getString(R.string.tile_usb_otg_fail));
            mHandler.postDelayed(mRefresh, 600);
            return;
        }

        final String dev = UsbHelper.deviceLabel(this);
        if (dev == null) {
            // ③ 没有设备 → 关掉 OTG（切回从设备）
            UsbHelper.setOtgOn(false);
            persistOtg(false);
            toast(getString(R.string.tile_usb_otg_off));
            mHandler.postDelayed(mRefresh, 600);
            return;
        }

        // ② 弹出：可能在等卷状态，放后台线程
        toast(getString(R.string.tile_usb_ejecting, dev));
        new Thread(new Runnable() {
            @Override
            public void run() {
                final int r = UsbHelper.eject(UsbTileService.this);
                if (r == UsbHelper.EJECT_STORAGE_OK) {
                    // MS600 v149d: 卸载干净之后再端口断电（用户要的「弹出」是彻底断电）
                    UsbHelper.powerOff();
                    toast(getString(R.string.tile_usb_ejected_off, dev));
                } else if (r == UsbHelper.EJECT_STORAGE_FAIL) {
                    toast(getString(R.string.tile_usb_fail));
                } else if (r == UsbHelper.EJECT_APP_STOPPED) {
                    // 非存储设备：停掉占用它的 App，再把端口断电（硬件弹出）
                    UsbHelper.powerOff();
                    toast(getString(R.string.tile_usb_ejected_off, dev));
                } else {
                    toast(getString(R.string.tile_usb_none));
                }
                mHandler.postDelayed(mRefresh, 800);
            }
        }, "ms600-usb-eject").start();
    }

    /** MS600 v149b: 磁贴切换也要写 Settings.Global，否则重启后 BootReceiver 会把状态改回去。 */
    private void persistOtg(boolean on) {
        try {
            android.provider.Settings.Global.putString(getContentResolver(),
                    "ms600_usb_otg", on ? "1" : "0");
        } catch (Throwable ignored) {
        }
    }

    private void toast(final String s) {
        mHandler.post(new Runnable() {
            @Override
            public void run() {
                Toast.makeText(UsbTileService.this, s, Toast.LENGTH_SHORT).show();
            }
        });
    }
}
