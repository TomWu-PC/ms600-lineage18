# 讯飞 MS600 平板 · Android 11 定制 ROM 开发全过程总结

> 写给下一次同类开发（把一台跑厂商固件的安卓设备，从零做出可日常使用的 AOSP 系定制 ROM）
>
> 整理日期：2026-10-28 ｜ 项目周期：2026-09-30 ~ 2026-10-28（29 天，约 190 个固件版本）
> 最终产物：`18.1_v190_release_system.img`（md5 `a6f2f9beeb173466e4a608f00254cb0e`）

---

## 一、项目概览

| 项 | 内容 |
|---|---|
| 设备 | 讯飞听见 L1（MS600），高通 SDM450，2GB/16GB |
| 屏幕 | **物理竖屏 1920×1200**（density 224），系统被强制按横屏使用（ROTATION_90） |
| 传感器 | **零传感器**（无 g-sensor / 无光感 / 无距离），无 GNSS、无 SIM 卡槽 |
| 原系统 | Android 8.1（讯飞定制），带 Magisk root |
| 目标系统 | **LineageOS 18.1 / Android 11**，userdebug，root 可用 |
| 摄像头 | 唯一 sensor OV13855（13MP），HAL 输出 NV12 |
| 外设 | HDMI（LT8912 固定 1080p60）、RJ45 网口（W5500，SPI，≈2.3Mbps）、USB-A OTG、3.5mm 耳机 |
| 交付形态 | 只刷 `system.img`（+ `boot.img` 带 Magisk），vendor/oem 保持原厂 |

### 最终成果清单

- 完整可启动的 LineageOS 18.1，日常可用（蓝牙、WiFi、相机、投屏、网口、HDMI、exFAT U 盘）
- 自研「MS600 设备设置」App（内含 20+ 项定制开关）
- 自研投屏接收 App（Miracast / DLNA / AirPlay，内置 system/priv-app）
- SystemUI 定制：电量百分比、音量面板音频输出选择器
- 相机彻底修复：13MP 正常画质 + 照片/录像方向正立
- exFAT U 盘支持（内核没编 exFAT，用 userspace FUSE 顶上）

---

## 二、环境与工具链

### 2.1 编译机

```
Linux（Ubuntu）服务器：<build-host>
源码目录：~/lineage  （repo sync 的 LineageOS 18.1）
SSH 密钥：本地 ~/.ssh/ms600_ed25519
```

**编译命令**（每次都要重新 source，不能复用 shell 状态）：

```bash
cd ~/lineage
source build/envsetup.sh
lunch lineage_MS600-userdebug
mka systemimage -j8          # 增量编译，改一两处约 1 分钟
m MS600Settings              # 单模块验证，约 10 秒
```

### 2.2 本地 Windows 端

