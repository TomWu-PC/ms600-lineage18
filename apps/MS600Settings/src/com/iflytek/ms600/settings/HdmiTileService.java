package com.iflytek.ms600.settings;

import android.graphics.drawable.Icon;
import android.os.Handler;
import android.os.Looper;
import android.provider.Settings;
import android.service.quicksettings.Tile;
import android.service.quicksettings.TileService;
import android.widget.Toast;

/**
 * MS600 v123 — 状态栏磁贴：安全移除 HDMI（停止外接屏输出）。
 *
 * 磁贴只写 Settings.Global.ms600_hdmi_out_enabled，真正的动作由
 * DisplayManagerService 里的观察者执行（SurfaceControl.setDisplayPowerMode）。
 */
public class HdmiTileService extends TileService {

    static final String KEY_HDMI_OUT = "ms600_hdmi_out_enabled";

    @Override
    public void onStartListening() {
        super.onStartListening();
        updateTile();
    }

    private boolean outEnabled() {
        try {
            return Settings.Global.getInt(getContentResolver(), KEY_HDMI_OUT, 1) != 0;
        } catch (Throwable t) {
            return true;
        }
    }

    private void updateTile() {
        final Tile tile = getQsTile();
        if (tile == null) {
            return;
        }
        final boolean on = outEnabled();
        tile.setState(on ? Tile.STATE_ACTIVE : Tile.STATE_INACTIVE);
        tile.setLabel(getString(on ? R.string.tile_hdmi_on : R.string.tile_hdmi_off));
        tile.setIcon(Icon.createWithResource(this, R.drawable.ic_tile_hdmi));
        tile.updateTile();
    }

    @Override
    public void onClick() {
        super.onClick();
        final boolean target = !outEnabled();
        try {
            Settings.Global.putInt(getContentResolver(), KEY_HDMI_OUT, target ? 1 : 0);
        } catch (Throwable ignored) {
        }
        toast(getString(target ? R.string.hdmi_out_toast_on : R.string.hdmi_out_toast_off));
        updateTile();
    }

    private void toast(final String s) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            @Override
            public void run() {
                Toast.makeText(HdmiTileService.this, s, Toast.LENGTH_SHORT).show();
            }
        });
    }
}
