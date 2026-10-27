# MS600 标准符合性审查报告（为安卓 TV / 平板 App 测试做准备）

> 审查日期：2026-10-26 14:10
> 设备基线：system v156 / boot v38(Magisk) / Android 11 (SDK 30) / LineageOS 18.1
> 方法：`pm list features`、`dumpsys`、build 树源码标记（`MS600` 前缀）逐文件核对

---

## 一、结论先说

**能测，但有 4 个"硬性偏离"会直接影响测试结果，其中 3 个目前无法在运行时关掉。**

| 维度 | 评级 | 一句话 |
|---|---|---|
| 系统骨架完整性 | 🟢 好 | Settings / PackageInstaller / DocumentsUI / MediaProvider / WebView / launcher3 全在，都是 AOSP 原版 |
| 平板 App 测试 | 🟡 可用但有偏差 | 窗口恒为横屏 1920×1178（sw857dp），方向锁被禁用 |
| TV App 测试 | 🔴 缺关键声明 | `android.software.leanback` 等 6 个 TV 特性全部没声明 |
| 外设标准性 | 🟡 有劫持 | 所有手柄的摇杆/十字键被框架拦截，非游戏模式拿不到原始输入 |
| 安全/环境标识 | 🟡 非零售态 | userdebug + test-keys + ro.adb.secure=0 + 未加密 |

---

## 二、🔴 P0：会直接挡住测试的问题

> **📌 2026-10-27 状态更新（本节 2.2/2.3/2.4 的三项已可运行时切换，别照原文当"改不了"看）**
>
> v157 起实现了 A2「标准模式」，v178 补齐了 2.3 的一处漏点。开关是 **property**：
>
> ```bash
> adb shell setprop persist.sys.ms600.stock 1   # 进标准模式（AOSP 行为）
> adb shell settings put system accelerometer_rotation 0
> adb shell settings put system user_rotation 1   # 1=横屏 0=竖屏
> # 测完恢复
> adb shell setprop persist.sys.ms600.stock 0
> ```
>
> 实测（v177/v178 镜像）：`stock=1` + `user_rotation=0` ⇒ `mCurrentOrientation=0`、`wm size` 1200×1920；
> `stock=0` ⇒ 回到 `mCurrentOrientation=1`（横屏 1920×1200）。
> **只有 3.2（LogicalDisplay 拉伸）仍是硬编码、无开关。**

### 2.1 TV 特性声明全部缺失（最重要）

`pm list features` 68 项，**一个 TV 特性都没有**：

| 特性 | 状态 | 后果 |
|---|---|---|
| `android.software.leanback` | ❌ | **TV App 的命门**。`required="true"` 的 TV 应用在 Play 里不可见；运行时会走手机/平板布局；Leanback 库的部分组件会 assert |
| `android.software.leanback_only` | ❌ | 同上 |
| `android.software.live_tv` | ❌ | 直播电视类应用不可用 |
| `android.hardware.type.television` | ❌ | `UiModeManager` 判定为 TELEVISION 的必要条件 |
| `android.hardware.hdmi.cec` | ❌ | HDMI-CEC 相关应用拿不到 `HdmiControlManager` |
| `android.hardware.ethernet` | ❌ | 虽然 W5500 网口在（插网线时 `eth0` 出现），但应用检测不到以太网 |

`ro.build.characteristics = default`（既不是 `tablet` 也不是 `tv`），部分老应用会据此选布局。

### 2.2 方向锁被彻底禁用（硬编码，无法运行时关闭）

源码：`ActivityRecord.java:1534` 与 `:6301`

```java
// 构造时
setOrientation(ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED);
// 运行时
void setRequestedOrientation(int requestedOrientation) {
    requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED;  // 直接覆盖
    ...
}
```

**实测验证**（启动竖屏 App `com.liuzh.deviceinfo`）：

```
init=1200x1920 224dpi   cur=1920x1200   app=1920x1178
CurrentConfiguration = sw857dp w1371dp h817dp 224dpi xlrg land ... mRotation=ROTATION_90
```

竖屏 App 被强制拉成横屏满屏。**任何依赖 `setRequestedOrientation` 的应用（视频播放器、游戏、阅读器、扫码页）行为都会和真机不一致。**

> ✅ **已有开关**：`persist.sys.ms600.stock=1` 时放行 App 自己声明的方向（`ActivityRecord.java:1541` 与 `:6317` 两处都带判断）。

### 2.3 屏幕恒为横屏 ROTATION_90

