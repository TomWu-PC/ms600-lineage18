package com.iflytek.ms600.settings;

import android.graphics.drawable.Icon;
import android.net.EthernetManager;
import android.os.Handler;
import android.os.Looper;
import android.service.quicksettings.Tile;
import android.service.quicksettings.TileService;
import android.widget.Toast;

/**
 * MS600 v123 — 状态栏磁贴：有线网卡开关。
 *
 * 复用 framework 里 v112 加回的 EthernetManager.setInterfaceEnabled()。
 */
public class EthTileService extends TileService {

    private EthernetManager em() {
        try {
            return (EthernetManager) getSystemService("ethernet");
        } catch (Throwable t) {
            return null;
        }
    }

    private String iface(EthernetManager em) {
        try {
            final String[] avail = em.getAvailableInterfaces();
            if (avail != null && avail.length > 0 && avail[0] != null) {
                return avail[0];
            }
        } catch (Throwable ignored) {
        }
        return "eth0";
    }

    private boolean enabled() {
        final EthernetManager em = em();
        if (em == null) {
            return false;
        }
        try {
            return em.isInterfaceEnabled(iface(em));
        } catch (Throwable t) {
            return false;
        }
    }

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
        tile.setState(enabled() ? Tile.STATE_ACTIVE : Tile.STATE_INACTIVE);
        tile.setLabel(getString(R.string.tile_eth_name));
        tile.setIcon(Icon.createWithResource(this, R.drawable.ic_tile_eth));
        tile.updateTile();
    }

    @Override
    public void onClick() {
        super.onClick();
        final EthernetManager em = em();
        if (em == null) {
            toast(getString(R.string.eth_unsupported));
            return;
        }
        final boolean now = enabled();
        try {
            em.setInterfaceEnabled(iface(em), !now);
            toast(getString(!now ? R.string.tile_eth_on : R.string.tile_eth_off));
        } catch (Throwable t) {
            toast(getString(R.string.eth_failed) + ": " + t.getMessage());
        }
        updateTile();
    }

    private void toast(final String s) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            @Override
            public void run() {
                Toast.makeText(EthTileService.this, s, Toast.LENGTH_SHORT).show();
            }
        });
    }
}
