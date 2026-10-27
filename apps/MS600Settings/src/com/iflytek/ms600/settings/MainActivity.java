/*
 * MS600 v121 — 「设备设置」App
 *   · 网络：有线网卡开关 / IP 获取方式（自动 DHCP 或静态）/ 状态信息 / 链路速率说明
 *   · 音频输出：在已连接的输出设备之间切换（自动 / 扬声器 / 耳机 / HDMI / 蓝牙…）
 *   · 充电：旁路充电开关（电量 ≥80% 停止充电 / <80% 恢复）
 *   · 屏幕：双击唤醒开关（仅接电源时生效）
 *   · 按键：F1 / F2 自定义
 *
 * 本 App 只负责写 Settings.Global 与调用 framework 接口，真正的执行在 frameworks/base：
 *   ms600_bypass_charging   -> BatteryService 每秒级跟随电量写充电使能节点
 *   ms600_dt2w_enabled      -> PowerManagerService 把"关屏"变成"伪关屏" + 读 evdev 检测双击
 *   ms600_key_f1_action     -> PhoneWindowManager 拦截 F1
 *   ms600_key_f2_action     -> PhoneWindowManager 拦截 F2
 *   有线网络开关 / 静态 IP   -> EthernetManager
 *   音频输出切换             -> AudioManager.setPreferredDeviceForStrategy(媒体产品策略)
 *
 * 按键动作取值：
 *   ""（空） / default   不拦截，保持系统默认行为
 *   none                 无动作（吃掉该键）
 *   home                 主屏幕
 *   recents              最近任务
 *   sleep                息屏
 *   app:<包名/类名>      启动指定应用
 *   broadcast:<action>   发送广播
 */
package com.iflytek.ms600.settings;

import android.app.Activity;
import android.app.AlertDialog;
// MS600 v153: 蓝牙设备页（本机没有 com.android.settings，蓝牙原先完全没有入口）
import android.bluetooth.BluetoothA2dp;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothHidHost;
import android.bluetooth.BluetoothProfile;
import android.content.BroadcastReceiver;
import android.content.IntentFilter;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.database.ContentObserver;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.graphics.Color;
import android.graphics.Typeface;
import android.graphics.drawable.ColorDrawable;
import android.hardware.display.DisplayManager;
import android.media.AudioAttributes;
import android.media.AudioDeviceAttributes;
import android.media.AudioDeviceCallback;
import android.media.AudioDeviceInfo;
import android.media.AudioManager;
import android.media.audiopolicy.AudioProductStrategy;
import android.net.ConnectivityManager;
import android.net.EthernetManager;
import android.net.IpConfiguration;
import android.net.LinkAddress;
import android.net.LinkProperties;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.net.StaticIpConfiguration;
import android.os.Bundle;
import android.os.ServiceManager;
import android.provider.Settings;
import android.text.InputType;
import android.text.TextUtils;
import android.util.TypedValue;
import android.view.Display;
import android.view.Gravity;
import android.view.IWindowManager;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