| 工具 | 路径 / 说明 |
|---|---|
| adb / fastboot | `C:\Users\user\AppData\Local\Android\Sdk\platform-tools\` |
| Python | `C:\Users\user\.workbuddy\binaries\python\versions\3.13.12\python.exe`（不在 PATH） |
| 刷机脚本 | `_工具/_flash_min.py <img 绝对路径> <期望 md5>` |
| Git Bash 注意 | adb 路径参数必须加 `MSYS_NO_PATHCONV=1`，否则 `/sdcard/x.png` 被转成 Windows 路径 |

### 2.3 设备坐标

```
adb 序列号：<serial>   （fastboot 侧显示 MS600_M）
WiFi adb：<device-ip>:5555
分区布局：p24=system  p21=boot  p25=vendor  p54=userdata
```

---

## 三、从零到能启动：四个阶段（最关键的骨架）

> 这一段是**整个项目的立身之本**。跳过任何一步都会得到「刷完黑屏/无限重启」。

### 阶段 0：原厂全分区备份（必做，不可跳）

```bash
adb root && adb shell dd if=/dev/block/by-name/system of=/sdcard/orig_system.img
# 或 fastboot 下：fastboot getvar all / dd 逐分区导出
```

**本项目备份在** `_备份/0930_初始状态/分区镜像/`：aboot / boot / recovery / system(3.2G) /
vendor(1G) / oem / modem / modemst1/2 / persist / splash / devinfo / fsg / misc + `MD5校验.txt`。

> ⚠️ 没有这份备份，后面任何一次「刷错 vendor」都只能返厂。**这一步花 30 分钟，能救命。**

### 阶段 1：让 recovery 亮起来

AOSP recovery 第一行是 `import /init.recovery.${ro.hardware}.rc`。本机 `ro.hardware=qcom`，
所以必须有 `init.recovery.qcom.rc`，**而且它要真的进 ramdisk**。

三个连锁依赖，缺一个就黑屏 + USB 不枚举 + watchdog 重启：

1. 背光：写 `panel0-backlight/brightness`
2. USB：建 `/config/usb_gadget/g1`（configfs）
3. UDC 绑定

**坑**：把文件放进设备树目录 ≠ 进 ramdisk。必须写成：

```makefile
PRODUCT_COPY_FILES += $(LOCAL_PATH)/init.recovery.qcom.rc:$(TARGET_COPY_OUT_ROOT)/init.recovery.qcom.rc
```

build 只从 **`$(TARGET_ROOT_OUT)`** 捞 `init.recovery.*.rc` 进 recovery ramdisk
（`build/make/core/Makefile:2234`）。第一次不知道这点，改了 6 版都是黑屏。

### 阶段 2：first-stage fstab（否则卡开机）

AOSP 11 的 first-stage init 靠 ramdisk 根的 `/fstab.${ro.hardware}` 挂载分区
（`system/core/init/first_stage_mount.cpp:159`）。本机 bootloader 不传 DT，只能走文件。

```makefile
PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstab.qcom:$(TARGET_COPY_OUT_RAMDISK)/fstab.qcom
```

> 判断文件有没有真进 ramdisk：编译后看 `out/target/product/MS600/installed-files-ramdisk.txt`。
> 本项目第一次只看到 `1840016 /ramdisk/init` 一行，说明整个 ramdisk 只有一个 init。

### 阶段 3：system.img 能挂上、能起来

LineageOS 18.1 的 system 是 **ext4**（不是 A/B、不是动态分区）。原厂 vendor 是 8.1 的，
和 11 的 system 混用要靠 **VNDK / ld.config 兼容层**，本项目走「方案 C」：
system 全新编译，vendor/oem 保持原厂，靠 `ld.config.txt` + 补齐 shim 库解决符号缺失。

### 阶段 4：把 debug 打开，能连上 adb

`ro.adb.secure=0`、`ro.secure=0`、`service.adb.root=1`、`ro.debuggable=1`。

> ⚠️ **`persist.sys.usb.config` 必须写在 `PRODUCT_DEFAULT_PROPERTY_OVERRIDES`**，
> 不能写进 `PRODUCT_PROPERTY_OVERRIDES`。因为 Android 11 的 ramdisk `/default.prop`
> 是指向 `/system/etc/prop.default` 的软链，只有前者会写进去；后者只写 `/system/build.prop`，
> 而 build.prop 要等 /system 挂载后才读 —— **太晚，USB 永远不会切到 adb**。
> 本项目为此卡了整整一天（实测 110 秒后回退，adb 从未 up）。

---

## 四、设备树结构（`device/iflytek/MS600/`）

```
Android.mk / AndroidProducts.mk / BoardConfig.mk / device.mk
lineage_MS600.mk              # 产品定义入口
fstab.qcom                    # ★ 进 ramdisk，first-stage 挂载
init.recovery.qcom.rc         # ★ 进 root，recovery 初始化
init.ms600.*.rc               # 各子系统 init（adb / bt / exfat / gfx / power / usb / wifi）
ueventd.qcom.rc / ueventd.vendor.rc
ld.config.txt                 # ★ VNDK 兼容核心
ms600-features.xml            # PackageManager feature 声明
ms600-camera-features.xml     # ★ camera.back feature
default-permissions-ms600.xml # 默认授权（定位等）
privapp-permissions-ms600.xml # ★ 特权 App 白名单（漏了会 bootloop）
vendor-blobs/                 # 原厂 blob（含 camera_config.xml）
overlay/                      # RRO 资源覆盖
exfat/                        # mount.exfat 源码与构建
MS600Cast/MS600Cast.apk       # ★ 预置投屏 App
```

### 4.1 分区/属性归属速记

| 想改什么 | 改哪里 | 刷什么 |
|---|---|---|
| SystemUI / 框架 / 预置 App / system_ext 里的 App | 直接改源码 | `mka systemimage` → 刷 system |
| HAL 配置（如 camera_config.xml） | `vendor-blobs/etc/...` | `mka systemimage` → 刷 system |
| 内核 | ❌ 不能改（见 §6.1） | — |
| 开机动画/字体等 | overlay 或 system 源码 | 刷 system |

> 🚨 **`/system/system_ext` 不是独立分区**，就在 system.img 里。所以改 Camera2、SystemUI
> 只需要刷 system.img，不用碰 system_ext。

---

## 五、编译与刷机流程

### 5.1 标准循环

```
改源码 → mka systemimage -j8（1~2 分钟）
      → md5sum out/.../system.img
      → scp 到本地 _产物/（2.1GB，局域网约 20 秒）
      → python _工具/_flash_min.py <img> <md5>（自动进 bootloader，约 72 秒）
      → 自动重启，等 sys.boot_completed=1（约 40 秒）
