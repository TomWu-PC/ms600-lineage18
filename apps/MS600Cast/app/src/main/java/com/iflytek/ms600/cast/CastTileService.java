package com.iflytek.ms600.cast;

import android.content.Intent;
import android.graphics.drawable.Icon;
import android.os.Build;
import android.service.quicksettings.Tile;
import android.service.quicksettings.TileService;

/**
 * MS600 2026-10-27 —— 控制中心磁贴：投屏入口。
 *
 * 只做「打开投屏界面」这一件事（用户要的是入口，不是开关）。
 * 开关状态仍由 App 内 / 「设备设置」控制，避免两处状态打架。
 */
public class CastTileService extends TileService {

    private static final String MAIN_ACT = "com.iflytek.ms600.cast.ui.MainActivity";

    @Override
    public void onStartListening() {
        super.onStartListening();
        updateTile();
    }

    private void updateTile() {
        final Tile tile = getQsTile();
        if (tile == null) {
            return;
        }
        tile.setState(Tile.STATE_INACTIVE);
        tile.setLabel(getString(R.string.tile_cast_label));
        tile.setIcon(Icon.createWithResource(this, R.drawable.ic_stat_miracast));
        tile.updateTile();
    }

    @Override
    public void onClick() {
        super.onClick();
        try {
            final Intent i = new Intent();
            i.setClassName(getPackageName(), MAIN_ACT);
            i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                startActivityAndCollapse(i);
            } else {
                startActivity(i);
            }
        } catch (Throwable ignored) {
        }
    }
}