源码：`DisplayRotation.java:1080` —— `sys.boot_completed=1` 后无条件返回 `ROTATION_90`，只针对 display 0（外接屏不受影响，v113 已修）。

无重力感应（设备本来就没有 g-sensor），所以横屏固定本身是合理设计，但**它 + 2.2 叠加 = 竖屏应用无法正常显示**。

> ✅ **v178 已补漏**：`rotationForOrientationLw()` 的 `default` 分支原来无条件走 `ms600TargetOrientation()`，
> 导致即使 `stock=1`、只要 `preferredRotation<0` 仍被钉在 ROTATION_90。现补上 stock 判断，标准模式回 `ROTATION_0`。

### 2.4 所有 Activity 被强制 resizable

源码：`ActivityTaskManagerService.java:791` `final boolean forceResizable = true;` + `WindowManagerService.java:922` 同样固定 true。

后果：`ActivityInfo.resizeMode` 的实际语义被改写，`shouldUseSizeCompatMode()` 恒为 false。测多窗口 / 分屏 / 画中画时会与真机不一致（`cmd activity supports-multiwindow` 返回 true，但分屏表现不可信）。

> ✅ **已有开关**：`persist.sys.ms600.stock=1` 时读 `Settings.Global force_resizable_activities`（默认 false），不再恒 true。

---

## 三、🟡 P1：影响部分功能

### 3.1 手柄输入被框架全局劫持（可运行时关闭 ✅）

源码：`KeyboardInputMapper.cpp` / `JoystickInputMapper.cpp`

| 行为 | 系统模式（默认） | 游戏模式 |
|---|---|---|
| 左摇杆 ABS_X/Y | → 鼠标光标 | 原样给应用 |
| 右摇杆 ABS_Z/RZ | → 界面滚动 | 原样给应用 |
| 十字键 ABS_HAT0X/Y | → DPAD 方向键 | 原样给应用 |
| L3（BTN_THUMBL） | → 鼠标左键 | 原样 |
| A/B/START/SELECT | 由 `.kl` 改成 DPAD_CENTER/BACK/HOME | 原样 |

⚠️ **关键点：轴劫持没有按 VID/PID 过滤**，是全局的 —— 插任何第三方手柄（Xbox/PS/北通）摇杆都会被抢走。只有 `.kl` 那 4 个按键映射限定了 `Vendor_3537_Product_1041`。

✅ **好消息**：开关**即时生效、无需重启**（实测）：

```bash
adb shell settings put global ms600_gamepad_game_mode 1   # 开：手柄原样交给应用
adb shell settings put global ms600_gamepad_game_mode 0   # 关：恢复鼠标/滚动
# 或：设备设置 → 按键 → 游戏手柄模式
```

### 3.2 显示矩形强制"拉伸铺满"，不做 letterbox

源码：`LogicalDisplay.java:437` —— `displayRect = 物理尺寸`。

后果：16:9 内容在 16:10 面板上会被**垂直拉伸**（而不是上下留黑边）。测视频类 App 的等比缩放会失真。

### 3.3 相机只有 LEGACY HAL

```
Camera HAL device device@1.0/legacy/0 (v1.0)  →  API2 not directly supported
Camera HAL device device@3.3/legacy/0 (v3.3)
```

Camera2 走 LEGACY 兼容层，只有基础能力。扫码/拍照类 App 能跑，但高级特性（RAW、手动、多摄）全部不可用。

### 3.4 声明了 telephony 但没有基带

`pm list features` 里有 `android.hardware.telephony`、`.gsm`、`.cdma`，设备实际无 SIM、无 modem，且 **没有设 `ro.radio.noril`**。

后果：应用 `hasSystemFeature(FEATURE_TELEPHONY)` 返回 true 后会去用 TelephonyManager / SMS API，得到"无服务"或异常路径。建议补 `ro.radio.noril=1`。

### 3.5 完全没有传感器

```
dumpsys sensorservice → No Sensors on the device
```

`android.hardware.sensor.accelerometer` 未声明（这点是**对的**，不撒谎）。但大量应用（尤其游戏、相机、地图）`required="true"` 依赖加速度计 ⇒ **装不上 / 一开就崩**。

### 3.6 环境标识不是零售态