```

### 5.2 刷机脚本做的事（`_flash_min.py`）

1. 本地 md5 校验（**必做**，防止传坏）
2. `adb shell setprop sys.powerctl reboot,bootloader`（**不能用 `adb reboot bootloader`，会挂起**）
3. `fastboot flash system`（sparse 分 4 片，每片发完必须 OKAY）
4. 断言 `OKAY=8`（4 片 × send+write）
5. `fastboot reboot`

### 5.3 判断「刷进去的到底是哪一版」

🚨 **不能信 `ro.build.version.incremental`** —— 增量编译时它经常不刷新（缓存在 out/ 里）。
正确做法：

- 双向 md5 比对（本地文件 ↔ 编译机 out）
- v190 起加了 `ro.ms600.rom.version=1.0.0-release.20261028`，
  `getprop ro.ms600.rom.version` 一眼确认

---

## 六、踩坑大全（按类别，附根因）

> 这一节是本文档最有价值的部分。每条都是**实测踩过**的，不是理论。

### 6.1 内核：根本不能动

`wlan.ko` 有 278 个符号依赖，其中 **115 个 CRC 不匹配**；源码树里又没有 qcacld 驱动源码。
⇒ 换任何内核 = WiFi 直接报废。**所有内核级需求只能走 userspace 绕。**

### 6.2 USB 子系统（最危险，能把自己锁死）

| 现象 | 根因 / 解法 |
|---|---|
| `echo 0 > enable` 做 USB 重枚举 → **永久失联** | 必须让**设备端**用 `setsid` 起后台脚本执行，写成一条 adb 命令会随着 adbd 一起死 |
| `host → peripheral` 切不过去 | `/sys/.../7000000.ssusb/mode` 只认 host/peripheral，**必须经 `none` 中转** |
| host 模式下把线插电脑 | 双 VBUS，可能烧口 |
| `pkill -f 'xxx'` 把 adb 弄断 | 匹配串把 `adb` 自己算进去了 ⇒ **先取 PID 再 kill** |
| `setprop sys.usb.config none` | 直接失联，无恢复路径 |

### 6.3 编译系统

| 现象 | 根因 |
|---|---|
| `rm system.img` 后 `mka` 不重建 | 删 `out/target/product/MS600/obj/PACKAGING/systemimage_intermediates/` |
| 改了 system 里预置的 App，行为没变 | 见 §6.4（`/data/app` 覆盖版压过 system） |
| AAPT 报 `tile_cast_label` 找不到 | 本地源码树缺 `CastTileService.java`，覆盖 res/ 时把磁贴资源弄丢了 |
| 增量编译的 version.incremental 不更新 | 见 §5.3 |

### 6.4 预置 App 的坑（本项目最隐蔽的坑之一）

🚨 **`/data/app` 里的覆盖版本会压过 `system/priv-app` 的预置版本。**

现象：明明改了 system 里的 APK，重启后行为、图标、标签全是旧的。

解法：
```bash
adb shell pm path com.iflytek.ms600.cast   # 看 codePath 是不是 /data/app
adb uninstall com.iflytek.ms600.cast       # 卸掉更新，system 那份留着
# 想保留数据：pm uninstall -k
```

### 6.5 SystemUI

| 现象 | 根因 |
|---|---|
| 改了音量面板布局「没反应」 | **本机横屏走 `res/layout-land/`**，只改 `res/layout/` 无效 ⇒ **两份都要改** |
| `kill com.android.systemui` 后音量面板失效 | 音量能调但面板不弹，**必须重启设备**才恢复。改 SystemUI 一律用重启验证 |
| MediaOutputDialog 认不到 HDMI / 3.5mm / USB | AOSP 走 MediaOutputSlice，只认蓝牙。必须自己写 Dialog + `setPreferredDeviceForStrategy` |
| SystemUI context 弹窗崩溃 | 没有 Activity token ⇒ 窗口必须 `setType(TYPE_KEYGUARD_DIALOG)` |
| 电量百分比设置项找不到 | provider 是 **`lineagesettings`**（不是 `lineagesystem`），且 `settings` CLI 不认该命名空间，要用 `content query` |

### 6.6 相机（本项目耗时最长，结论最硬）

| 现象 | 根因 |
|---|---|
| 13MP 照片只有 209KB、满脸色块 | HAL 把唯一摄像头声明成 `<Position>FRONT</Position>`；`CameraProfile.getJpegEncodingQualityParameter()` 是「遍历相机找 CAMERA_FACING_BACK，找不到 `return 0`」⇒ **JPEG quality = 0** ⇒ 量化表全 255 |
| 照片逆时针躺倒 90° | 无 g-sensor ⇒ `OrientationManager` 恒报 0°；`getImageRotation = (sensorOrientation + deviceOrientation) % 360` **是加法**，MountAngle=270 时得 270 |
| 改成 MountAngle=90 后照片上下颠倒 180° | 预览正立了，但 App 层把 `deviceOrientation` 也当成屏幕角度 90 ⇒ (90+90)=180 |
| **最终解法** | MountAngle=**90**（预览正立）+ `deviceOrientation = (360 − 屏幕角度) = 270` ⇒ (90+270)%360 = **0** |
| 第三方相机（CameraX 系）打不开 | 缺 `android.hardware.camera.back` feature ⇒ 补 `ms600-camera-features.xml`；但 CameraX 1.0 仍有 `lensFacingInteger: null` 误判（Camera2 API 实测正常），属老版本 App 问题 |

**通用方法论（下次直接套用）**：
- 判 JPEG 质量：读 **DQT 量化表**。正常 q≈95 时均值 5~8；全 255 就是 quality=0
- 判方向：看 logcat `CAM_JpegUtilNative: ... rotation = N * 90`
- 判录像方向：解析 MP4 `tkhd` 矩阵（`_工具/mp4_rot.py`）
- 判 HAL 实际能力：`dumpsys media.camera`（看 static metadata）
- 判 App 侧看到的：写 `app_process` 探针直接调 Camera2 API（见 §8）

🚨 **绝对不要用 `adb remount` 改 /vendor**：A11 用 overlayfs，实测 `cp` 被中断后
`/vendor/etc/camera/camera_config.xml` **直接消失**，相机全废。正确做法是改源码
`vendor-blobs/` + `mka systemimage`。

### 6.7 显示与窗口

- 本机是**物理竖屏但强制横屏使用**：`DisplayRotation` 被改成恒 `ROTATION_90`。
  所有和「屏幕方向」相关的计算都要考虑这一层。（`resources.displayMetrics` 只有 1920×1178，
  要拿真实尺寸必须用 `Display.getRealSize()`）
- 拉伸不 letterbox（`LogicalDisplay:444`）是**真硬编码**，没开关。改了会让投屏时上下黑边
  吃掉状态栏手势区，所以保留。

### 6.8 投屏（WFD / Miracast）

| 坑 | 结论 |
|---|---|
| 广播分辨率写错位表 | WFD Table 35：`bit24/25 = 1680×1024`、**`bit28/29 = 1920×1200`** ⇒ 十六进制 **`30000000`**（不是 `03000000`） |
| Windows 只显示 1600×1024 | 就是上面写错成 1680 系，Windows 老老实实按 1680 落地 |
| 设备常驻 GO，Windows 扫不到 | P2P 持久化组残留 ⇒ 先 `P2P_GROUP_REMOVE` + `P2P_LISTEN` |
| system 应用里 so 加载失败 | APK 内 `lib/` 的 so 在 system 分区**不会解压**，`nativeLibraryDir` 不存在 ⇒ 自己从 APK 解到 filesDir 再 chmod |
| 持续测黑边导致投屏卡顿 | `PixelCopy` 是 GPU 回读，**只能在切换档位时单次测**，不能每帧/每秒测 |

### 6.9 其他

- **exFAT**：内核没编 `CONFIG_EXFAT_FS` ⇒ 用户态 `mount.exfat`（NDK 交叉编译 libfuse + exfat-fuse）顶上，
  `sys.boot_completed=1` 时由 init 拉起 daemon，插盘自动挂 `/mnt/exfat/<卷标>`。
  ⚠️ 普通 App 看不见（A11 FUSE 隔离），需要 root 文件管理器。
- **UAC2 声卡**：不可行。17 次刷机实证，5 个真实内核缺陷全修、与主线 `f_uac2` 逐字段一致，
  Windows 仍报 `descriptor not compliant`。替代方案：DLNA「播放到」/ AirPlay / 3.5mm。
- **TCP 统计**：内核 3.18 的 `struct tcp_info` 只有 120 字节，AOSP 11 的 `TcpInfo` 要求更大结构
  ⇒ 必然抛 `Length 120 is less than required`，而且原代码用 `Log.wtf` 把 4KB buffer Base64 打出来，
  **53 秒填满 256KB logcat**。解法：`isTcpInfoParsingSupported()` 直接返回 false。

---

## 七、验证方法论（下次照做）

### 7.1 改完必刷机实测

**镜像回滚 ≠ 源码回滚**。每次刷之前记一份 `SystemUI.apk` 的 md5
（本项目 v158+ 恒为 `74c1b8435bfef57d92e85a6c9e219a8c`），刷完比对，确认新镜像真的生效。

### 7.2 分层定位

```
现象
 ├─ HAL/驱动层？ → dumpsys（media.camera / display / wifi）、logcat 里 QCamera/mm-camera
 ├─ 框架层？     → 加日志重编，或 dumpsys 看服务内部状态
 ├─ App 层？     → logcat 按 pid 过滤，看它自己打的 tag
 └─ 我的 App？   → 单独起进程测
