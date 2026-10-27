# LineageOS 18.1 for iFLYTEK MS600 (讯飞听见 L1)

[![Android](https://img.shields.io/badge/Android-11-blue)]()
[![LineageOS](https://img.shields.io/badge/LineageOS-18.1-green)]()
[![Device](https://img.shields.io/badge/Device-MSM8953%20%2F%20SDM450-orange)]()

把一台跑 Android 8.1 的讯飞 MS600 教育平板，做成可日常使用的 **LineageOS 18.1 (Android 11)** 定制 ROM ——
包含设备树、自研系统 App、完整移植文档与踩坑记录。

> ⚠️ **本仓库不包含任何厂商专有二进制（vendor blobs / 原厂固件）**，需你自行从设备固件提取。
> 详见 [vendor blobs 说明](#vendor-blobs-需自备)。

---

## 设备规格

| 项 | 参数 |
|---|---|
| 型号 | 讯飞听见 L1（MS600），内部代号 MS600 |
| SoC | 高通 SDM450（MSM8953），8×Cortex-A53 |
| 内存/存储 | 2GB / 16GB |
| 屏幕 | 10.1" **物理竖屏 1920×1200**（density 224），系统按横屏使用 |
| 系统方向 | 框架层强制 `ROTATION_90`（屏幕零方向锁） |
| 传感器 | **无**（无 g-sensor / 光感 / 距离），无 GNSS，无 SIM 卡槽 |
| 摄像头 | 唯一后置 OV13855 13MP（HAL 输出 NV12） |
| 视频输出 | HDMI（LT8912，固定 1080p60） |
| 有线网络 | RJ45（W5500，SPI 接口，实测 ≈2.3 Mbps） |
| 其他 | USB-A OTG、3.5mm 耳机、蓝牙、Wi-Fi（5G/2.4G）、实体 F1/F2 键、手柄按键 |
| 原系统 | Android 8.1（讯飞定制，带 Magisk） |

---

## 当前状态

| 功能 | 状态 | 备注 |
|---|---|---|
| 开机 / 日常使用 | ✅ | 稳定，长期使用无重启 |
| Wi-Fi（2.4G/5G） | ✅ | — |
| 蓝牙 | ✅ | 需 Android 11 的 `bluetooth@1.1` HAL 顶上（原厂只有 1.0） |
| 相机拍照 / 录像 | ✅ | 13MP 正常画质，方向正立（本项目最难的坑，见 [docs/CAMERA.md](docs/CAMERA.md)） |
| HDMI 输出 | ✅ | 1080p60，`ms600_hdmi_out_enabled` 开关 |
| 有线网口 | ✅ | 需插网线才有 `eth0` |
| USB OTG | ✅ | host / peripheral 可切（经 `none` 中转） |
| exFAT U 盘 | ✅ | 内核未编 exFAT，用 userspace `mount.exfat` 接管 |
| Miracast / DLNA / AirPlay 接收 | ✅ | 自研 App，内置 system/priv-app |
| 音量面板音频输出切换 | ✅ | 自研 Dialog，支持 HDMI / 3.5mm / USB |
| 电量百分比（图标右侧） | ✅ | — |
| 手柄 / 实体键映射 | ✅ | 可关 |
| 第三方 CameraX 相机 App | ⚠️ | Camera2 API 实测正常，部分老版本 CameraX（1.0.x）自我校验失败 |
| UAC2 USB 声卡 | ❌ | 内核层缺陷，放弃（见文档） |
| 屏幕亮度自动调节 | ❌ | 无光感传感器 |

---

## 目录结构

```
.
├── device/iflytek/MS600/     # 设备树（构建配置，不含 vendor blobs）
│   ├── Android.mk / AndroidProducts.mk / BoardConfig.mk
│   ├── device.mk             # 产品定义（含全部定制属性）
│   ├── lineage_MS600.mk
│   ├── fstab.qcom            # ★ 进 ramdisk，first-stage 挂载
│   ├── init.recovery.qcom.rc # ★ 进 root，recovery 初始化（背光/configfs/UDC）
│   ├── init.ms600.*.rc       # 各子系统 init
│   ├── ld.config.txt         # ★ VNDK 兼容核心
│   ├── *.xml                 # feature / 权限 / 白名单
│   ├── overlay/              # RRO 资源覆盖
│   └── exfat/                # mount.exfat 源码与构建
├── apps/
│   ├── MS600Settings/        # 自研「设备设置」App（Java）
│   └── MS600Cast/            # 自研投屏接收 App（Kotlin，Miracast/DLNA/AirPlay）
├── docs/
│   ├── DEVELOPMENT.md        # ★ 完整开发过程总结（强烈建议先读）
│   ├── CAMERA.md             # 相机方向与画质修复全过程
│   ├── CAST.md               # 投屏 App 2.0 改造记录
│   └── COMPLIANCE.md         # Android 兼容性偏离说明
└── tools/
    ├── _flash_min.py         # 刷机脚本（校验 md5 → bootloader → 刷 → 重启）
    ├── mp4_rot.py            # 读 MP4 tkhd 矩阵算录像旋转角
    ├── patch_v184_cam.py     # 相机方向 + camera.back feature 补丁
    ├── patch_v190_release.py # ROM 版本标识补丁
    └── camera_probe/         # Camera2 能力探针（app_process，免装 App）
```

---

## 快速开始

### 1. 准备

```bash
# 系统依赖（Ubuntu 20.04/22.04）
sudo apt install -y openjdk-11-jdk git-core gnupg flex bison build-essential \
  zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 libncurses5 \
  x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils \
  xsltproc unzip python3

# repo 工具
mkdir -p ~/bin
curl https://mirrors.tuna.tsinghua.edu.cn/git/git-repo -o ~/bin/repo
chmod +x ~/bin/repo && export PATH=~/bin:$PATH
```

### 2. 同步 LineageOS 18.1

```bash
mkdir -p ~/lineage && cd ~/lineage
repo init -u https://github.com/LineageOS/android.git -b lineage-18.1
repo sync -c -j8          # 约 100GB，视网络 3~10 小时
```

### 3. 放入设备树与 vendor blobs

```bash
# 设备树
cp -r device/iflytek/MS600 ~/lineage/device/iflytek/

# vendor blobs：需自行从原厂固件提取，放到
#   ~/lineage/device/iflytek/MS600/vendor-blobs/
# 目录结构需与 device/vendor-iflytek-MS600.mk 中的 PRODUCT_COPY_FILES 一致
```

### 4. 编译

```bash
cd ~/lineage
source build/envsetup.sh
lunch lineage_MS600-userdebug
mka systemimage -j8
```

产物：`out/target/product/MS600/system.img`

### 5. 刷机

```bash
# 进 bootloader
adb shell setprop sys.powerctl reboot,bootloader

# 刷 system（sparse 格式直接 flash 即可）
fastboot flash system system.img
fastboot reboot
```

> ⚠️ **动手前务必备份原厂全分区**（`dd if=/dev/block/by-name/xxx`）。
> 本项目踩过 `adb remount` 改 `/vendor` 把相机配置写没、只能重刷的坑。

---

## vendor blobs 需自备

本仓库**有意不包含** `vendor-blobs/`、`vendor_files/`、`prebuilt/`、`MS600Cast/MS600Cast.apk`，
原因：这些是讯飞/高通的专有二进制，分发会侵权。

你需要从自己的设备固件里提取，常见两种方式：

1. **从原厂 `system.img` / `vendor.img` 挂载后拷贝**（需要 root 环境解 ext4）
2. 在已 root 的原厂系统里直接 `adb pull /vendor` 与 `/system`

提取后按 `device/vendor-iflytek-MS600.mk` 里的 `PRODUCT_COPY_FILES` 路径关系整理。

---

## 关键设计说明（为什么这个设备这么难搞）

| 难点 | 结论 | 文档 |
|---|---|---|
| 没有 g-sensor，但屏幕被强制 `ROTATION_90` | 相机方向必须自己算：`deviceOrientation = (360 − 屏幕角度)` | [CAMERA.md](docs/CAMERA.md) |
| 唯一摄像头被原厂标成 `FRONT` | 导致 JPEG quality = 0（13MP 只有 209KB）。必须改成 `BACK` | [CAMERA.md](docs/CAMERA.md) |
| 内核 `wlan.ko` 有 115 个 CRC 不匹配 | **内核不能重编**，所有内核级需求只能走 userspace | [DEVELOPMENT.md](docs/DEVELOPMENT.md) |
| 内核没编 exFAT | 用户态 `mount.exfat` + init daemon 接管 | — |
| 原厂只有 `bluetooth@1.0` HAL | Android 11 要 1.1，用 AOSP 的 1.1-service 桥接 | — |
| 8.1 vendor + 11 system | 靠 `ld.config.txt` + shim 库解决符号缺失（方案 C） | [DEVELOPMENT.md](docs/DEVELOPMENT.md) |
| 时区/分辨率等 framework 硬编码偏离 | 全部走 `persist.sys.ms600.stock` 开关切回 AOSP 行为 | [COMPLIANCE.md](docs/COMPLIANCE.md) |

---

## 免责声明

- 刷机有风险。本仓库的配置**只针对 MS600 这一款设备**，刷到别的机器上大概率变砖。
- 项目以 `userdebug` 构建（`ro.debuggable=1`、adb 免授权、SELinux permissive），
  适合自用与调试。若要对外发布，请自行切 `user` 构建并收紧安全配置。
- 本项目与讯飞、高通、LineageOS 官方均无关联。

## 许可

- 本仓库原创代码与配置：**Apache-2.0**（见 [LICENSE](LICENSE)）
- `device/iflytek/MS600/` 下的构建文件遵循 AOSP 惯例使用 Apache-2.0
- 厂商二进制（vendor blobs）版权归各自所有者，不在本仓库范围内