| 属性 | 值 | 影响 |
|---|---|---|
| `ro.build.type` | `userdebug` | 部分金融/DRM/银行/流媒体 App 直接拒跑 |
| `ro.build.tags` | `test-keys` | 同上；Play Integrity 必然 fail |
| `ro.adb.secure` | **`0`** | adb 无授权提示（便利但不符合标准） |
| `ro.crypto.state` | `unsupported` | 未加密；企业/工作资料类应用会拒绝 |
| `ro.debuggable` | `1` | — |
| `persist.sys.strictmode.disable` | `true` | StrictMode 违规不再上报（测性能时看不到警告） |

### 3.7 其它小偏离

- `debug.hwui.use_buffer_age=0`：每帧全量重绘（为修 B 站花屏），**影响帧率/功耗测量基线**
- `VibratorService` 被改成"报告无振动器"（设备确实没马达，属于诚实）
- `ACodec.cpp`：解码器不支持低延迟时不再让整个 configure 失败（**良性放宽**）
- `DisplayContent.java`：外接输入设备不触发 Configuration 变化（**良性**，修插拔闪屏）
- `ViewGroup` / `ViewRootImpl`：DPAD 焦点兜底（**只影响遥控器/手柄导航**，对触摸应用无影响）

---

## 四、🟢 完全标准的部分（可以放心测）

| 项目 | 证据 |
|---|---|
| **标准 Settings** | `android.settings.SETTINGS` → `com.android.settings/.homepage.SettingsHomepageActivity`（AOSP 原版在，能拉起） |
| **桌面** | `com.android.launcher3/.uioverrides.QuickstepLauncher`（AOSP 原版） |
| **安装器 / 权限** | `com.android.packageinstaller`、`com.android.permissioncontroller` 在，`pm install` 实测可用（装过 Magisk） |
| **文件选择器** | `com.android.documentsui` 在 |
| **媒体存储** | `com.android.providers.media(.module)`、`com.android.externalstorage` 在 |
| **WebView** | `com.android.webview 154.0.8037.57`，多进程开启 |
| **触摸** | `fts_ts` 标准多点（10 点，`Slot max=9`），`GestureMode: multi-touch` |
| **显示密度** | 224 dpi / 1200×1920 物理，无自定义密度 hack |
| **多窗口** | `supports-multiwindow = true` |
| **OpenGL/Vulkan** | GLES 3.2 (`0x30002`)、Vulkan 1.1 (`4194307`) 均声明 |
| **媒体框架** | 33 个 extractor，OMX/CCodec 正常（投屏、B 站硬解已验证） |
| **framework 资源 overlay** | 只覆盖 3 项（voice_capable / audiojack devinput / 网络定位包名），非常克制 |
| **网络** | `wlan0` 正常；`eth0`（W5500）链路相关，插网线即出现 |

---

## 五、我们到底打过多少补丁（完整清单）

`frameworks/` + `packages/apps/Settings` 里带 `MS600` 标记的文件共 **20 个**：

| 层 | 文件 | 改了什么 | 运行时可否关闭 |
|---|---|---|---|
| Java FW | `ActivityRecord.java` | 忽略方向请求（2 处） | ❌ 硬编码 |
| Java FW | `ActivityTaskManagerService.java` | 强制 resizable | ❌ 硬编码 |
| Java FW | `WindowManagerService.java` | 固定 resizable | ❌ 硬编码 |
| Java FW | `DisplayRotation.java` | 强制 ROTATION_90 + 开机前竖屏 | ❌ 硬编码 |
| Java FW | `LogicalDisplay.java` | displayRect = 物理（拉伸） | ❌ 硬编码 |
| Java FW | `DisplayManagerService.java` | HDMI 输出开关（Settings.Global） | ✅ 有开关 |
| Java FW | `LocalDisplayAdapter.java` | HDMI display 电源开关 | ✅ 同上 |
| Java FW | `DisplayContent.java` | 外接输入不触发配置变化 | ❌ 但良性 |
| Java FW | `ViewGroup.java` | DPAD 焦点兜底（2 处） | ❌ 但只影响方向键 |
| Java FW | `ViewRootImpl.java` | DPAD 死路兜底 | ❌ 但只影响方向键 |
| Java FW | `PhoneWindowManager.java` | F1/F2 自定义键 + 游戏模式 property 同步 | ✅ 有开关 |
| Java FW | `PowerManagerService.java` | 双击唤醒（直接读 `/dev/input/event1`） | ✅ 有开关 |
| Java FW | `BatteryService.java` | 80% 旁路充电 | ✅ 有开关 |
| Java FW | `VibratorService.java` | 报告无振动器 | ❌ 但符合事实 |
| Native | `KeyboardInputMapper.cpp` | 摇杆→鼠标/滚动、十字键→DPAD | ✅ 游戏模式 |
| Native | `JoystickInputMapper.cpp` | 屏蔽 ABS_X/Y/HAT（非游戏模式） | ✅ 游戏模式 |
| Native | `ACodec.cpp` | 低延迟失败不致命 | ❌ 良性放宽 |
| Native | `surfaceflinger.rc` | 恢复 SF 崩溃自动重启 | — |
| App | `Settings/.../PreventRingingGesture…` | 去掉无用项 | — |
| App | `Settings/res/xml/top_level_settings.xml` | 首页结构调整 | — |