```

### 7.3 「App 说没有」≠「系统没有」（本项目最重要的一条经验）

第三方相机报 `lensFacingInteger: null`，看着像系统缺 LENS_FACING。
**用 `app_process` 写探针直接调 Camera2 API，结果是 `LENS_FACING = 1 (BACK)` 完全正常。**

探针做法（不需要装 App，不需要 Gradle，2 分钟出结果）：

```bash
# 1. 写一个 main() 的 Java 类（要 Looper.prepare()）
# 2. javac -source 8 -target 8 -bootclasspath android.jar -d out CamTest.java
# 3. d8 --lib android.jar --output . out/CamTest.class   → classes.dex
# 4. adb push classes.dex /data/local/tmp/
# 5. adb shell "CLASSPATH=/data/local/tmp/camtest.dex app_process /system/bin CamTest"
```

这一步把「系统问题」和「App 问题」彻底分开，避免在错误的方向上浪费大量刷机时间。

### 7.4 图片/视频怎么验

| 验什么 | 怎么验 |
|---|---|
| JPEG 质量 | `PIL.Image.open(f).quantization`，看 DQT 均值 |
| 拍照方向 | logcat `CAM_JpegUtilNative ... rotation = N * 90` + 人眼看缩略图 |
| 录像方向 | 解析 MP4 `tkhd` 矩阵（v0 偏移 +40，v1 偏移 +52） |
| 投屏画面模式 | 截图 + 人眼比对是否变形/裁切 |

---

## 八、可复用资产清单

### 8.1 脚本（`_工具/`）

| 脚本 | 用途 |
|---|---|
| `_flash_min.py <img> <md5>` | 一键刷 system（校验 → bootloader → 刷 → 重启，断言 8/8 OKAY） |
| `mp4_rot.py <file.mp4>` | 读 MP4 的 tkhd 矩阵算旋转角 |
| `patch_v184_cam.py` | 相机方向 + camera.back feature 的幂等补丁（含原理注释） |
| `patch_v190_release.py` | 加 ROM 版本标识属性 |
| `_adbn.py` 等 adb 辅助 | 批量 shell / 取属性 |

### 8.2 配置模板（`_报告/开发过程总结_20261028.md` 同目录）

- `fstab.qcom`（first-stage 挂载，进 ramdisk）
- `init.recovery.qcom.rc`（背光 + configfs + UDC）
- `ld.config.txt`（VNDK 兼容）
- `ms600-camera-features.xml`（feature 补齐范例）
- `privapp-permissions-ms600.xml`（特权白名单范例）

### 8.3 源码快照

- `_设置/MS600Settings_源码_20261028/`（自研设置 App 完整源码）
- `_投屏/work/MiracastReceiver/`（投屏 App 完整源码，Kotlin）
- `_产物/_devtree_181.tar.gz`、`devtree_pull.tgz`（设备树快照）
- 编译机 `~/lineage`（完整可编译源码树）

---

## 九、下次同类开发的检查清单

### 启动前（第 0 天）

- [ ] **原厂全分区 dd 备份 + md5 清单**，存两处
- [ ] 确认 `ro.hardware`（决定 init.rc 名字）
- [ ] 确认分区布局（`/proc/partitions` + `by-name/` 软链）
- [ ] 确认有没有传感器 / g-sensor（**没有的话，所有方向相关的逻辑都要重算**）
- [ ] 确认屏幕是物理竖屏还是横屏 + 系统强制了什么方向
- [ ] 收集原厂 `getprop` 全量、`dumpsys` 关键项、packages 清单

### 编译前

- [ ] `fstab.${ro.hardware}` 目标是 `$(TARGET_COPY_OUT_RAMDISK)`
- [ ] `init.recovery.${ro.hardware}.rc` 目标是 `$(TARGET_COPY_OUT_ROOT)`
- [ ] `persist.sys.usb.config` 写在 `PRODUCT_DEFAULT_PROPERTY_OVERRIDES`
- [ ] 新增 priv-app 必须补 `privapp-permissions-*.xml`
- [ ] 新增 `signature|privileged` 权限必须补白名单（漏了 bootloop）
- [ ] 检查 `installed-files-ramdisk.txt` 内容是否为预期

### 每次刷机前

- [ ] 本地 img md5 与编译机 out 一致
- [ ] 数据线插着（`reboot bootloader` 前必须）
- [ ] `misc` 分区没有 `bootonce-bootloader` / `--prompt_and_wipe_data`
- [ ] adb 操作串行（不要并行，会回收 server）

### 功能验收

- [ ] WiFi 可连、IP 正常
- [ ] 蓝牙可开可连
- [ ] 相机拍照（尺寸/体积/DQT）+ 录像（旋转矩阵）
- [ ] 投屏（PC + 手机各一次）
- [ ] HDMI 输出
- [ ] 网口
- [ ] OTG / U 盘
- [ ] 音量面板、电量显示、快捷磁贴
- [ ] 重启 3 次不复现异常（验证 init 时序问题）

---

## 十、遗留问题与后续方向

| 问题 | 现状 | 建议 |
|---|---|---|
| CameraX 系第三方相机黑屏 | Camera2 API 实测正常，CameraX 1.0 自我校验失败 | 装 2022 年后的相机 App 复测；若仍失败，反编译其 CameraValidator 定位 |
| vendor 声明了 `camera.front` 但无前置摄像头 | 原厂 blob 遗留 | 要彻底修得重编 vendor.img，风险 > 收益，暂不动 |
| ROM 仍是 userdebug（`ro.debuggable=1`、adb 免授权） | 便于维护 | 若要对外交付：`lunch lineage_MS600-user` + 改 `ro.adb.secure=1` + 重新签名 |
| 内核无法升级（WiFi 依赖 CRC 匹配的 wlan.ko） | 锁死 | 除非拿到 qcacld 源码整树重编 |
| 拉伸不 letterbox 硬编码 | 保留 | 改了对投屏手势区有害 |
| UAC2 声卡 | 放弃（17 次实证） | 用 DLNA / AirPlay / 3.5mm |

---

## 十一、一句话经验

> **先备份，再动手；先验证「系统有没有」，再怪「App 不行」；
> 每次改完必刷机，每个结论必有日志或截图；镜像回滚 ≠ 源码回滚。**