import java.io.BufferedReader;
// MS600 v153: 存储信息 / U 盘模式开关
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.util.Locale;
import java.util.Set;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class MainActivity extends Activity {

    private static final String KEY_F1 = "ms600_key_f1_action";
    private static final String KEY_F2 = "ms600_key_f2_action";
    private static final String KEY_BYPASS = "ms600_bypass_charging";
    /** MS600 v147: 游戏手柄模式（1 = 所有键/轴交给游戏，Moonlight 串流用） */
    private static final String KEY_GAMEPAD_GAME = "ms600_gamepad_game_mode";
    /** MS600 v149: USB OTG 主机模式（默认 1 = 开；0 = 从设备，接电脑 adb 用） */
    private static final String KEY_USB_OTG = "ms600_usb_otg";
    /** MS600 v151: auto / host / peripheral */
    private static final String KEY_USB_MODE = "ms600_usb_mode";
    private static final String KEY_DT2W = "ms600_dt2w_enabled";
    private static final String KEY_HDMI_OUT = "ms600_hdmi_out_enabled";
    private static final String KEY_DISPLAY_SIZE_FORCED = "display_size_forced";
    private static final String KEY_HDMI_PANEL_OFF = "ms600_hdmi_screen_off_sec";

    /** 与 R.array.action_labels 一一对应；"@app"/"@broadcast" 是打开子对话框的占位。 */
    private static final String[] ACTION_VALUES = {
            "default", "none", "home", "recents", "sleep", "@app", "@broadcast", "@web"
    };

    // ---- 行类型 ----
    private static final int RT_HEADER = 0;
    private static final int RT_SECTION = 1;
    private static final int RT_SWITCH = 2;
    private static final int RT_ACTION = 3;
    private static final int RT_INFO = 4;
    private static final int RT_NOTE = 5;
    private static final int RT_RADIO = 6;
    /** v156: 主菜单里的「分组入口」行（标题 + 关键摘要 + 箭头） */
    private static final int RT_NAV = 7;

    // ---- 分组（v156 界面重构：一页到底 → 分类入口）----
    private static final int G_NET = 0;      // 网络与连接
    private static final int G_DISPLAY = 1;  // 显示与投屏
    private static final int G_AUDIO = 2;    // 音频输出
    private static final int G_USB = 3;      // USB 与外设
    private static final int G_BT = 4;       // 蓝牙
    private static final int G_SYSTEM = 5;   // 系统与存储
    private static final int G_COUNT = 6;

    /** 分组入口行的 key = K_NAV + 分组号。 */
    private static final int K_NAV = 200;

    /** 当前所在分组；-1 = 主菜单。 */
    private int mGroup = -1;


    // ---- 行标识 ----
    private static final int K_ETH_ENABLE = 1;
    private static final int K_ETH_MODE = 2;
    private static final int K_ETH_IP = 3;
    private static final int K_ETH_PREFIX = 4;
    private static final int K_ETH_GW = 5;
    private static final int K_ETH_DNS = 6;
    private static final int K_AUDIO_AUTO = 7;
    private static final int K_AUDIO_DEV = 8;
    private static final int K_BYPASS = 10;
    private static final int K_DT2W = 11;
    private static final int K_F1 = 12;
    private static final int K_F2 = 13;
    private static final int K_HDMI_MIRROR = 14;
    private static final int K_HDMI_OUT = 15;
    private static final int K_HDMI_PANEL_OFF = 16;
    // MS600 v137: 投屏接收（Miracast / DLNA / AirPlay）
    private static final int K_CAST = 17;
    private static final int K_CAST_OPEN = 18;
    /** MS600 v140e: 网络定位设置入口 */
    private static final int K_NLP = 19;
    /** MS600 v147: 游戏手柄模式开关 */
    private static final int K_GAMEPAD_GAME = 20;
    /** MS600 v149: USB OTG 主机模式开关 / 弹出设备 */
    private static final int K_USB_OTG = 21;
    private static final int K_USB_EJECT = 22;
    private static final int K_USB_DEV = 23;
    /** MS600 v151: USB 模式三选一（自动 / 强制主机 / 强制从机） */
    private static final int K_USB_MODE = 24;
    // MS600 v153: 蓝牙 / 存储 / U 盘模式
    //   蓝牙设备行用「基址 + 索引」编码（onRowClick 先处理 >= 1000 的 key）：
    //     1000 + i = 已配对列表第 i 个；2000 + i = 附近设备第 i 个
    private static final int K_BT_ENABLE = 25;
    private static final int K_BT_SCAN = 26;
    private static final int K_BT_DEV = 1000;
    private static final int K_BT_FOUND = 2000;
    private static final int K_USB_MSC = 29;
    /** MS600 v154: 修复 USB 连接（清双 VBUS 供电冲突） */
    private static final int K_USB_HEAL = 30;
    /** MS600 v155: 广告拦截开关（iptables 关键词拦 SNI/Host） */
    private static final int K_ADB_BLOCK = 31;
    /** v164: 拦截关键词编辑（原来写死在 root 脚本里，改不了） */
    private static final int K_ADB_RULES = 32;
    // v164: 存储段已从界面移除，这两个 key 不再使用。
    //   原来取值 30/31，与 K_USB_HEAL(30) / K_ADB_BLOCK(31) 撞车（点"内部存储"会触发修复 USB），
    //   现改到 40/41 彻底避开。
    private static final int K_STORAGE_INT = 40;
    private static final int K_STORAGE_SD = 41;
    private static final int REQ_BT_LOC = 0x60;

    private static final String CAST_PKG = "com.iflytek.ms600.cast";
    private static final String CAST_SVC = "com.iflytek.ms600.cast.service.CastReceiverService";
    private static final String CAST_ACT = "com.iflytek.ms600.cast.ui.MainActivity";
    private static final String KEY_CAST_ENABLED = "ms600_cast_enabled";
    private static final String KEY_CAST_STATE = "ms600_cast_state";

    private final List<Row> mRows = new ArrayList<Row>();
    private ListView mList;
    private KeyAdapter mAdapter;

    private boolean mHdmiConnected = false;
    private boolean mHdmiOut = true;
    private boolean mMirrorOn = false;
    private int mHdmiPanelOffSec = 0;
    private int mHdmiW = 0;
    private int mHdmiH = 0;

    private ContentObserver mHdmiObserver;

    private boolean mGamepadGame = false;
    private String mUsbMode = "auto";   // MS600 v151: auto / host / peripheral
    private String mF1 = "";
    private String mF2 = "";
    private boolean mBypass = false;
    private boolean mDt2w = false;

    // 网络状态
    private EthernetManager mEm;
    private String mIface = "eth0";
    private boolean mEthSupported = false;
    private boolean mEthEnabled = true;
    private boolean mEthCableIn = false;
    private boolean mIsStatic = false;
    private String mStaticIp = "";
    private int mStaticPrefix = 24;
    private String mStaticGw = "";
    private String mStaticDns = "";
    private String mEthAddr = "";
    private String mEthGw = "";
    private String mEthDns = "";
    private String mEthMac = "";

    // ---- MS600 v153: 蓝牙 / U 盘模式 ----
    private BluetoothAdapter mBt;
    private BluetoothHidHost mHid;
    private BluetoothA2dp mA2dp;
    private boolean mDiscovering = false;
    private boolean mBtRxRegistered = false;
    private final List<BluetoothDevice> mBonded = new ArrayList<BluetoothDevice>();
    private final List<BluetoothDevice> mFound = new ArrayList<BluetoothDevice>();
    private final BroadcastReceiver mBtRx = new BroadcastReceiver() {
        @Override
        public void onReceive(Context ctx, Intent intent) {
            if (intent == null || intent.getAction() == null) {
                return;
            }
            String a = intent.getAction();
            if (BluetoothDevice.ACTION_FOUND.equals(a)) {
                BluetoothDevice d = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE);
                if (d != null) {
                    boolean dup = false;
                    for (int i = 0; i < mFound.size(); i++) {
                        if (mFound.get(i).getAddress().equals(d.getAddress())) {
                            dup = true;
                            break;
                        }
                    }
                    if (!dup) {
                        mFound.add(d);
                    }
                }
            } else if (BluetoothAdapter.ACTION_DISCOVERY_STARTED.equals(a)) {
                mDiscovering = true;
            } else if (BluetoothAdapter.ACTION_DISCOVERY_FINISHED.equals(a)) {
                mDiscovering = false;
            }
            reload();
        }
    };

    // 音频输出
    private AudioManager mAm;
    private AudioProductStrategy mMediaStrategy;
    private int mPrefDevId = -1;                       // -1 = 自动（跟随系统）；-2 = 已设定但设备不在列表
    private final List<AudioDeviceInfo> mAudioOuts = new ArrayList<AudioDeviceInfo>();
    private final AudioDeviceCallback mDevCb = new AudioDeviceCallback() {
        @Override
        public void onAudioDevicesAdded(AudioDeviceInfo[] added) {
            reload();
        }

        @Override
        public void onAudioDevicesRemoved(AudioDeviceInfo[] removed) {
            reload();
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        applyTitle();

        try {
            mEm = (EthernetManager) getSystemService(Context.ETHERNET_SERVICE);
        } catch (Throwable ignored) {
            mEm = null;
        }
        mEthSupported = (mEm != null);

        initAudio();
        // MS600 v153: 蓝牙
        initBt();

        mList = new ListView(this);
        mList.setBackgroundColor(0xFFF2F2F2);
        mList.setDivider(new ColorDrawable(0xFFE0E0E0));
        mList.setDividerHeight(Math.max(1, dp(1)));
        mList.setFooterDividersEnabled(false);
        mList.setHeaderDividersEnabled(false);

        mAdapter = new KeyAdapter();
        mList.setAdapter(mAdapter);
        mList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                if (position < 0 || position >= mRows.size()) {
                    return;
                }
                Row r = mRows.get(position);
                if (r.type == RT_NAV) {
                    openGroup(r.extra);
                    return;
                }
                if (r.key == K_AUDIO_AUTO) {
                    setAudioOutput(-1);
                } else if (r.key == K_AUDIO_DEV) {
                    setAudioOutput(r.extra);
                } else {
                    onRowClick(r.key);
                }
            }
        });

        setContentView(mList);

        // MS600 v124: 磁贴改了 HDMI 输出状态后，App 实时同步
        try {
            mHdmiObserver = new ContentObserver(new android.os.Handler()) {
                @Override
                public void onChange(boolean selfChange) {
                    reload();
                }
            };
            getContentResolver().registerContentObserver(
                    Settings.Global.getUriFor(KEY_HDMI_OUT), false, mHdmiObserver);
        } catch (Throwable ignored) {
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        // MS600 v153: 蓝牙开关 / 发现 / 配对 / 连接状态实时刷新
        try {
            IntentFilter f = new IntentFilter();
            f.addAction(BluetoothAdapter.ACTION_STATE_CHANGED);
            f.addAction(BluetoothAdapter.ACTION_DISCOVERY_STARTED);
            f.addAction(BluetoothAdapter.ACTION_DISCOVERY_FINISHED);
            f.addAction(BluetoothDevice.ACTION_FOUND);
            f.addAction(BluetoothDevice.ACTION_BOND_STATE_CHANGED);
            f.addAction(BluetoothDevice.ACTION_ACL_CONNECTED);
            f.addAction(BluetoothDevice.ACTION_ACL_DISCONNECTED);
            registerReceiver(mBtRx, f);
            mBtRxRegistered = true;
        } catch (Throwable ignored) {
        }
        ensureBtProfiles();
        reload();
    }

    @Override
    protected void onPause() {
        super.onPause();
        try {
            if (mBtRxRegistered) {
                unregisterReceiver(mBtRx);
                mBtRxRegistered = false;
            }
        } catch (Throwable ignored) {
        }
        try {
            if (mBt != null && mBt.isDiscovering()) {
                mBt.cancelDiscovery();
            }
        } catch (Throwable ignored) {
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        try {
            if (mAm != null) {
                mAm.unregisterAudioDeviceCallback(mDevCb);
            }
        } catch (Throwable ignored) {
        }
        try {
            if (mHdmiObserver != null) {
                getContentResolver().unregisterContentObserver(mHdmiObserver);
            }
        } catch (Throwable ignored) {
        }
    }

    private void onRowClick(int key) {
        // MS600 v153: 蓝牙设备行 = 基址 + 索引（1000=已配对，2000=附近）
        if (key >= K_BT_DEV) {
            int idx = key % 1000;
            if (key < K_BT_FOUND) {
                if (idx < mBonded.size()) {
                    showBtDeviceDialog(mBonded.get(idx), true);
                }
            } else if (idx < mFound.size()) {
                showBtDeviceDialog(mFound.get(idx), false);
            }
            return;
        }
        switch (key) {
            case K_ETH_ENABLE:
                saveEthEnabled(!mEthEnabled);
                break;
            case K_ETH_MODE:
                chooseIpMode();
                break;
            case K_ETH_IP:
            case K_ETH_PREFIX:
            case K_ETH_GW:
            case K_ETH_DNS:
                showStaticDialog();
                break;
            case K_BYPASS:
                saveBypass(!mBypass);
                break;
            case K_GAMEPAD_GAME:
                saveGamepadGame(!mGamepadGame);
                break;
            case K_USB_MODE:
                cycleUsbMode();
                break;
            case K_DT2W:
                saveDt2w(!mDt2w);
                break;
            case K_F1:
                chooseAction(1);
                break;
            case K_F2:
                chooseAction(2);
                break;
            case K_HDMI_MIRROR:
                saveMirror(!mMirrorOn);
                break;
            case K_HDMI_OUT:
                saveHdmiOut(!mHdmiOut);
                break;
            case K_HDMI_PANEL_OFF:
                chooseHdmiPanelOff();
                break;
            case K_CAST:
                toggleCast();
                break;
            case K_CAST_OPEN:
                openCastUi();
                break;
            case K_BT_ENABLE:
                toggleBt(!isBtOn());
                break;
            case K_BT_SCAN:
                if (mDiscovering) {
                    try {
                        mBt.cancelDiscovery();
                    } catch (Throwable ignored) {
                    }
                } else {
                    startBtScan();
                }
                break;
            case K_USB_MSC:
                toggleMsc(!isMscOn());
                break;
            case K_USB_HEAL:
                doHealUsb();
                break;
            case K_ADB_BLOCK:
                toggleAdblock(!isAdblockOn());
                break;
            case K_ADB_RULES:
                showAdblockRulesDialog();
                break;
            case K_NLP:
                openNlpUi();
                break;
            default:
                break;
        }
    }

    // ------------------------------------------------------------------ data

    // ------------------------------------------------------ MS600 v137 投屏接收

    private boolean isCastOn() {
        return Settings.Global.getInt(getContentResolver(), KEY_CAST_ENABLED, 0) != 0;
    }

    private String describeCast() {
        return isCastOn() ? getString(R.string.cast_on) : getString(R.string.cast_off);
    }

    private String castStateText() {
        if (!isCastOn()) return getString(R.string.cast_state_off);
        String s = Settings.Global.getString(getContentResolver(), KEY_CAST_STATE);
        if ("connected".equals(s)) return getString(R.string.cast_state_playing);
        return getString(R.string.cast_state_waiting);
    }

    /** 开关投屏接收：写状态 + 直接启停投屏应用的服务（跨应用，靠 signature 级 CONTROL 权限）。 */
    private void toggleCast() {
        boolean on = !isCastOn();
        try {
            Settings.Global.putInt(getContentResolver(), KEY_CAST_ENABLED, on ? 1 : 0);
        } catch (Throwable ignored) {
        }
        try {
            Intent i = new Intent();
            i.setClassName(CAST_PKG, CAST_SVC);
            if (on) {
                startForegroundService(i);
            } else {
                stopService(i);
            }
        } catch (Throwable t) {
            toast(on ? "投屏接收启动失败" : "投屏接收停止失败");
        }
        mList.postDelayed(new Runnable() {
            @Override
            public void run() {
                reload();
            }
        }, 1200);
    }

    private void openCastUi() {
        try {
            Intent i = new Intent();
            i.setClassName(CAST_PKG, CAST_ACT);
            i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(i);
        } catch (Throwable t) {
            toast("未安装投屏应用");
        }
    }

    private void reload() {
        load();
        buildRows();
        applyTitle();
        if (mAdapter != null) {
            mAdapter.notifyDataSetChanged();
        }
    }

    // ---------------------------------------------------------- v156 分组导航

    /** 分组名资源。 */
    private int groupTitleRes(int g) {
        switch (g) {
            case G_NET:     return R.string.grp_net;
            case G_DISPLAY: return R.string.grp_display;
            case G_AUDIO:   return R.string.grp_audio;
            case G_USB:     return R.string.grp_usb;
            case G_BT:      return R.string.grp_bt;
            case G_SYSTEM:  return R.string.grp_system;
            default:        return R.string.app_name;
        }
    }

    /** 主菜单标题 + 无返回箭头；分组页显示分组名 + 返回箭头。
     *  v164: 分组页不再显示 App 图标（只留返回箭头），去掉了每页顶部重复的图标。 */
    private void applyTitle() {
        boolean home = mGroup < 0;
        setTitle(home ? R.string.app_name : groupTitleRes(mGroup));
        try {
            if (getActionBar() != null) {
                getActionBar().setDisplayHomeAsUpEnabled(!home);
                getActionBar().setDisplayShowHomeEnabled(false);
            }
        } catch (Throwable ignored) {
        }
    }

    /** 进入某个分组。 */
    private void openGroup(int g) {
        if (g < 0 || g >= G_COUNT) return;
        mGroup = g;
        reload();
        try {
            mList.setSelection(0);
        } catch (Throwable ignored) {
        }
    }

    /** 回到主菜单。 */
    private void backToHome() {
        mGroup = -1;
        reload();
        try {
            mList.setSelection(0);
        } catch (Throwable ignored) {
        }
    }

    @Override
    public void onBackPressed() {
        if (mGroup >= 0) {
            backToHome();
            return;
        }
        super.onBackPressed();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item != null && item.getItemId() == android.R.id.home && mGroup >= 0) {
            backToHome();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    private void load() {
        mF1 = nz(Settings.Global.getString(getContentResolver(), KEY_F1));
        mF2 = nz(Settings.Global.getString(getContentResolver(), KEY_F2));
        mBypass = "1".equals(nz(Settings.Global.getString(getContentResolver(), KEY_BYPASS)));
        mGamepadGame = "1".equals(
                nz(Settings.Global.getString(getContentResolver(), KEY_GAMEPAD_GAME)));
        // MS600 v149: 未设置过时默认开（设备主要用途是插 U 盘/网卡/手柄）
        // MS600 v151: USB 模式三选一（auto / host / peripheral）
        mUsbMode = nz(Settings.Global.getString(getContentResolver(), KEY_USB_MODE));
        if (!"host".equals(mUsbMode) && !"peripheral".equals(mUsbMode)) {
            mUsbMode = "auto";
        }
        mDt2w = "1".equals(nz(Settings.Global.getString(getContentResolver(), KEY_DT2W)));
        refreshEth();
        refreshAudio();
        refreshDisplay();
        refreshBt();
    }

    private static String nz(String s) {
        return s == null ? "" : s.trim();
    }

    private static String nzOr(String s, String dflt) {
        return (s == null || s.trim().isEmpty()) ? dflt : s.trim();
    }

    private String nzOr(String s) {
        return nzOr(s, getString(R.string.eth_na));
    }

    // ------------------------------------------------------------- ethernet

    private String resolveIface() {
        try {
            if (mEm != null) {
                String[] avail = mEm.getAvailableInterfaces();
                if (avail != null && avail.length > 0 && avail[0] != null) {
                    return avail[0];
                }
            }
        } catch (Throwable ignored) {
        }
        return "eth0";
    }

    private void refreshEth() {
        mIface = resolveIface();

        mEthEnabled = true;
        try {
            if (mEm != null) {
                mEthEnabled = mEm.isInterfaceEnabled(mIface);
            }
        } catch (Throwable ignored) {
        }

        mEthCableIn = "1".equals(readSys("/sys/class/net/" + mIface + "/carrier"));
        mEthMac = readSys("/sys/class/net/" + mIface + "/address");

        // MS600 v122: 地址统一由下方 ConnectivityManager.getLinkProperties() 提供。
        // 原先用 NetworkInterface.getByName()，在本机 App 域下取不到 IPv4
        // ⇒「连接状态」永远停在"获取地址中…"、IPv4 行显示 "--"（v120 引入的 bug）。
        mEthAddr = "";
        mEthGw = "";
        mEthDns = "";
        try {
            ConnectivityManager cm =
                    (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
            if (cm != null) {
                Network[] nets = cm.getAllNetworks();
                if (nets != null) {
                    for (Network n : nets) {
                        NetworkCapabilities nc = cm.getNetworkCapabilities(n);
                        if (nc == null || !nc.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET)) {
                            continue;
                        }
                        LinkProperties lp = cm.getLinkProperties(n);
                        if (lp == null) {
                            continue;
                        }
                        // MS600 v122: 从 LinkProperties 取 IPv4（此处已有可用对象，必然能拿到）
                        for (LinkAddress la : lp.getLinkAddresses()) {
                            InetAddress a = la.getAddress();
                            if (a instanceof Inet4Address) {
                                mEthAddr = a.getHostAddress() + "/" + la.getPrefixLength();
                                break;
                            }
                        }
                        StringBuilder gws = new StringBuilder();
                        for (android.net.RouteInfo rt : lp.getRoutes()) {
                            InetAddress g = rt.getGateway();
                            if (g == null || !(g instanceof Inet4Address) || g.isAnyLocalAddress()) {
                                continue;
                            }
                            if (gws.length() > 0) {
                                gws.append(", ");
                            }
                            gws.append(g.getHostAddress());
                        }
                        mEthGw = gws.toString();
                        StringBuilder dns = new StringBuilder();
                        for (InetAddress d : lp.getDnsServers()) {
                            if (!(d instanceof Inet4Address)) {
                                continue;
                            }
                            if (dns.length() > 0) {
                                dns.append(", ");
                            }
                            dns.append(d.getHostAddress());
                        }
                        mEthDns = dns.toString();
                        break;
                    }
                }
            }
        } catch (Throwable ignored) {
        }

        mIsStatic = false;
        mStaticIp = "";
        mStaticPrefix = 24;
        mStaticGw = "";
        mStaticDns = "";
        try {
            if (mEm != null) {
                IpConfiguration cfg = mEm.getConfiguration(mIface);
                if (cfg != null) {
                    mIsStatic = (cfg.ipAssignment == IpConfiguration.IpAssignment.STATIC);
                    StaticIpConfiguration s = cfg.staticIpConfiguration;
                    if (s != null) {
                        if (s.ipAddress != null && s.ipAddress.getAddress() != null) {
                            mStaticIp = s.ipAddress.getAddress().getHostAddress();
                            mStaticPrefix = s.ipAddress.getPrefixLength();
                        }
                        if (s.gateway != null) {
                            mStaticGw = s.gateway.getHostAddress();
                        }
                        StringBuilder d = new StringBuilder();
                        for (InetAddress a : s.dnsServers) {
                            if (d.length() > 0) {
                                d.append(", ");
                            }
                            d.append(a.getHostAddress());
                        }
                        mStaticDns = d.toString();
                    }
                }
            }
        } catch (Throwable ignored) {
        }
    }

    private static String readSys(String path) {
        BufferedReader br = null;
        try {
            br = new BufferedReader(new FileReader(path));
            String l = br.readLine();
            return l == null ? "" : l.trim();
        } catch (Throwable t) {
            return "";
        } finally {
            try {
                if (br != null) {
                    br.close();
                }
            } catch (Throwable ignored) {
            }
        }
    }

    private String ethStatusText() {
        if (!mEthEnabled) {
            return getString(R.string.eth_status_off);
        }
        if (!mEthCableIn) {
            return getString(R.string.eth_status_nocable);
        }
        if (!mEthAddr.isEmpty()) {
            return getString(R.string.eth_status_connected);
        }
        return getString(R.string.eth_status_connecting);
    }

    private void saveEthEnabled(boolean on) {
        try {
            if (mEm != null) {
                mEm.setInterfaceEnabled(mIface, on);
            }
        } catch (Throwable t) {
            toast(getString(R.string.eth_failed));
            return;
        }
        mEthEnabled = on;
        reload();
        toast(getString(on ? R.string.eth_toast_on : R.string.eth_toast_off));
        mList.postDelayed(new Runnable() {
            @Override
            public void run() {
                reload();
            }
        }, 1200);
    }

    private boolean applyIpConfig(IpConfiguration cfg) {
        try {
            if (mEm == null) {
                return false;
            }
            mEm.setConfiguration(mIface, cfg);
            return true;
        } catch (Throwable t) {
            return false;
        }
    }

    private void chooseIpMode() {
        final String[] labels = {
                getString(R.string.eth_mode_dhcp), getString(R.string.eth_mode_static)
        };
        new AlertDialog.Builder(this)
                .setTitle(R.string.eth_mode_title)
                .setSingleChoiceItems(labels, mIsStatic ? 1 : 0, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                        if (which == 0) {
                            applyDhcp();
                        } else {
                            showStaticDialog();
                        }
                    }
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }

    private void applyDhcp() {
        IpConfiguration cfg = new IpConfiguration();
        cfg.ipAssignment = IpConfiguration.IpAssignment.DHCP;
        cfg.proxySettings = IpConfiguration.ProxySettings.NONE;
        cfg.staticIpConfiguration = null;
        if (!applyIpConfig(cfg)) {
            toast(getString(R.string.eth_failed));
            return;
        }
        toast(getString(R.string.eth_dhcp_applied));
        mList.postDelayed(new Runnable() {
            @Override
            public void run() {
                reload();
            }
        }, 1800);
    }

    private void showStaticDialog() {
        final LinearLayout box = new LinearLayout(this);
        box.setOrientation(LinearLayout.VERTICAL);
        int pad = dp(20);
        box.setPadding(pad, dp(8), pad, 0);

        final EditText eIp = addField(box, R.string.eth_static_ip, mStaticIp);
        final EditText ePfx = addField(box, R.string.eth_static_prefix,
                String.valueOf(mStaticPrefix <= 0 ? 24 : mStaticPrefix));
        ePfx.setInputType(InputType.TYPE_CLASS_NUMBER);
        final EditText eGw = addField(box, R.string.eth_static_gw, mStaticGw);
        final EditText eDns = addField(box, R.string.eth_static_dns, mStaticDns);

        new AlertDialog.Builder(this)
                .setTitle(R.string.eth_static_dlg_title)
                .setView(box)
                .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int i) {
                        String ip = eIp.getText().toString().trim();
                        String gw = eGw.getText().toString().trim();
                        String dns = eDns.getText().toString().trim();
                        int pfx;
                        try {
                            pfx = Integer.parseInt(ePfx.getText().toString().trim());
                        } catch (Throwable t) {
                            pfx = 24;
                        }
                        if (!isIpv4(ip)) {
                            toast(getString(R.string.eth_static_bad));
                            return;
                        }
                        if (pfx < 1 || pfx > 32) {
                            pfx = 24;
                        }
                        if ((!gw.isEmpty() && !isIpv4(gw)) || (!dns.isEmpty() && !isIpv4(dns))) {
                            toast(getString(R.string.eth_static_bad));
                            return;
                        }
                        applyStatic(ip, pfx, gw, dns);
                    }
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }

    private EditText addField(LinearLayout box, int labelRes, String value) {
        TextView label = new TextView(this);
        label.setTextSize(TypedValue.COMPLEX_UNIT_SP, 13);
        label.setTextColor(0xFF757575);
        label.setText(labelRes);
        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        lp.topMargin = dp(10);
        box.addView(label, lp);

        EditText et = new EditText(this);
        et.setTextSize(TypedValue.COMPLEX_UNIT_SP, 16);
        et.setText(value == null ? "" : value);
        et.setSingleLine(true);
        box.addView(et, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        return et;
    }

    private void applyStatic(String ip, int prefix, String gw, String dns) {
        try {
            StaticIpConfiguration s = new StaticIpConfiguration();
            s.ipAddress = new LinkAddress(InetAddress.getByName(ip), prefix);
            if (!gw.isEmpty()) {
                s.gateway = InetAddress.getByName(gw);
            }
            if (!dns.isEmpty()) {
                for (String one : dns.split(",")) {
                    String t = one.trim();
                    if (!t.isEmpty()) {
                        s.dnsServers.add(InetAddress.getByName(t));
                    }
                }
            }
            IpConfiguration cfg = new IpConfiguration();
            cfg.ipAssignment = IpConfiguration.IpAssignment.STATIC;
            cfg.proxySettings = IpConfiguration.ProxySettings.NONE;
            cfg.staticIpConfiguration = s;
            if (!applyIpConfig(cfg)) {
                toast(getString(R.string.eth_failed));
                return;
            }
            toast(getString(R.string.eth_static_applied));
            mList.postDelayed(new Runnable() {
                @Override
                public void run() {
                    reload();
                }
            }, 1800);
        } catch (Throwable t) {
            toast(getString(R.string.eth_static_bad));
        }
    }

    private static boolean isIpv4(String s) {
        if (s == null || s.isEmpty()) {
            return false;
        }
        String[] parts = s.split("\\.");
        if (parts.length != 4) {
            return false;
        }
        for (String p : parts) {
            if (p.isEmpty() || p.length() > 3) {
                return false;
            }
            try {
                int v = Integer.parseInt(p);
                if (v < 0 || v > 255) {
                    return false;
                }
            } catch (NumberFormatException e) {
                return false;
            }
        }
        return true;
    }

    // -------------------------------------------------------------- display

    private void refreshDisplay() {
        mHdmiConnected = false;
        mHdmiW = 0;
        mHdmiH = 0;
        try {
            DisplayManager dm = (DisplayManager) getSystemService(DISPLAY_SERVICE);
            if (dm != null) {
                Display[] ds = dm.getDisplays();
                if (ds != null) {
                    for (Display d : ds) {
                        if (d == null || d.getDisplayId() == Display.DEFAULT_DISPLAY) {
                            continue;
                        }
                        android.graphics.Point p = new android.graphics.Point();
                        d.getRealSize(p);
                        mHdmiConnected = true;
                        mHdmiW = p.x;
                        mHdmiH = p.y;
                    }
                }
            }
        } catch (Throwable ignored) {
        }

        mHdmiOut = Settings.Global.getInt(getContentResolver(), KEY_HDMI_OUT, 1) != 0;

        String forced = Settings.Global.getString(getContentResolver(),
                KEY_DISPLAY_SIZE_FORCED);
        mMirrorOn = (forced != null && forced.indexOf(',') > 0);
        try {
            mHdmiPanelOffSec = Settings.Global.getInt(getContentResolver(),
                    KEY_HDMI_PANEL_OFF, 0);
        } catch (Throwable ignored) {
            mHdmiPanelOffSec = 0;
        }
    }

    private String describeMirror() {
        return mMirrorOn ? getString(R.string.hdmi_mirror_on)
                : getString(R.string.hdmi_mirror_off);
    }

    private String describeHdmiOut() {
        return mHdmiOut ? getString(R.string.hdmi_out_on)
                : getString(R.string.hdmi_out_off);
    }

    private void saveMirror(boolean on) {
        try {
            IWindowManager wm = IWindowManager.Stub.asInterface(
                    ServiceManager.getService(Context.WINDOW_SERVICE));
            if (wm == null) {
                toast(getString(R.string.hdmi_mirror_fail));
                return;
            }
            if (on && mHdmiConnected && mHdmiW > 0 && mHdmiH > 0) {
                // 内屏物理为竖屏（natural portrait）。要让「旋转后」的逻辑尺寸等于
                // 外接屏的 W x H，setForcedDisplaySize 必须按 natural 方向填 (H, W)。
                wm.setForcedDisplaySize(Display.DEFAULT_DISPLAY, mHdmiH, mHdmiW);
                mMirrorOn = true;
                toast(getString(R.string.hdmi_mirror_toast_on, mHdmiW, mHdmiH));
            } else {
                wm.clearForcedDisplaySize(Display.DEFAULT_DISPLAY);
                mMirrorOn = false;
                toast(getString(R.string.hdmi_mirror_toast_off));
            }
        } catch (Throwable t) {
            toast(getString(R.string.hdmi_mirror_fail) + ": " + t.getMessage());
        }
        reload();
    }

    private String describeSecs(int sec) {
        if (sec <= 0) {
            return getString(R.string.hdmi_panel_off_never);
        }
        if (sec < 60) {
            return getString(R.string.hdmi_panel_off_secs, sec);
        }
        return getString(R.string.hdmi_panel_off_mins, sec / 60);
    }

    private String describeHdmiPanelOff() {
        return mHdmiConnected ? describeSecs(mHdmiPanelOffSec)
                : getString(R.string.hdmi_panel_off_idle);
    }

    private void chooseHdmiPanelOff() {
        final int[] secs = {0, 15, 30, 60, 300};
        String[] labels = new String[secs.length];
        int checked = 0;
        for (int i = 0; i < secs.length; i++) {
            labels[i] = describeSecs(secs[i]);
            if (secs[i] == mHdmiPanelOffSec) {
                checked = i;
            }
        }
        new AlertDialog.Builder(this)
                .setTitle(R.string.hdmi_panel_off_title)
                .setSingleChoiceItems(labels, checked, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                        saveHdmiPanelOff(secs[which]);
                    }
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }

    private void saveHdmiPanelOff(int sec) {
        try {
            Settings.Global.putInt(getContentResolver(), KEY_HDMI_PANEL_OFF, sec);
            mHdmiPanelOffSec = sec;
            toast(getString(R.string.saved));
        } catch (Throwable t) {
            toast(String.valueOf(t.getMessage()));
        }
        reload();
    }

    private void saveHdmiOut(boolean on) {
        try {
            Settings.Global.putInt(getContentResolver(), KEY_HDMI_OUT, on ? 1 : 0);
            mHdmiOut = on;
            toast(getString(on ? R.string.hdmi_out_toast_on
                    : R.string.hdmi_out_toast_off));
        } catch (Throwable t) {
            toast(String.valueOf(t.getMessage()));
        }
        reload();
    }

    // ----------------------------------------------------------------- audio

    private void initAudio() {
        try {
            mAm = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
        } catch (Throwable ignored) {
            mAm = null;
        }
        if (mAm == null) {
            return;
        }
        // 找「媒体」产品策略（输出切换挂在它上面）
        try {
            for (AudioProductStrategy s : AudioProductStrategy.getAudioProductStrategies()) {
                try {
                    AudioAttributes aa = s.getAudioAttributes();
                    if (aa != null && aa.getUsage() == AudioAttributes.USAGE_MEDIA) {
                        mMediaStrategy = s;
                        break;
                    }
                } catch (Throwable ignored) {
                }
            }
            if (mMediaStrategy == null) {
                AudioAttributes media = new AudioAttributes.Builder()
                        .setUsage(AudioAttributes.USAGE_MEDIA)
                        .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC).build();
                for (AudioProductStrategy s : AudioProductStrategy.getAudioProductStrategies()) {
                    if (s.supportsAudioAttributes(media)) {
                        mMediaStrategy = s;
                        break;
                    }
                }
            }
        } catch (Throwable ignored) {
        }
        try {
            mAm.registerAudioDeviceCallback(mDevCb, null);
        } catch (Throwable ignored) {
        }
    }

    private static boolean isUsableOutput(int type) {
        switch (type) {
            case AudioDeviceInfo.TYPE_BUILTIN_SPEAKER:
            case AudioDeviceInfo.TYPE_BUILTIN_EARPIECE:
            case AudioDeviceInfo.TYPE_WIRED_HEADSET:
            case AudioDeviceInfo.TYPE_WIRED_HEADPHONES:
            case AudioDeviceInfo.TYPE_HDMI:
            case AudioDeviceInfo.TYPE_HDMI_ARC:
            case AudioDeviceInfo.TYPE_BLUETOOTH_A2DP:
            case AudioDeviceInfo.TYPE_BLUETOOTH_SCO:
            case AudioDeviceInfo.TYPE_USB_HEADSET:
            case AudioDeviceInfo.TYPE_USB_DEVICE:
                return true;
            default:
                return false;
        }
    }

    private void refreshAudio() {
        mAudioOuts.clear();
        mPrefDevId = -1;
        if (mAm == null) {
            return;
        }
        try {
            AudioDeviceInfo[] devs = mAm.getDevices(AudioManager.GET_DEVICES_OUTPUTS);
            if (devs != null) {
                for (AudioDeviceInfo d : devs) {
                    if (isUsableOutput(d.getType())) {
                        mAudioOuts.add(d);
                    }
                }
            }
        } catch (Throwable ignored) {
        }
        try {
            if (mMediaStrategy != null) {
                AudioDeviceAttributes a = mAm.getPreferredDeviceForStrategy(mMediaStrategy);
                if (a != null) {
                    for (AudioDeviceInfo d : mAudioOuts) {
                        if (d.getType() == a.getType()) {
                            mPrefDevId = d.getId();
                            break;
                        }
                    }
                    if (mPrefDevId == -1) {
                        mPrefDevId = -2;
                    }
                }
            }
        } catch (Throwable ignored) {
        }
    }

    private String audioTypeName(int type) {
        switch (type) {
            case AudioDeviceInfo.TYPE_BUILTIN_SPEAKER:
                return getString(R.string.audio_speaker);
            case AudioDeviceInfo.TYPE_BUILTIN_EARPIECE:
                return getString(R.string.audio_earpiece);
            case AudioDeviceInfo.TYPE_WIRED_HEADSET:
                return getString(R.string.audio_headset);
            case AudioDeviceInfo.TYPE_WIRED_HEADPHONES:
                return getString(R.string.audio_headphone);
            case AudioDeviceInfo.TYPE_HDMI:
            case AudioDeviceInfo.TYPE_HDMI_ARC:
                return getString(R.string.audio_hdmi);
            case AudioDeviceInfo.TYPE_BLUETOOTH_A2DP:
            case AudioDeviceInfo.TYPE_BLUETOOTH_SCO:
                return getString(R.string.audio_bt);
            case AudioDeviceInfo.TYPE_USB_HEADSET:
            case AudioDeviceInfo.TYPE_USB_DEVICE:
                return getString(R.string.audio_usb);
            default:
                return getString(R.string.audio_other);
        }
    }

    private String audioLabel(AudioDeviceInfo d) {
        String n = audioTypeName(d.getType());
        try {
            CharSequence pn = d.getProductName();
            if (pn != null && pn.length() > 0
                    && String.valueOf(pn).compareToIgnoreCase(n) != 0) {
                return n + " · " + pn;
            }
        } catch (Throwable ignored) {
        }
        return n;
    }

    private String audioCurrentText() {
        if (mAm == null || mMediaStrategy == null) {
            return getString(R.string.audio_unsupported);
        }
        if (mPrefDevId >= 0) {
            for (AudioDeviceInfo d : mAudioOuts) {
                if (d.getId() == mPrefDevId) {
                    return getString(R.string.audio_cur_fixed, audioLabel(d));
                }
            }
        }
        if (mPrefDevId == -2) {
            return getString(R.string.audio_cur_missing);
        }
        try {
            AudioAttributes media = new AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_MEDIA).build();
            List<AudioDeviceAttributes> cur = mAm.getDevicesForAttributes(media);
            if (cur != null && !cur.isEmpty()) {
                StringBuilder sb = new StringBuilder();
                for (AudioDeviceAttributes a : cur) {
                    if (sb.length() > 0) {
                        sb.append(", ");
                    }
                    sb.append(audioTypeName(a.getType()));
                }
                return getString(R.string.audio_cur_auto_fmt, sb.toString());
            }
        } catch (Throwable ignored) {
        }
        return getString(R.string.audio_cur_auto);
    }

    private AudioDeviceInfo findDev(int id) {
        for (AudioDeviceInfo d : mAudioOuts) {
            if (d.getId() == id) {
                return d;
            }
        }
        return null;
    }

    private void setAudioOutput(int devId) {
        if (mAm == null || mMediaStrategy == null) {
            toast(getString(R.string.audio_unsupported));
            return;
        }
        try {
            if (devId < 0) {
                mAm.removePreferredDeviceForStrategy(mMediaStrategy);
                mPrefDevId = -1;
                toast(getString(R.string.audio_auto_set));
            } else {
                AudioDeviceInfo d = findDev(devId);
                if (d == null) {
                    toast(getString(R.string.audio_failed));
                    return;
                }
                boolean ok = mAm.setPreferredDeviceForStrategy(
                        mMediaStrategy, new AudioDeviceAttributes(d));
                mPrefDevId = ok ? devId : -1;
                toast(getString(ok ? R.string.audio_set_ok : R.string.audio_failed));
            }
        } catch (Throwable t) {
            toast(getString(R.string.audio_failed));
        }
        buildRows();
        mAdapter.notifyDataSetChanged();
    }

    // ------------------------------------------------------------ rows model

    /**
     * v156 界面重构：一页到底 → 主菜单 + 分类页。
     *
     * mGroup < 0 显示主菜单（六个入口，每个带实时摘要）；否则只渲染该分组的行。
     * 所有业务逻辑（点击分发、开关状态、实时刷新）完全沿用，只是行的组织方式变了。
     */
    private void buildRows() {
        mRows.clear();
        if (mGroup < 0) {
            buildHome();
            return;
        }
        switch (mGroup) {
            case G_NET:     buildGroupNet();     break;
            case G_DISPLAY: buildGroupDisplay(); break;
            case G_AUDIO:   buildGroupAudio();   break;
            case G_USB:     buildGroupUsb();     break;
            case G_BT:      buildGroupBt();      break;
            case G_SYSTEM:  buildGroupSystem();  break;
            default:        mGroup = -1;         buildHome(); break;
        }
    }

    /** 主菜单：分类入口，每个带一行实时摘要。 */
    private void buildHome() {
        mRows.add(Row.header());
        mRows.add(Row.nav(R.string.grp_net,     navNetSummary(),     G_NET));
        mRows.add(Row.nav(R.string.grp_display, navDisplaySummary(), G_DISPLAY));
        mRows.add(Row.nav(R.string.grp_audio,   navAudioSummary(),   G_AUDIO));
        mRows.add(Row.nav(R.string.grp_usb,     navUsbSummary(),     G_USB));
        // v164: 去掉「蓝牙」入口。
        //   系统里 com.android.settings 是完整可用的（已实测
        //   android.settings.BLUETOOTH_SETTINGS 能打开：开关/配对/搜索/已连接设备一应俱全），
        //   本页的蓝牙功能与之完全重复。代码保留（G_BT 分支未删），以后要恢复只需加回这一行。
        mRows.add(Row.nav(R.string.grp_system,  navSystemSummary(),  G_SYSTEM));
    }

    /** 摘要太长会撑爆主菜单，截一下。 */
    private String brief(String s, int max) {
        if (s == null) return "";
        String t = s.replace('\n', ' ').trim();
        return t.length() <= max ? t : t.substring(0, max) + "\u2026";
    }

    private String navNetSummary() {
        if (!mEthSupported) return getString(R.string.eth_unsupported);
        // v164: 不再有"已开启/已关闭"前缀（总开关已去掉），只报链路状态
        String st = brief(ethStatusText(), 32);
        return st.isEmpty() ? getString(R.string.eth_no_link) : st;
    }

    private String navDisplaySummary() {
        String hdmi = mHdmiConnected
                ? getString(R.string.grp_hdmi_connected, mHdmiW, mHdmiH)
                : getString(R.string.grp_hdmi_disconnected);
        // v164: 投屏开关已从本页移除，摘要改用「双击唤醒」这个仍在本页的开关
        return hdmi + " \u00b7 "
                + getString(mDt2w ? R.string.grp_dt2w_on : R.string.grp_dt2w_off);
    }

    private String navAudioSummary() {
        return brief(audioCurrentText(), 40);
    }

    private String navUsbSummary() {
        return brief(usbModeSummary(), 24) + " \u00b7 "
                + getString(R.string.grp_gamepad_prefix) + describeGamepadGame();
    }

    private String navBtSummary() {
        return brief(btSummary(), 40);
    }

    private String navSystemSummary() {
        // 广告拦截的完整描述带规则数/拦截数，主菜单只取首段（「广告拦截已开启」）
        String a = adblockSummary();
        int cut = a.indexOf(" \u00b7 ");
        if (cut > 0) a = a.substring(0, cut);
        // v164: 去掉存储占用（存储段已删除）
        return getString(R.string.grp_adblock_prefix) + brief(a, 16);
    }

    /** 内部存储的极简表示：已用 / 总容量，去掉了中文量词。 */
    private String storageShort() {
        try {
            java.io.File f = android.os.Environment.getDataDirectory();
            long total = f.getTotalSpace();
            long free = f.getFreeSpace();
            long used = total - free;
            return gb(used) + " / " + gb(total) + " GB";
        } catch (Throwable t) {
            return internalStorageText();
        }
    }

    private String gb(long bytes) {
        return String.format(java.util.Locale.US, "%.1f", bytes / 1024.0 / 1024 / 1024);
    }

    // ============================================================ 分组：网络与连接

    private void buildGroupNet() {
        mRows.add(Row.section(R.string.sec_net));
        if (mEthSupported) {
            // v164: 去掉「有线网络」总开关。
            //   本机网卡是 W5500，eth0 是链路相关的（不插网线根本没有 eth0），
            //   EthernetManager 那个"启用/禁用网卡"的开关实际什么也改变不了，
            //   只会让人误以为可以关掉网口。直接去掉，只保留状态与配置。
            mRows.add(Row.info(R.string.eth_status_title, ethStatusText()));
            mRows.add(Row.action(R.string.eth_mode_title,
                    getString(mIsStatic ? R.string.eth_mode_static : R.string.eth_mode_dhcp),
                    K_ETH_MODE));
            if (mIsStatic) {
                mRows.add(Row.action(R.string.eth_static_ip, nzOr(mStaticIp), K_ETH_IP));
                mRows.add(Row.action(R.string.eth_static_prefix,
                        String.valueOf(mStaticPrefix <= 0 ? 24 : mStaticPrefix), K_ETH_PREFIX));
                mRows.add(Row.action(R.string.eth_static_gw, nzOr(mStaticGw), K_ETH_GW));
                mRows.add(Row.action(R.string.eth_static_dns, nzOr(mStaticDns), K_ETH_DNS));
            }
            mRows.add(Row.info(R.string.eth_addr_title, nzOr(mEthAddr)));
            mRows.add(Row.info(R.string.eth_gw_title, nzOr(mEthGw)));
            mRows.add(Row.info(R.string.eth_dns_title, nzOr(mEthDns)));
            mRows.add(Row.info(R.string.eth_mac_title, nzOr(mEthMac)));
            mRows.add(Row.info(R.string.eth_speed_title, getString(R.string.eth_speed_value)));
            mRows.add(Row.note(R.string.eth_speed_note_title, getString(R.string.eth_speed_note)));
        } else {
            mRows.add(Row.note(0, getString(R.string.eth_unsupported)));
        }
    }

    // ============================================================ 分组：显示与投屏

    private void buildGroupDisplay() {
        // 屏幕
        mRows.add(Row.section(R.string.sec_screen));
        mRows.add(Row.sw(R.string.dt2w_title, describeDt2w(), K_DT2W));

        // 外接显示（HDMI）
        mRows.add(Row.section(R.string.sec_display));
        mRows.add(Row.info(R.string.hdmi_status_title,
                mHdmiConnected
                        ? getString(R.string.hdmi_connected, mHdmiW, mHdmiH)
                        : getString(R.string.hdmi_disconnected)));
        if (mHdmiConnected) {
            mRows.add(Row.sw(R.string.hdmi_mirror_title, describeMirror(), K_HDMI_MIRROR));
            mRows.add(Row.sw(R.string.hdmi_out_title, describeHdmiOut(), K_HDMI_OUT));
            mRows.add(Row.action(R.string.hdmi_panel_off_title,
                    describeHdmiPanelOff(), K_HDMI_PANEL_OFF));
            mRows.add(Row.note(0, getString(R.string.hdmi_note)));
        }

        // 投屏接收
        // v164: 去掉「接收投屏」开关和「接收状态」两行。
        //   投屏 App 自己的界面里已经有完整开关与实时状态，这里重复显示反而
        //   让人以为要两边都打开；只保留一个进入投屏界面的入口。
        mRows.add(Row.section(R.string.sec_cast));
        mRows.add(Row.action(R.string.cast_open_title,
                getString(R.string.cast_open_summary), K_CAST_OPEN));
    }

    // ============================================================ 分组：音频输出

    private void buildGroupAudio() {
        mRows.add(Row.section(R.string.sec_audio));
        mRows.add(Row.info(R.string.audio_current_title, audioCurrentText()));
        mRows.add(Row.radio(getString(R.string.audio_auto), mPrefDevId < 0, K_AUDIO_AUTO, -1));
        for (AudioDeviceInfo d : mAudioOuts) {
            mRows.add(Row.radio(audioLabel(d), mPrefDevId == d.getId(), K_AUDIO_DEV, d.getId()));
        }
        mRows.add(Row.note(0, getString(R.string.audio_note)));
    }

    // ============================================================ 分组：USB 与外设

    private void buildGroupUsb() {
        mRows.add(Row.section(R.string.sec_usb));
        // 三态可点击行（点一下循环：自动 -> 强制主机 -> 强制从机）
        mRows.add(Row.action(R.string.usb_mode_title, usbModeSummary(), K_USB_MODE));
        mRows.add(Row.info(R.string.usb_dev_title, usbDeviceText(), K_USB_DEV));
        // 一键修复「从机却在供电」的双 VBUS 状态
        mRows.add(Row.action(R.string.usb_heal_title, usbHealSummary(), K_USB_HEAL));
        // U 盘模式（把 SD 卡当 U 盘给电脑）
        mRows.add(Row.sw(R.string.usb_msc_title, mscSummary(), K_USB_MSC));
        mRows.add(Row.note(0, getString(R.string.usb_otg_note)));

        mRows.add(Row.section(R.string.sec_key));
        mRows.add(Row.action(R.string.key_f1, describe(mF1), K_F1));
        mRows.add(Row.action(R.string.key_f2, describe(mF2), K_F2));
        mRows.add(Row.sw(R.string.gamepad_game_title, describeGamepadGame(), K_GAMEPAD_GAME));
    }

    // ============================================================ 分组：蓝牙

    private void buildGroupBt() {
        mRows.add(Row.section(R.string.sec_bt));
        mRows.add(Row.sw(R.string.bt_enable_title, btSummary(), K_BT_ENABLE));
        mRows.add(Row.info(R.string.bt_state_title, btStateText()));
        mRows.add(Row.action(R.string.bt_scan_title, btScanSummary(), K_BT_SCAN));
        if (isBtOn()) {
            mRows.add(Row.note(R.string.bt_bonded_title, ""));
            if (mBonded.isEmpty()) {
                mRows.add(Row.note(0, getString(R.string.bt_none_bonded)));
            } else {
                for (int i = 0; i < mBonded.size(); i++) {
                    BluetoothDevice d = mBonded.get(i);
                    mRows.add(Row.actionStr(safeName(d), btDeviceSummary(d),
                            K_BT_DEV + i, i));
                }
            }
            mRows.add(Row.note(R.string.bt_found_title, ""));
            // 只列有名字的（无名的多是 BLE 信标，MAC 一行行刷屏），最多 20 个
            int shown = 0;
            for (int i = 0; i < mFound.size() && shown < 20; i++) {
                BluetoothDevice d = mFound.get(i);
                if (!hasRealName(d)) {
                    continue;
                }
                mRows.add(Row.actionStr(safeName(d), btDeviceSummary(d),
                        K_BT_FOUND + i, i));
                shown++;
            }
            if (shown == 0) {
                mRows.add(Row.note(0, getString(R.string.bt_none_found)));
            }
        }
    }

    // ============================================================ 分组：系统与存储

    private void buildGroupSystem() {
        // 充电
        mRows.add(Row.section(R.string.sec_charge));
        mRows.add(Row.sw(R.string.bypass_title, describeBypass(), K_BYPASS));

        // 广告拦截
        mRows.add(Row.section(R.string.sec_adblock));
        mRows.add(Row.sw(R.string.adb_title, adblockSummary(), K_ADB_BLOCK));
        // v164: 拦截关键词可自定义（原来写死在 root 脚本里，改不了）
        mRows.add(Row.action(R.string.adb_rules_title, adbRulesSummary(), K_ADB_RULES));
        mRows.add(Row.note(0, getString(R.string.adb_note)));

        // v164: 去掉「存储」段 —— 系统 Settings 的「存储」页信息更全（分类明细、
        //   各 App 占用），这里只有两行总量，属于重复展示。

        // 网络定位（本机无 GNSS 硬件，靠固定坐标 + geo-IP）
        mRows.add(Row.section(R.string.sec_nlp));
        mRows.add(Row.action(R.string.nlp_title, nlpSummary(), K_NLP));
    }

    // ------------------------------------------------------ MS600 v140e 网络定位

    /** 当前固定坐标（persist 属性优先）；未设置时提示"未设置"。 */
    private String nlpSummary() {
        try {
            String lat = android.os.SystemProperties.get(
                    "persist.ms600.nlp.lat", "");
            String lon = android.os.SystemProperties.get(
                    "persist.ms600.nlp.lon", "");
            if (!lat.isEmpty() && !lon.isEmpty()) {
                return lat + ", " + lon;
            }
        } catch (Throwable ignored) {
        }
        return getString(R.string.nlp_unset);
    }

    /** 打开网络定位配置界面（MS600Nlp 的 ConfigActivity）。 */
    private void openNlpUi() {
        try {
            Intent i = new Intent();
            i.setClassName("com.iflytek.ms600.nlp",
                    "com.iflytek.ms600.nlp.ConfigActivity");
            startActivity(i);
        } catch (Throwable t) {
            Toast.makeText(this, R.string.nlp_missing,
                    Toast.LENGTH_SHORT).show();
        }
    }


    // ============================================================ MS600 v153 蓝牙

    private void initBt() {
        try {
            mBt = BluetoothAdapter.getDefaultAdapter();
        } catch (Throwable ignored) {
            mBt = null;
        }
    }

    private boolean isBtOn() {
        try {
            return mBt != null && mBt.isEnabled();
        } catch (Throwable ignored) {
            return false;
        }
    }

    private void refreshBt() {
        if (mBt == null) {
            initBt();
        }
        mBonded.clear();
        if (isBtOn()) {
            try {
                Set<BluetoothDevice> s = mBt.getBondedDevices();
                if (s != null) {
                    mBonded.addAll(s);
                }
            } catch (Throwable ignored) {
            }
        }
        Collections.sort(mBonded, new Comparator<BluetoothDevice>() {
            @Override
            public int compare(BluetoothDevice a, BluetoothDevice b) {
                return safeName(a).compareToIgnoreCase(safeName(b));
            }
        });
        // 已配对的从「附近设备」里剔掉，避免重复显示
        for (int i = mFound.size() - 1; i >= 0; i--) {
            try {
                if (mFound.get(i).getBondState() == BluetoothDevice.BOND_BONDED) {
                    mFound.remove(i);
                }
            } catch (Throwable ignored) {
            }
        }
        if (!isBtOn()) {
            mDiscovering = false;
        }
    }

    /** 有名字（不是只有 MAC）才值得显示。 */
    private boolean hasRealName(BluetoothDevice d) {
        try {
            String n = safeName(d);
            return n != null && !n.equalsIgnoreCase(d.getAddress());
        } catch (Throwable t) {
            return false;
        }
    }

    private String safeName(BluetoothDevice d) {
        try {
            String n = d.getAlias();
            if (n == null || n.trim().isEmpty()) {
                n = d.getName();
            }
            if (n == null || n.trim().isEmpty()) {
                n = d.getAddress();
            }
            return n;
        } catch (Throwable t) {
            return "?";
        }
    }

    private String btSummary() {
        if (mBt == null) {
            return getString(R.string.bt_no_hw);
        }
        return getString(isBtOn() ? R.string.bt_on : R.string.bt_off);
    }

    private String btStateText() {
        try {
            if (mBt == null) {
                return getString(R.string.bt_no_hw);
            }
            String n = mBt.getName();
            if (n == null || n.trim().isEmpty()) {
                n = mBt.getAddress();
            }
            return n;
        } catch (Throwable t) {
            return "-";
        }
    }

    private String btScanSummary() {
        if (mDiscovering) {
            return getString(R.string.bt_scanning);
        }
        if (!isBtOn()) {
            return getString(R.string.bt_need_on);
        }
        return getString(R.string.bt_scan_hit, mFound.size());
    }

    private String btDeviceSummary(BluetoothDevice d) {
        try {
            if (d.isConnected()) {
                return getString(R.string.bt_connected);
            }
            switch (d.getBondState()) {
                case BluetoothDevice.BOND_BONDED:
                    return getString(R.string.bt_bonded);
                case BluetoothDevice.BOND_BONDING:
                    return getString(R.string.bt_bonding);
                default:
                    return d.getAddress();
            }
        } catch (Throwable t) {
            return "";
        }
    }

    private void toggleBt(boolean on) {
        if (mBt == null) {
            toast(getString(R.string.bt_no_hw));
            return;
        }
        try {
            if (on) {
                if (!mBt.enable()) {
                    toast(getString(R.string.bt_op_fail));
                }
            } else {
                mFound.clear();
                mDiscovering = false;
                if (!mBt.disable()) {
                    toast(getString(R.string.bt_op_fail));
                }
            }
        } catch (Throwable t) {
            toast(getString(R.string.bt_op_fail));
        }
        reload();
    }

    private void startBtScan() {
        if (mBt == null) {
            toast(getString(R.string.bt_no_hw));
            return;
        }
        if (!isBtOn()) {
            toast(getString(R.string.bt_need_on));
            return;
        }
        // MS600 v153: Android 11 的蓝牙扫描要求 ACCESS_FINE_LOCATION（危险权限，需运行时授权）
        if (checkSelfPermission(android.Manifest.permission.ACCESS_FINE_LOCATION)
                != PackageManager.PERMISSION_GRANTED) {
            requestPermissions(
                    new String[]{android.Manifest.permission.ACCESS_FINE_LOCATION},
                    REQ_BT_LOC);
            return;
        }
        try {
            if (mBt.isDiscovering()) {
                mBt.cancelDiscovery();
            }
            mFound.clear();
            if (!mBt.startDiscovery()) {
                toast(getString(R.string.bt_scan_fail));
            }
        } catch (Throwable t) {
            toast(getString(R.string.bt_scan_fail));
        }
        reload();
    }

    @Override
    public void onRequestPermissionsResult(int req, String[] perms, int[] res) {
        super.onRequestPermissionsResult(req, perms, res);
        if (req == REQ_BT_LOC) {
            if (res != null && res.length > 0
                    && res[0] == PackageManager.PERMISSION_GRANTED) {
                startBtScan();
            } else {
                toast(getString(R.string.bt_need_loc));
            }
        }
    }

    private void ensureBtProfiles() {
        if (mBt == null) {
            return;
        }
        if (mHid == null) {
            try {
                mBt.getProfileProxy(this, new BluetoothProfile.ServiceListener() {
                    @Override
                    public void onServiceConnected(int profile, BluetoothProfile proxy) {
                        mHid = (BluetoothHidHost) proxy;
                    }

                    @Override
                    public void onServiceDisconnected(int profile) {
                        mHid = null;
                    }
                }, BluetoothProfile.HID_HOST);
            } catch (Throwable ignored) {
            }
        }
        if (mA2dp == null) {
            try {
                mBt.getProfileProxy(this, new BluetoothProfile.ServiceListener() {
                    @Override
                    public void onServiceConnected(int profile, BluetoothProfile proxy) {
                        mA2dp = (BluetoothA2dp) proxy;
                    }

                    @Override
                    public void onServiceDisconnected(int profile) {
                        mA2dp = null;
                    }
                }, BluetoothProfile.A2DP);
            } catch (Throwable ignored) {
            }
        }
    }

    private void btConnect(BluetoothDevice d) {
        ensureBtProfiles();
        boolean ok = false;
        try {
            if (mHid != null && mHid.connect(d)) {
                ok = true;
            }
        } catch (Throwable ignored) {
        }
        try {
            if (mA2dp != null && mA2dp.connect(d)) {
                ok = true;
            }
        } catch (Throwable ignored) {
        }
        toast(getString(ok ? R.string.bt_connecting : R.string.bt_op_fail));
    }

    private void btDisconnect(BluetoothDevice d) {
        try {
            if (mHid != null) {
                mHid.disconnect(d);
            }
        } catch (Throwable ignored) {
        }
        try {
            if (mA2dp != null) {
                mA2dp.disconnect(d);
            }
        } catch (Throwable ignored) {
        }
        toast(getString(R.string.bt_disconnecting));
    }

    private void btUnpair(BluetoothDevice d) {
        try {
            if (d.removeBond()) {
                toast(getString(R.string.bt_unpairing));
            } else {
                toast(getString(R.string.bt_op_fail));
            }
        } catch (Throwable t) {
            toast(getString(R.string.bt_op_fail));
        }
    }

    private void showBtDeviceDialog(final BluetoothDevice d, final boolean bonded) {
        final String[] items = bonded
                ? new String[]{getString(R.string.bt_connect),
                        getString(R.string.bt_disconnect),
                        getString(R.string.bt_unpair)}
                : new String[]{getString(R.string.bt_pair)};
        new AlertDialog.Builder(this)
                .setTitle(safeName(d))
                .setItems(items, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        if (!bonded) {
                            try {
                                if (!d.createBond()) {
                                    toast(getString(R.string.bt_op_fail));
                                }
                            } catch (Throwable t) {
                                toast(getString(R.string.bt_op_fail));
                            }
                        } else if (which == 0) {
                            btConnect(d);
                        } else if (which == 1) {
                            btDisconnect(d);
                        } else {
                            btUnpair(d);
                        }
                    }
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }

    // ============================================================ MS600 v153 存储

    private String fmtSize(long b) {
        if (b >= 1073741824L) {
            return String.format(Locale.US, "%.1f GB", b / 1073741824.0);
        }
        if (b >= 1048576L) {
            return String.format(Locale.US, "%.0f MB", b / 1048576.0);
        }
        return String.format(Locale.US, "%.0f KB", b / 1024.0);
    }

    /**
     * MS600 v153b: App 在受限存储下看不到 /storage/<uuid>（Android 11 只给 emulated），
     * 所以容量由 root 的 ms600_usb_auto.sh 定时写进 files/storage.txt，这里只读。
     * 格式：internal <usedKB> <totalKB> / sd <label|- > <usedKB> <totalKB>
     */
    private String[] readStorageFile(String key) {
        try {
            File f = new File(getFilesDir(), "storage.txt");
            if (!f.exists()) {
                return null;
            }
            BufferedReader r = new BufferedReader(new FileReader(f));
            String line;
            while ((line = r.readLine()) != null) {
                if (line.startsWith(key + " ")) {
                    r.close();
                    return line.split(" ");
                }
            }
            r.close();
        } catch (Throwable ignored) {
        }
        return null;
    }

    private String kbToText(long kb) {
        return fmtSize(kb * 1024L);
    }

    private String internalStorageText() {
        String[] st = readStorageFile("internal");
        if (st != null && st.length >= 3) {
            try {
                return getString(R.string.storage_used_of,
                        kbToText(Long.parseLong(st[1])), kbToText(Long.parseLong(st[2])));
            } catch (Throwable ignored) {
            }
        }
        try {
            android.os.StatFs s = new android.os.StatFs("/data");
            long total = s.getTotalBytes();
            long avail = s.getAvailableBytes();
            return getString(R.string.storage_used_of, fmtSize(total - avail), fmtSize(total));
        } catch (Throwable t) {
            return getString(R.string.storage_na);
        }
    }

    /** 已挂载的可移除卷名（如 BA22-100D）；没有则 null。 */
    private String sdMountPath() {
        String[] t = readStorageFile("sd");
        if (t != null && t.length >= 2 && !"-".equals(t[1])) {
            return "/storage/" + t[1];
        }
        return null;
    }

    private String sdStorageText() {
        String[] t = readStorageFile("sd");
        if (t != null && t.length >= 4 && !"-".equals(t[1])) {
            try {
                return getString(R.string.storage_sd_mounted, t[1],
                        kbToText(Long.parseLong(t[2])), kbToText(Long.parseLong(t[3])));
            } catch (Throwable ignored) {
            }
        }
        return getString(R.string.storage_sd_absent);
    }

    // ============================================================ MS600 v153 U 盘模式

    // ------------------------------------------------------ MS600 v155 广告拦截
    // App 只负责写开关文件、读统计文件；真正的 iptables 由 root daemon 落。
    private boolean isAdblockOn() {
        try {
            File f = new File(getFilesDir(), "adblock");
            if (!f.exists()) {
                return false;
            }
            BufferedReader r = new BufferedReader(new FileReader(f));
            String s = r.readLine();
            r.close();
            return s != null && s.trim().startsWith("1");
        } catch (Throwable t) {
            return false;
        }
    }

    /** daemon 写的统计：一行 "状态 规则数 命中包数"。读不到返回 null。 */
    private int[] adblockStat() {
        try {
            File f = new File(getFilesDir(), "adblock_stat");
            if (!f.exists()) {
                return null;
            }
            BufferedReader r = new BufferedReader(new FileReader(f));
            String s = r.readLine();
            r.close();
            if (s == null) {
                return null;
            }
            String[] p = s.trim().split("\\s+");
            if (p.length < 3) {
                return null;
            }
            return new int[]{Integer.parseInt(p[0]), Integer.parseInt(p[1]), Integer.parseInt(p[2])};
        } catch (Throwable t) {
            return null;
        }
    }

    private String adblockSummary() {
        if (!isAdblockOn()) {
            return getString(R.string.adb_off);
        }
        int[] st = adblockStat();
        if (st == null || st[0] != 1) {
            return getString(R.string.adb_on_plain);
        }
        return getString(R.string.adb_on, st[2], st[1]);
    }

    private void toggleAdblock(boolean on) {
        try {
            FileOutputStream o = new FileOutputStream(new File(getFilesDir(), "adblock"));
            o.write((on ? "1\n" : "0\n").getBytes("UTF-8"));
            o.close();
        } catch (Throwable t) {
            toast(getString(R.string.adb_fail));
            reload();
            return;
        }
        toast(getString(on ? R.string.adb_on_toast : R.string.adb_off_toast));
        reload();
    }

    // ------------------------------------------------------ v164 拦截规则编辑

    /** 出厂默认关键词 —— 与 /system/etc/ms600_usb_auto.sh 的 ADB_KEYS_DEFAULT 保持一致。 */
    private static final String ADB_DEFAULT_KEYS =
            "doubleclick googleadservices googlesyndication google-analytics "
            + "cpro.baidu.com pos.baidu.com tanx.com alimama.com "
            + "pangolin.snssdk gromore.snssdk gdt.qq.com";

    private File adbRulesFile() {
        return new File(getFilesDir(), "adblock_keys");
    }

    /** 上一次 adbRules() 的结果是否真的来自用户文件（false = 回退到出厂列表）。 */
    private boolean mAdbRulesFromFile = false;

    /** 当前生效的关键词：用户文件优先，没有或读不出来就用出厂列表。 */
    private List<String> adbRules() {
        List<String> out = new ArrayList<String>();
        mAdbRulesFromFile = false;
        try {
            File f = adbRulesFile();
            if (f.exists()) {
                BufferedReader r = new BufferedReader(new FileReader(f));
                String s;
                while ((s = r.readLine()) != null) {
                    s = s.trim();
                    if (s.length() > 0 && !s.startsWith("#")) {
                        out.add(s);
                    }
                }
                r.close();
            }
        } catch (Throwable ignored) {
        }
        if (!out.isEmpty()) {
            mAdbRulesFromFile = true;
        } else {
            for (String s : ADB_DEFAULT_KEYS.split("\\s+")) {
                if (s.length() > 0) {
                    out.add(s);
                }
            }
        }
        return out;
    }

    private String adbRulesSummary() {
        int n = adbRules().size();
        return getString(mAdbRulesFromFile ? R.string.adb_rules_sum_custom
                : R.string.adb_rules_sum_default, n);
    }

    /** 关键词只允许字母数字和 . - _ ，避免拼进 iptables 命令时把参数写坏。 */
    private static boolean isKeySafe(String s) {
        if (s.length() == 0 || s.length() > 64) {
            return false;
        }
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            boolean ok = (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')
                    || (c >= '0' && c <= '9') || c == '.' || c == '-' || c == '_';
            if (!ok) {
                return false;
            }
        }
        return true;
    }

    private void showAdblockRulesDialog() {
        final List<String> cur = adbRules();
        int pad = dp(20);

        LinearLayout box = new LinearLayout(this);
        box.setOrientation(LinearLayout.VERTICAL);
        box.setPadding(pad, dp(14), pad, 0);

        TextView tip = new TextView(this);
        tip.setText(getString(R.string.adb_rules_help));
        tip.setTextSize(TypedValue.COMPLEX_UNIT_SP, 13);
        tip.setTextColor(0xFF5F6368);
        tip.setLineSpacing(dp(3), 1.0f);
        tip.setPadding(0, 0, 0, dp(10));
        box.addView(tip);

        final EditText et = new EditText(this);
        et.setInputType(InputType.TYPE_CLASS_TEXT
                | InputType.TYPE_TEXT_FLAG_MULTI_LINE
                | InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS);
        et.setMinLines(8);
        et.setMaxLines(12);
        et.setGravity(Gravity.TOP | Gravity.START);
        et.setTypeface(Typeface.MONOSPACE);
        et.setTextSize(TypedValue.COMPLEX_UNIT_SP, 14);
        StringBuilder sb = new StringBuilder();
        for (String s : cur) {
            sb.append(s).append('\n');
        }
        et.setText(sb.toString().trim());
        box.addView(et);

        new AlertDialog.Builder(this)
                .setTitle(getString(R.string.adb_rules_dlg_title, cur.size()))
                .setView(box)
                .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        saveAdblockRules(et.getText().toString());
                    }
                })
                .setNeutralButton(R.string.adb_rules_reset, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        adbRulesFile().delete();
                        toast(getString(R.string.adb_rules_reset_done));
                        reload();
                    }
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }

    private void saveAdblockRules(String text) {
        // 允许换行或空格/逗号分隔；去重并保持输入顺序
        java.util.LinkedHashSet<String> set = new java.util.LinkedHashSet<String>();
        int bad = 0;
        for (String s : text.split("[\\s,]+")) {
            s = s.trim();
            if (s.length() == 0) {
                continue;
            }
            if (!isKeySafe(s)) {
                bad++;
                continue;
            }
            set.add(s);
        }
        if (set.isEmpty()) {
            toast(getString(R.string.adb_rules_empty));
            return;
        }
        try {
            FileOutputStream o = new FileOutputStream(adbRulesFile());
            StringBuilder sb = new StringBuilder();
            sb.append("# MS600 广告拦截关键词，每行一个\n");
            for (String s : set) {
                sb.append(s).append('\n');
            }
            o.write(sb.toString().getBytes("UTF-8"));
            o.close();
        } catch (Throwable t) {
            toast(getString(R.string.adb_rules_fail));
            return;
        }
        if (bad > 0) {
            toast(getString(R.string.adb_rules_saved_bad, set.size(), bad));
        } else {
            toast(getString(R.string.adb_rules_saved, set.size()));
        }
        reload();
    }

    private boolean isMscOn() {
        try {
            File f = new File(getFilesDir(), "usb_msc");
            if (!f.exists()) {
                return false;
            }
            BufferedReader r = new BufferedReader(new FileReader(f));
            String s = r.readLine();
            r.close();
            return s != null && s.trim().startsWith("1");
        } catch (Throwable t) {
            return false;
        }
    }

    private String mscSummary() {
        return getString(isMscOn() ? R.string.usb_msc_on : R.string.usb_msc_off);
    }

    // ------------------------------------------------------ MS600 v154 双 VBUS
    private String usbHealSummary() {
        return getString(UsbHelper.isDualVbus() ? R.string.usb_heal_bad : R.string.usb_heal_ok);
    }

    private void doHealUsb() {
        toast(getString(R.string.usb_heal_working));
        new Thread(new Runnable() {
            @Override
            public void run() {
                final boolean ok = UsbHelper.healUsb();
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        toast(getString(ok ? R.string.usb_heal_done : R.string.usb_heal_fail));
                        reload();
                    }
                });
            }
        }).start();
    }

    private boolean usbVbusIn() {
        return "1".equals(readSys("/sys/class/power_supply/usb/online"));
    }

    private void toggleMsc(boolean on) {
        if (on && !usbVbusIn()) {
            toast(getString(R.string.usb_msc_need_pc));
            reload();
            return;
        }
        if (on && sdMountPath() == null) {
            toast(getString(R.string.usb_msc_need_sd));
            reload();
            return;
        }
        try {
            FileOutputStream o = new FileOutputStream(new File(getFilesDir(), "usb_msc"));
            o.write((on ? "1\n" : "0\n").getBytes("UTF-8"));
            o.close();
        } catch (Throwable t) {
            toast(getString(R.string.usb_msc_fail));
            reload();
            return;
        }
        toast(getString(on ? R.string.usb_msc_on_toast : R.string.usb_msc_off_toast));
        reload();
    }

    private static class Row {
        int type;
        int titleRes;
        String title;
        String value;
        int key;
        int extra;

        static Row header() {
            Row r = new Row();
            r.type = RT_HEADER;
            return r;
        }

        static Row section(int titleRes) {
            Row r = new Row();
            r.type = RT_SECTION;
            r.titleRes = titleRes;
            return r;
        }

        /** v156: 主菜单的分组入口行 —— 标题 + 摘要（实时状态）+ 箭头。 */
        static Row nav(int titleRes, String value, int group) {
            Row r = new Row();
            r.type = RT_NAV;
            r.titleRes = titleRes;
            r.value = value;
            r.key = K_NAV + group;
            r.extra = group;
            return r;
        }

        static Row sw(int titleRes, String value, int key) {
            Row r = new Row();
            r.type = RT_SWITCH;
            r.titleRes = titleRes;
            r.value = value;
            r.key = key;
            return r;
        }

        static Row action(int titleRes, String value, int key) {
            Row r = new Row();
            r.type = RT_ACTION;
            r.titleRes = titleRes;
            r.value = value;
            r.key = key;
            return r;
        }

        /** MS600 v153: 标题是运行时字符串（蓝牙设备名）。 */
        static Row actionStr(String title, String value, int key, int extra) {
            Row r = new Row();
            r.type = RT_ACTION;
            r.title = title;
            r.value = value;
            r.key = key;
            r.extra = extra;
            return r;
        }

        static Row info(int titleRes, String value) {
            Row r = new Row();
            r.type = RT_INFO;
            r.titleRes = titleRes;
            r.value = value;
            return r;
        }

        /** MS600 v149: 带 key 的 info 行，渲染时可按 key 现算（用于「当前设备」） */
        static Row info(int titleRes, String value, int key) {
            Row r = info(titleRes, value);
            r.key = key;
            return r;
        }

        static Row radio(String title, boolean checked, int key, int extra) {
            Row r = new Row();
            r.type = RT_RADIO;
            r.title = title;
            r.value = checked ? "\u2713" : "";
            r.key = key;
            r.extra = extra;
            return r;
        }

        static Row note(int titleRes, String value) {
            Row r = new Row();
            r.type = RT_NOTE;
            r.titleRes = titleRes;
            r.value = value;
            return r;
        }
    }

    // ------------------------------------------------------------- key config

    private String describeBypass() {
        return mBypass ? getString(R.string.bypass_on) : getString(R.string.bypass_off);
    }

    private String describeDt2w() {
        return mDt2w ? getString(R.string.dt2w_on) : getString(R.string.dt2w_off);
    }

    private String describe(String v) {
        if (v == null || v.isEmpty() || "default".equals(v)) {
            return getString(R.string.act_default);
        }
        if ("none".equals(v)) {
            return getString(R.string.act_none);
        }
        if ("home".equals(v)) {
            return getString(R.string.act_home);
        }
        if ("recents".equals(v)) {
            return getString(R.string.act_recents);
        }
        if ("sleep".equals(v)) {
            return getString(R.string.act_sleep);
        }
        if (v.startsWith("app:")) {
            String spec = v.substring(4);
            String label = spec;
            try {
                ComponentName cn = ComponentName.unflattenFromString(spec);
                if (cn != null) {
                    PackageManager pm = getPackageManager();
                    label = String.valueOf(pm.getActivityInfo(cn, 0).loadLabel(pm));
                }
            } catch (Exception ignored) {
            }
            return getString(R.string.act_app_fmt, label);
        }
        if (v.startsWith("broadcast:")) {
            return getString(R.string.act_broadcast_fmt, v.substring(10));
        }
        if (v.startsWith("web:")) {
            String url = v.substring(4);
            if (url.length() > 48) {
                url = url.substring(0, 45) + "\u2026";
            }
            return getString(R.string.act_web_fmt, url);
        }
        return v;
    }

    private boolean putGlobal(String key, String value) {
        try {
            Settings.Global.putString(getContentResolver(), key, value == null ? "" : value);
            return true;
        } catch (SecurityException e) {
            toast(getString(R.string.need_perm));
            return false;
        }
    }

    private String describeGamepadGame() {
        return mGamepadGame ? getString(R.string.gamepad_game_on)
                : getString(R.string.gamepad_game_off);
    }

    private void saveGamepadGame(boolean on) {
        if (!putGlobal(KEY_GAMEPAD_GAME, on ? "1" : "0")) {
            return;
        }
        mGamepadGame = on;
        mAdapter.notifyDataSetChanged();
        toast(getString(on ? R.string.gamepad_game_toast_on : R.string.gamepad_game_toast_off));
    }

    // ------------------------------------------------------ MS600 v149 USB OTG

    // ------------------------------------------------------ MS600 v151 USB 模式

    /**
     * 「USB 模式」行的副标题：自动时把当前实际模式一并显示出来。
     */
    private String usbModeSummary() {
        if ("host".equals(mUsbMode)) {
            return getString(R.string.usb_mode_force_host);
        }
        if ("peripheral".equals(mUsbMode)) {
            return getString(R.string.usb_mode_force_periph);
        }
        String cur = UsbHelper.getMode();
        String label;
        if (UsbHelper.MODE_HOST.equals(cur)) {
            label = getString(R.string.usb_mode_cur_host);
        } else if (UsbHelper.MODE_PERIPHERAL.equals(cur)) {
            label = getString(R.string.usb_mode_cur_periph);
        } else {
            label = getString(R.string.usb_mode_cur_off);
        }
        return getString(R.string.usb_mode_auto, label);
    }

    /** 点一下循环：自动 -> 强制主机 -> 强制从机 -> 自动 */
    private void cycleUsbMode() {
        final String next;
        if ("auto".equals(mUsbMode)) {
            next = "host";
        } else if ("host".equals(mUsbMode)) {
            next = "peripheral";
        } else {
            next = "auto";
        }
        if (!putGlobal(KEY_USB_MODE, next)) {
            return;
        }
        mUsbMode = next;
        writeUsbModeMarker();
        applyUsbMode();
        mAdapter.notifyDataSetChanged();
        if ("auto".equals(next)) {
            toast(getString(R.string.usb_mode_toast_auto));
        } else if ("host".equals(next)) {
            toast(getString(R.string.usb_mode_toast_host));
        } else {
            toast(getString(R.string.usb_mode_toast_periph));
        }
    }

    /**
     * 把选择写给 init 守护脚本（它每秒读一次这个文件）。
     * 用 file 而不是 property：本 App 是 platform_app，写不了 persist.* 属性。
     */
    private void writeUsbModeMarker() {
        try {
            java.io.FileOutputStream out =
                    new java.io.FileOutputStream(new java.io.File(getFilesDir(), "usb_mode"), false);
            out.write(mUsbMode.getBytes("UTF-8"));
            out.close();
        } catch (Throwable ignored) {
        }
    }

    /** 强制模式立即生效；自动模式不干预，交给守护脚本 1 秒内接手。 */
    private void applyUsbMode() {
        if ("auto".equals(mUsbMode)) {
            return;
        }
        final String want = "host".equals(mUsbMode) ? UsbHelper.MODE_HOST : UsbHelper.MODE_PERIPHERAL;
        new Thread(new Runnable() {
            @Override
            public void run() {
                final boolean ok = UsbHelper.rebootMode(want);
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        if (!ok) {
                            toast(getString(R.string.usb_otg_no_perm));
                        }
                        mAdapter.notifyDataSetChanged();
                    }
                });
            }
        }, "ms600-usb-mode").start();
    }


    /** 「当前设备」行：显示接入的 U 盘卷名 / USB 设备产品名。 */
    private String usbDeviceText() {
        // MS600 v151: 当前模式直接读 sysfs（自动模式下 mOtgOn 已不存在）
        if (!UsbHelper.MODE_HOST.equals(UsbHelper.getMode())) {
            return getString(R.string.usb_dev_otg_off);
        }
        String d = UsbHelper.deviceLabel(this);
        return d != null ? d : getString(R.string.usb_dev_none);
    }

    // MS600 v151: 不再有开关式的 OTG，模式由 cycleUsbMode() 统一处理。

    private void doUsbEject() {
        toast(getString(R.string.usb_eject_working));
        new Thread(new Runnable() {
            @Override
            public void run() {
                final int r = UsbHelper.eject(MainActivity.this);
                final int msg;
                if (r == UsbHelper.EJECT_STORAGE_OK) {
                    msg = R.string.usb_eject_ok;
                } else if (r == UsbHelper.EJECT_STORAGE_FAIL) {
                    msg = R.string.usb_eject_fail;
                } else if (r == UsbHelper.EJECT_APP_STOPPED) {
                    msg = R.string.usb_eject_app;
                } else {
                    msg = R.string.usb_dev_none;
                }
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        toast(getString(msg));
                        mAdapter.notifyDataSetChanged();
                    }
                });
            }
        }, "ms600-usb-eject").start();
    }

    private void saveBypass(boolean on) {
        if (!putGlobal(KEY_BYPASS, on ? "1" : "0")) {
            return;
        }
        mBypass = on;
        mAdapter.notifyDataSetChanged();
        toast(getString(on ? R.string.bypass_toast_on : R.string.bypass_toast_off));
    }

    private void saveDt2w(boolean on) {
        if (!putGlobal(KEY_DT2W, on ? "1" : "0")) {
            return;
        }
        mDt2w = on;
        mAdapter.notifyDataSetChanged();
        toast(getString(on ? R.string.dt2w_toast_on : R.string.dt2w_toast_off));
    }

    private void saveAction(int which, String value) {
        if (!putGlobal(which == 1 ? KEY_F1 : KEY_F2, value)) {
            return;
        }
        load();
        buildRows();
        mAdapter.notifyDataSetChanged();
        toast(getString(R.string.saved));
    }

    // --------------------------------------------------------------- dialogs

    private void chooseAction(final int which) {
        final String cur = (which == 1) ? mF1 : mF2;
        final String[] labels = getResources().getStringArray(R.array.action_labels);

        int checked = 0;
        for (int i = 0; i < ACTION_VALUES.length; i++) {
            String v = ACTION_VALUES[i];
            if ("@app".equals(v)) {
                if (cur.startsWith("app:")) {
                    checked = i;
                    break;
                }
            } else if ("@broadcast".equals(v)) {
                if (cur.startsWith("broadcast:")) {
                    checked = i;
                    break;
                }
            } else if ("@web".equals(v)) {
                if (cur.startsWith("web:")) {
                    checked = i;
                    break;
                }
            } else if (v.equals(cur) || ("default".equals(v) && TextUtils.isEmpty(cur))) {
                checked = i;
                break;
            }
        }

        new AlertDialog.Builder(this)
                .setTitle(which == 1 ? R.string.key_f1 : R.string.key_f2)
                .setSingleChoiceItems(labels, checked, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int index) {
                        dialog.dismiss();
                        String v = ACTION_VALUES[index];
                        if ("@app".equals(v)) {
                            showAppPicker(which);
                        } else if ("@broadcast".equals(v)) {
                            askBroadcast(which);
                        } else if ("@web".equals(v)) {
                            askUrl(which);
                        } else {
                            saveAction(which, "default".equals(v) ? "" : v);
                        }
                    }
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }

    private void showAppPicker(final int which) {
        final PackageManager pm = getPackageManager();
        Intent main = new Intent(Intent.ACTION_MAIN, null);
        main.addCategory(Intent.CATEGORY_LAUNCHER);
        List<ResolveInfo> raw = pm.queryIntentActivities(main, 0);

        final List<ResolveInfo> items = new ArrayList<ResolveInfo>();
        for (ResolveInfo ri : raw) {
            if (ri.activityInfo == null) {
                continue;
            }
            if (getPackageName().equals(ri.activityInfo.packageName)) {
                continue;
            }
            items.add(ri);
        }
        Collections.sort(items, new Comparator<ResolveInfo>() {
            @Override
            public int compare(ResolveInfo a, ResolveInfo b) {
                return String.valueOf(a.loadLabel(pm))
                        .compareToIgnoreCase(String.valueOf(b.loadLabel(pm)));
            }
        });

        if (items.isEmpty()) {
            toast(getString(R.string.no_apps));
            return;
        }

        new AlertDialog.Builder(this)
                .setTitle(R.string.pick_app)
                .setAdapter(new AppAdapter(items), new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int i) {
                        ResolveInfo ri = items.get(i);
                        ComponentName cn = new ComponentName(
                                ri.activityInfo.packageName, ri.activityInfo.name);
                        saveAction(which, "app:" + cn.flattenToShortString());
                    }
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }

    private void askBroadcast(final int which) {
        final EditText et = new EditText(this);
        et.setHint("com.example.MY_ACTION");
        FrameLayout box = new FrameLayout(this);
        box.setPadding(dp(20), dp(8), dp(20), 0);
        box.addView(et, new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));

        new AlertDialog.Builder(this)
                .setTitle(R.string.ask_broadcast)
                .setView(box)
                .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int i) {
                        String a = et.getText().toString().trim();
                        if (!a.isEmpty()) {
                            saveAction(which, "broadcast:" + a);
                        }
                    }
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }

    /** MS600 v145: 让用户填一个网址，存成 "web:<url>"，由框架用浏览器打开。 */
    private void askUrl(final int which) {
        final EditText et = new EditText(this);
        et.setHint("https://www.example.com");
        et.setSingleLine(true);
        final String cur = (which == 1) ? mF1 : mF2;
        if (cur != null && cur.startsWith("web:")) {
            et.setText(cur.substring(4));
            et.setSelection(et.getText().length());
        }
        FrameLayout box = new FrameLayout(this);
        box.setPadding(dp(20), dp(8), dp(20), 0);
        box.addView(et, new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));

        new AlertDialog.Builder(this)
                .setTitle(R.string.ask_url)
                .setView(box)
                .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int i) {
                        String u = et.getText().toString().trim();
                        if (!u.isEmpty()) {
                            saveAction(which, "web:" + u);
                        }
                    }
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }

    // ------------------------------------------------------------- adapters

    private class KeyAdapter extends BaseAdapter {
        @Override
        public int getCount() {
            return mRows.size();
        }

        @Override
        public Object getItem(int position) {
            return mRows.get(position);
        }

        @Override
        public long getItemId(int position) {
            return position;
        }

        @Override
        public int getViewTypeCount() {
            return 8;
        }

        @Override
        public int getItemViewType(int position) {
            return mRows.get(position).type;
        }

        @Override
        public boolean isEnabled(int position) {
            int t = mRows.get(position).type;
            return t == RT_SWITCH || t == RT_ACTION || t == RT_RADIO || t == RT_NAV;
        }

        @Override
        public boolean areAllItemsEnabled() {
            return false;
        }

        private TextView text(float size, int color) {
            TextView t = new TextView(MainActivity.this);
            t.setTextSize(TypedValue.COMPLEX_UNIT_SP, size);
            t.setTextColor(color);
            return t;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            Row r = mRows.get(position);
            LinearLayout row = (LinearLayout) convertView;
            if (row == null) {
                row = new LinearLayout(MainActivity.this);
                row.setOrientation(LinearLayout.VERTICAL);
                switch (r.type) {
                    case RT_NAV: {
                        // v156 主菜单的分组入口：比普通行更高更醒目，右侧一个箭头
                        row.setOrientation(LinearLayout.HORIZONTAL);
                        row.setGravity(Gravity.CENTER_VERTICAL);
                        row.setBackgroundColor(Color.WHITE);
                        row.setPadding(dp(20), dp(18), dp(20), dp(18));
                        LinearLayout col = new LinearLayout(MainActivity.this);
                        col.setOrientation(LinearLayout.VERTICAL);
                        TextView title = text(18, 0xFF212121);
                        title.setTypeface(title.getTypeface(), Typeface.BOLD);
                        col.addView(title);
                        TextView value = text(13, 0xFF757575);
                        LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(
                                ViewGroup.LayoutParams.MATCH_PARENT,
                                ViewGroup.LayoutParams.WRAP_CONTENT);
                        p.topMargin = dp(5);
                        col.addView(value, p);
                        row.addView(col, new LinearLayout.LayoutParams(
                                0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
                        TextView chev = text(22, 0xFF9E9E9E);
                        chev.setText("\u203A");
                        row.addView(chev);
                        break;
                    }
                    case RT_HEADER: {
                        // v156: 分了组之后那段长解释没意义了，只留一行引导
                        row.setBackgroundColor(0xFFF2F2F2);
                        row.setPadding(dp(20), dp(16), dp(20), dp(16));
                        TextView h1 = text(14, 0xFF757575);
                        h1.setText(R.string.header);
                        row.addView(h1);
                        break;
                    }
                    case RT_SECTION: {
                        row.setBackgroundColor(0xFFF2F2F2);
                        row.setPadding(dp(20), dp(14), dp(20), dp(6));
                        TextView t = text(13, 0xFF1A73E8);
                        t.setTypeface(t.getTypeface(), Typeface.BOLD);
                        row.addView(t);
                        break;
                    }
                    case RT_SWITCH: {
                        row.setOrientation(LinearLayout.HORIZONTAL);
                        row.setGravity(Gravity.CENTER_VERTICAL);
                        row.setBackgroundColor(Color.WHITE);
                        row.setPadding(dp(20), dp(14), dp(20), dp(14));
                        LinearLayout col = new LinearLayout(MainActivity.this);
                        col.setOrientation(LinearLayout.VERTICAL);
                        TextView title = text(17, 0xFF212121);
                        col.addView(title);
                        TextView value = text(13, 0xFF757575);
                        LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(
                                ViewGroup.LayoutParams.MATCH_PARENT,
                                ViewGroup.LayoutParams.WRAP_CONTENT);
                        p.topMargin = dp(4);
                        col.addView(value, p);
                        row.addView(col, new LinearLayout.LayoutParams(
                                0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
                        Switch sw = new Switch(MainActivity.this);
                        row.addView(sw);
                        break;
                    }
                    case RT_RADIO: {
                        row.setOrientation(LinearLayout.HORIZONTAL);
                        row.setGravity(Gravity.CENTER_VERTICAL);
                        row.setBackgroundColor(Color.WHITE);
                        row.setPadding(dp(20), dp(16), dp(20), dp(16));
                        TextView title = text(17, 0xFF212121);
                        row.addView(title, new LinearLayout.LayoutParams(
                                0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
                        TextView mark = text(18, 0xFF1A73E8);
                        row.addView(mark);
                        break;
                    }
                    case RT_NOTE: {
                        row.setBackgroundColor(Color.WHITE);
                        row.setPadding(dp(20), dp(14), dp(20), dp(18));
                        TextView title = text(15, 0xFF212121);
                        title.setTypeface(title.getTypeface(), Typeface.BOLD);
                        row.addView(title);
                        TextView body = text(13, 0xFF757575);
                        body.setLineSpacing(dp(4), 1f);
                        LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(
                                ViewGroup.LayoutParams.MATCH_PARENT,
                                ViewGroup.LayoutParams.WRAP_CONTENT);
                        p.topMargin = dp(6);
                        row.addView(body, p);
                        break;
                    }
                    default: {  // RT_ACTION / RT_INFO
                        row.setOrientation(LinearLayout.HORIZONTAL);
                        row.setGravity(Gravity.CENTER_VERTICAL);
                        row.setBackgroundColor(Color.WHITE);
                        row.setPadding(dp(20), dp(14), dp(20), dp(14));
                        LinearLayout col = new LinearLayout(MainActivity.this);
                        col.setOrientation(LinearLayout.VERTICAL);
                        TextView title = text(17, 0xFF212121);
                        col.addView(title);
                        TextView value = text(13, 0xFF757575);
                        LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(
                                ViewGroup.LayoutParams.MATCH_PARENT,
                                ViewGroup.LayoutParams.WRAP_CONTENT);
                        p.topMargin = dp(4);
                        col.addView(value, p);
                        row.addView(col, new LinearLayout.LayoutParams(
                                0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
                        TextView chev = text(18, 0xFFBDBDBD);
                        chev.setText("\u203A");
                        row.addView(chev);
                        break;
                    }
                }
            }

            switch (r.type) {
                case RT_NAV: {
                    LinearLayout col = (LinearLayout) row.getChildAt(0);
                    ((TextView) col.getChildAt(0)).setText(r.titleRes);
                    ((TextView) col.getChildAt(1)).setText(
                            r.value == null ? "" : r.value);
                    break;
                }
                case RT_HEADER:
                    break;
                case RT_SECTION:
                    ((TextView) row.getChildAt(0)).setText(r.titleRes);
                    break;
                case RT_RADIO:
                    ((TextView) row.getChildAt(0)).setText(r.title);
                    ((TextView) row.getChildAt(1)).setText(r.value);
                    break;
                case RT_NOTE: {
                    TextView t = (TextView) row.getChildAt(0);
                    if (r.titleRes != 0) {
                        t.setVisibility(View.VISIBLE);
                        t.setText(r.titleRes);
                    } else {
                        t.setVisibility(View.GONE);
                    }
                    ((TextView) row.getChildAt(1)).setText(r.value);
                    break;
                }
                case RT_SWITCH: {
                    LinearLayout col = (LinearLayout) row.getChildAt(0);
                    ((TextView) col.getChildAt(0)).setText(r.titleRes);
                    // MS600 v148: 开关行的副标题用**实时值**。
                    // r.value 是 buildRows() 时的快照，notifyDataSetChanged() 只重绘旧 Row，
                    // 点了开关文字不会变。这里按 key 现算，且不重建列表（滚动位置不会跳）。
                    if (r.key == K_GAMEPAD_GAME) {
                        ((TextView) col.getChildAt(1)).setText(describeGamepadGame());
                    } else if (r.key == K_BYPASS) {
                        ((TextView) col.getChildAt(1)).setText(describeBypass());
                    } else if (r.key == K_DT2W) {
                        ((TextView) col.getChildAt(1)).setText(describeDt2w());
                    } else if (r.key == K_BT_ENABLE) {
                        ((TextView) col.getChildAt(1)).setText(btSummary());
                    } else if (r.key == K_USB_MSC) {
                        ((TextView) col.getChildAt(1)).setText(mscSummary());
                    } else {
                        ((TextView) col.getChildAt(1)).setText(r.value);
                    }
                    Switch sw = (Switch) row.getChildAt(1);
                    final boolean checked;
                    if (r.key == K_ETH_ENABLE) {
                        checked = mEthEnabled;
                    } else if (r.key == K_DT2W) {
                        checked = mDt2w;
                    } else if (r.key == K_HDMI_MIRROR) {
                        checked = mMirrorOn;
                    } else if (r.key == K_HDMI_OUT) {
                        checked = mHdmiOut;
                    } else if (r.key == K_GAMEPAD_GAME) {
                        // MS600 v148: v147 漏了这个分支 ⇒ 开关一直显示 mBypass 的状态
                        checked = mGamepadGame;
                    } else if (r.key == K_BT_ENABLE) {
                        checked = isBtOn();
                    } else if (r.key == K_USB_MSC) {
                        checked = isMscOn();
                    } else {
                        checked = mBypass;
                    }
                    final int key = r.key;
                    sw.setOnCheckedChangeListener(null);
                    sw.setChecked(checked);
                    sw.setOnCheckedChangeListener(
                            new android.widget.CompoundButton.OnCheckedChangeListener() {
                                @Override
                                public void onCheckedChanged(android.widget.CompoundButton b,
                                                             boolean nowChecked) {
                                    if (nowChecked == checked) {
                                        return;
                                    }
                                    onRowClick(key);
                                }
                            });
                    break;
                }
                default: {
                    LinearLayout col = (LinearLayout) row.getChildAt(0);
                    // MS600 v153: 蓝牙设备行标题是运行时字符串（蓝牙名），不是资源
                    if (r.title != null && !r.title.isEmpty()) {
                        ((TextView) col.getChildAt(0)).setText(r.title);
                    } else {
                        ((TextView) col.getChildAt(0)).setText(r.titleRes);
                    }
                    // MS600 v149: 「当前设备」按实时值渲染（切 OTG / 插拔后不必重建列表）
                    if (r.type == RT_INFO && r.key == K_USB_DEV) {
                        ((TextView) col.getChildAt(1)).setText(usbDeviceText());
                    } else if (r.key == K_USB_MODE) {
                        // MS600 v151: 模式行副标题按实时值渲染
                        ((TextView) col.getChildAt(1)).setText(usbModeSummary());
                    } else {
                        ((TextView) col.getChildAt(1)).setText(r.value);
                    }
                    boolean actionable = (r.type == RT_ACTION);
                    row.getChildAt(1).setVisibility(actionable ? View.VISIBLE : View.INVISIBLE);
                    break;
                }
            }
            return row;
        }
    }

    private class AppAdapter extends BaseAdapter {
        private final List<ResolveInfo> mItems;
        private final PackageManager mPm = getPackageManager();

        AppAdapter(List<ResolveInfo> items) {
            mItems = items;
        }

        @Override
        public int getCount() {
            return mItems.size();
        }

        @Override
        public Object getItem(int position) {
            return mItems.get(position);
        }

        @Override
        public long getItemId(int position) {
            return position;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            LinearLayout row = (LinearLayout) convertView;
            if (row == null) {
                row = new LinearLayout(MainActivity.this);
                row.setOrientation(LinearLayout.HORIZONTAL);
                row.setGravity(Gravity.CENTER_VERTICAL);
                row.setPadding(dp(20), dp(12), dp(20), dp(12));

                ImageView icon = new ImageView(MainActivity.this);
                int size = dp(40);
                LinearLayout.LayoutParams ilp = new LinearLayout.LayoutParams(size, size);
                ilp.rightMargin = dp(16);
                row.addView(icon, ilp);

                TextView text = new TextView(MainActivity.this);
                text.setTextSize(TypedValue.COMPLEX_UNIT_SP, 16);
                text.setTextColor(0xFF212121);
                row.addView(text, new LinearLayout.LayoutParams(
                        0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
            }
            ResolveInfo ri = mItems.get(position);
            ((ImageView) row.getChildAt(0)).setImageDrawable(ri.loadIcon(mPm));
            ((TextView) row.getChildAt(1)).setText(ri.loadLabel(mPm));
            return row;
        }
    }

    // ---------------------------------------------------------------- utils

    private int dp(int v) {
        return Math.round(getResources().getDisplayMetrics().density * v);
    }

    private void toast(String s) {
        Toast.makeText(this, s, Toast.LENGTH_SHORT).show();
    }
}