另加：`.kl` 键位文件（限 `Vendor_3537_Product_1041`）、`privapp-permissions-ms600.xml`、3 项 framework 资源 overlay。

**评价：补丁数量不小，但"越界"集中在 5 个显示/窗口相关的硬编码上（方向、resizable、显示矩形）。其它都是带开关或良性的。**

---

## 六、要给测试用，建议做两件事（都需要刷一次 system）

### 6.1 加"特性声明"XML（成本极低，收益最大）

特性只靠 `/system/etc/permissions/*.xml` 里的 `<feature name="..."/>` 声明，**不用改框架**。

建议新文件 `ms600-features.xml`：

```xml
<permissions>
    <!-- TV 测试 -->
    <feature name="android.software.leanback" />
    <feature name="android.software.live_tv" />
    <feature name="android.hardware.type.television" />
    <!-- 外设 -->
    <feature name="android.hardware.gamepad" />
    <feature name="android.hardware.input.controller_profile" />
    <feature name="android.hardware.ethernet" />
</permissions>
```

⚠️ 注意两点：
- 声明 `leanback` 后 `UiModeManager` 可能切到 TV 模式（影响 `values-television` 资源选择），**要和 6.2 的标准模式一起用**
- `android.hardware.hdmi.cec` **不要乱加** —— 没有 CEC 服务时会抛异常

### 6.2 加一个"标准模式"总开关（需要小改框架）

目标：一条 `setprop persist.sys.ms600.stock 1`，让设备回到 AOSP 行为，用于 App 测试；关掉就恢复"平板化"。
**（本节最初写作 `settings put global ms600_stock_mode`，实际实现用的是 property `persist.sys.ms600.stock`，已按实现更正。）**

需要加判断的 3 处（都是读 property，开销可忽略）：

| 位置 | 标准模式下改为 |
|---|---|
| `ActivityRecord.setRequestedOrientation` | 不再覆盖，用应用传进来的值 |
| `DisplayRotation.computeTransformRotation` | 走原生 `sensorRotation` 逻辑（无 g-sensor ⇒ 跟 `user_rotation`） |
| `ActivityTaskManagerService` / `WMS` | `forceResizable` 跟随 `Settings.Global`，不再恒 true |

改完测试流程就变成：

```bash
# 进入"真机行为"
adb shell setprop persist.sys.ms600.stock 1
adb shell settings put system accelerometer_rotation 0
adb shell settings put system user_rotation 1     # 1=横屏, 0=竖屏
# 测完恢复
adb shell setprop persist.sys.ms600.stock 0
```

---

## 七、现在立刻就能做的（不用刷机）

| 目的 | 命令 |
|---|---|
| 测游戏/手柄类应用 | `adb shell settings put global ms600_gamepad_game_mode 1` |
| 让竖屏应用别被拉伸 | `setprop persist.sys.ms600.stock 1`（v157 起已支持） |
| 隐藏 debuggable 标志 | Magisk 的 `resetprop`（需装 Magisk 模块），可临时改 `ro.debuggable`/`ro.build.tags` |
| 打开 StrictMode 检查 | `adb shell setprop persist.sys.strictmode.disable false` + 重启 |
| 看应用实际拿到的配置 | `adb shell dumpsys activity activities \| grep CurrentConfiguration` |

---

## 八、给测试的一句话建议

- **平板 App**：现在就能测，但**所有结论都要考虑"恒横屏 + 方向锁失效"**这两个偏差；涉及方向、分屏、等比的用例不可信。
- **TV App**：**先加 `leanback` 特性声明**，否则多数 TV 应用会走手机布局，测了也不算数。
- **游戏/串流**：**务必先开 `ms600_gamepad_game_mode=1`**，否则手柄摇杆被抢成鼠标。
- **相机/传感器类**：**基本测不了**（LEGACY HAL + 零传感器）。
