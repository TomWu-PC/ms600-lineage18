#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#
# 第一轮目标：先把设备树跑通（lunch + 编译 recovery/boot）。
# 因此这里刻意只保留最小自包含配置，不引用任何 vendor blob，
# 避免因缺少专有文件而在早期就中断构建。
# 后续迭代会逐步补齐 audio / display / camera / wifi 等 HAL。
#

LOCAL_PATH := device/iflytek/MS600

# ---------------------------- 屏幕 ------------------------------------------
# 本机实测：物理分辨率 1200x1920（竖屏面板）+ density 224
PRODUCT_AAPT_CONFIG      := normal
PRODUCT_AAPT_PREF_CONFIG := hdpi

# ---------------------------- 内核 ------------------------------------------
# 内核由 BoardConfig.mk 的 TARGET_PREBUILT_KERNEL 交给 build 系统打包进 boot.img，
# 不要再用 PRODUCT_COPY_FILES 往 /system 根目录塞一份（27.5MB 冗余，
# 且 Android 11 会警告 "copying to system root is deprecated"）。
# 2026-09-30 修正。

# ---------------------------- 属性 ------------------------------------------
PRODUCT_PROPERTY_OVERRIDES += \
    ro.adb.secure=0 \
    ro.secure=0

# ★★★ 18.1 强制开 adb（2026-10-03）：
#   Android 11 的 ramdisk /default.prop 是软链 -> /system/etc/prop.default，
#   而【只有 PRODUCT_DEFAULT_PROPERTY_OVERRIDES 会写进 prop.default】。
#   之前误加进 PRODUCT_PROPERTY_OVERRIDES（只写 /system/build.prop），
#   而 build.prop 要等 /system 挂载后才由 second-stage init 读取 —— 太晚，
#   USB 始终没切 adb，导致 18.1 全程抓不到 shell（实测 110s 回退，adb 从未 up）。
#   persist.sys.usb.config 必须在 prop.default 里，init 才会在早期就配置 USB。
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.timezone=Asia/Shanghai \
    ro.sf.lcd_density=224 \
    ro.telephony.default_network=9 \
    persist.sys.usb.config=adb \
    ro.adb.secure=0 \
    ro.secure=0 \
    ro.debuggable=1 \
    service.adb.root=1

# ---------------------------- ROM 版本标识 ----------------------------------
# MS600 v190 正式版。userdebug 构建的 ro.build.version.incremental 在增量编译时
# 不会刷新（缓存在 out/ 里），所以另起一组属性标识正式版，便于日后确认设备跑的
# 到底是哪一版：getprop ro.ms600.rom.version
PRODUCT_PROPERTY_OVERRIDES += \
    ro.ms600.rom.version=1.0.0-release.20261028 \
    ro.ms600.rom.channel=release \
    ro.ms600.rom.note=LineageOS18.1-MS600-full-feature-set

# 默认语言：简体中文
PRODUCT_LOCALES        := zh_CN,en_US
PRODUCT_DEFAULT_LANGUAGE := zh_CN

# ---------------------------- 外置存储 --------------------------------------
# 设备无内置 SD 卡槽/OTG 由内核支持，交给 vold 自动处理
PRODUCT_PACKAGES += \
    e2fsck \
    fsck.f2fs

# ---------------------------- Recovery 初始化脚本 ----------------------------
# ★★★ 关键修复（2026-10-01，第二次踩坑）：
#
#   AOSP recovery 的 init.rc 第一行是：
#       import /init.recovery.${ro.hardware}.rc
#   本机 ro.hardware=qcom，所以 init 会去找 /init.recovery.qcom.rc。
#   该文件 *不在 AOSP 通用源码里*，必须由设备树提供。
#
#   缺了它会连锁三件事全废：
#     ① 背光不写 panel0-backlight/brightness  → 黑屏
#     ② /config/usb_gadget/g1 (configfs) 不建 → USB 不枚举
#     ③ UDC 不绑定 → gadget 起不来 → init 空转 → watchdog 重启
#
#   ⚠️ 第一次修复只把文件放进设备树目录，但 *没有构建规则*，
#      所以根本没进 ramdisk —— 刷完依旧黑屏。
#
#   正确机制（实测 build/make/core/Makefile:2234）：
#       cp $(TARGET_ROOT_OUT)/init.recovery.*.rc $(TARGET_RECOVERY_ROOT_OUT)/
#   build 只从 **root 分区目录** 捞 init.recovery.*.rc 进 recovery ramdisk，
#   所以这里必须把目标写成根目录下的 init.recovery.qcom.rc，
#   它会先被装进 out/target/product/MS600/root/，再自动进 recovery ramdisk。
#
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.recovery.qcom.rc:$(TARGET_COPY_OUT_ROOT)/init.recovery.qcom.rc

# ---------------------------- ★★★ first-stage fstab（2026-10-01 第三次踩坑）----
# 背景：18.1 编译出 system.img / boot.img 后才发现 —— **ramdisk 里只有 init**：
#     installed-files-ramdisk.txt  →  "1840016  /ramdisk/init"
#   而 AOSP 11 的 first-stage init 靠 ramdisk 根的 /fstab.${ro.hardware} 挂载分区：
#     system/core/init/first_stage_mount.cpp:159 ReadFirstStageFstab()
#       → ReadFstabFromDt() 失败（本机原厂 bootloader 不传）
#       → ReadDefaultFstab()  读 /fstab.qcom
#   没有它就挂不上 /system → 卡开机。**这是方案C 刷机前的最后一个结构性缺口。**
#
# 进 ramdisk 的机制（实测确认）：
#   build/make/core/Makefile:1143
#     INTERNAL_RAMDISK_FILES := $(filter $(TARGET_RAMDISK_OUT)/%, $(ALL_..._MODULES))
#   build/make/core/envsetup.mk:817
#     TARGET_RAMDISK_OUT := $(PRODUCT_OUT)/$(TARGET_COPY_OUT_RAMDISK)   # = .../ramdisk
#   ⇒ 只要 PRODUCT_COPY_FILES 的目标落在 $(TARGET_COPY_OUT_RAMDISK)/ 下就会被 MKBOOTFS 打进 ramdisk。
#   这正是 AOSP 官方设备的写法（如 device/google/cuttlefish/shared/device.mk:226
#       config/fstab.f2fs:$(TARGET_COPY_OUT_RAMDISK)/fstab.f2fs）。
#
# ★ 注意 TARGET_COPY_OUT_RAMDISK（=ramdisk，普通 boot ramdisk）≠ TARGET_COPY_OUT_ROOT（=root，
#   那是 **recovery** 的根，上面的 init.recovery.qcom.rc 走的就是那条路）。两者不可混用。
# ⚠️⚠️ 目标路径必须写【字面量 "ramdisk/"】，千万不能用 $(TARGET_COPY_OUT_RAMDISK)：
#   实测这个变量的值不可靠 —— envsetup.mk:229 定义它为 ramdisk，
#   但 board_config.mk:278 又把它改写成 $(TARGET_COPY_OUT_ROOT)（= root，
#   那是 **recovery** 的根目录，跟 boot ramdisk 完全是两回事）。
#   结果：写成变量时文件压根没被安装（out/ 下 fstab.qcom / ramdisk/ / root/ 三处都没有）。
#   PRODUCT_COPY_FILES 的目标本来就是相对 $(PRODUCT_OUT) 的路径，
#   `ramdisk/` 即 $(PRODUCT_OUT)/ramdisk/ = TARGET_RAMDISK_OUT（envsetup.mk:817），
#   正是 MKBOOTFS 打包进 ramdisk.img 的源目录。
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.qcom:ramdisk/fstab.qcom

# ---------------------------- VNDK 兼容（★★★ 2026-10-01 结论：不动 VNDK）------
# 目标：让 18.1（Android 11）的 framework 能驱动【原厂 Android 8.1 的 vendor 内容】。
#
# ★ 最终路线（实测确定）：
#   把原厂 vendor 的 blobs **装进 system 分区**（/system/vendor），
#   即走 AOSP 11 的默认布局：
#       TARGET_COPY_OUT_VENDOR = system/vendor
#       BOARD_USES_VENDORIMAGE  = false（不建独立 vendor.img）
#   ⇒ vendor 与 system 在**同一分区**内，Treble 的 VNDK 分区边界约束不适用，
#     因此 **不需要降级 VNDK**，也不用 PRODUCT_EXTRA_VNDK_VERSIONS。
#
# ★ 曾经的弯路（已废弃，勿重蹈）：
#   把 BOARD_VNDK_VERSION 降为 27 + 加下方这行 PRODUCT_EXTRA_VNDK_VERSIONS := 27
#   → lunch 能过，但编译爆 122 个 "vendor can not link against platform" 链接错误。
#   真因：libbase / libgtest / libqemu_pipe 等库在 Android 11 已不在 VNDK 名单，
#   而 8.1 时代它们在。这是架构性不兼容，配置绕不过。
#
# ⚠️ 记录：PRODUCT_EXTRA_VNDK_VERSIONS 是【产品级只读变量】，
#    只能写在这里（device.mk / lineage_MS600.mk），
#    写到 BoardConfig.mk 会报 cannot assign to readonly variable。
#    （本行保持注释状态，仅在需要产出低版本 VNDK 兼容库时才启用。）
#
# PRODUCT_EXTRA_VNDK_VERSIONS := 27

# ---------------------------- 原厂 vendor 内容（★★★ 方案C 核心）------------
# 把原厂 Android 8.1 的 vendor 内容（2531 个文件 / 426MB）装进本 ROM 的
# system 分区，路径为 /system/vendor/。
#
# 机制与理由见 BoardConfig.mk 的 Treble 段；此处只做引入。
# 规则文件由 _工具/vendor_extract_plan_c.py 自动生成，勿手改。
#
include device/iflytek/MS600/vendor-iflytek-MS600.mk

# ---------------------------- 构建容错 --------------------------------------
# 第一轮允许缺失依赖，便于逐轮补齐设备树
ALLOW_MISSING_DEPENDENCIES := true

# ---------------------------- Soong 命名空间 --------------------------------
# ⚠️ 暂不声明 PRODUCT_SOONG_NAMESPACES：本设备树目前没有任何 Android.bp，
#    声明空的命名空间目录会让 Soong 在扫描阶段报错。
#    等第二轮补 prebuilt HAL（每个目录带 Android.bp）时再恢复，写法：
#      PRODUCT_SOONG_NAMESPACES += device/iflytek/MS600

PRODUCT_COPY_FILES += \
    device/iflytek/MS600/init.ms600.adb.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.ms600.adb.rc

# MS600 v129: 已移除调试用的 ms600_dump.sh + init.ms600.dbg.rc（全树零引用；
# dbg.rc 的 adb 配置由 init.ms600.adb.rc 承担，permissive 由 BoardConfig 的
# androidboot.selinux=permissive 承担）。原件备份 ~/ms600_bak_v129/。

# === MS600 v74: A11 蓝牙 1.1 HAL ===
#   A11 框架硬编码要 bluetooth@1.1::IBluetoothHci，而 8.1 QTI HAL 只有 1.0。
#   A11 的 android.hardware.bluetooth@1.1-service 通过 @1.0-impl dlopen 厂商 libbt-vendor.so
#   （8.1 QTI 提供，HAL 接口稳定）⇒ 用它顶替。
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.1-service

# === MS600 2026-10-03: 图形设备节点权限 (ueventd 规则 + init 兜底) ===
PRODUCT_COPY_FILES += device/iflytek/MS600/ueventd.qcom.rc:$(TARGET_COPY_OUT_RAMDISK)/ueventd.qcom.rc
PRODUCT_COPY_FILES += device/iflytek/MS600/ueventd.vendor.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc
PRODUCT_COPY_FILES += device/iflytek/MS600/init.ms600.gfx.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.ms600.gfx.rc
# MS600 v149: USB OTG —— 放开 /sys/devices/soc/7000000.ssusb/mode 写权限（host/peripheral 切换）
PRODUCT_COPY_FILES += device/iflytek/MS600/init.ms600.usb.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.ms600.usb.rc
# MS600 v151: USB 自动模式守护脚本
PRODUCT_COPY_FILES += device/iflytek/MS600/ms600_usb_auto.sh:$(TARGET_COPY_OUT_SYSTEM)/etc/ms600_usb_auto.sh

# MS600 v163: exFAT OTG（userspace FUSE）
#   内核没编 CONFIG_EXFAT_FS，vold 挂不上 exFAT 分区；用 mount.exfat 接管。
#   原先放在 Magisk 模块 /data/adb/modules/exfat_otg —— 清数据就丢，故做进 system。
PRODUCT_COPY_FILES += device/iflytek/MS600/exfat/mount.exfat:$(TARGET_COPY_OUT_SYSTEM)/bin/mount.exfat
PRODUCT_COPY_FILES += device/iflytek/MS600/exfat/exfat_daemon.sh:$(TARGET_COPY_OUT_SYSTEM)/etc/exfat_daemon.sh
PRODUCT_COPY_FILES += device/iflytek/MS600/init.ms600.exfat.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.ms600.exfat.rc
PRODUCT_COPY_FILES += device/iflytek/MS600/default-permissions-ms600.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/default-permissions/default-permissions-ms600.xml
# 投屏 App 的 so 由 App 自己从 APK 解出并 chmod（见 WfdRootHelper.ensureBinary），不再单独拷

# === MS600 v98: WebView 命令行（允许软件平台解码器）===
PRODUCT_COPY_FILES += \
    device/iflytek/MS600/init.ms600.webview.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.ms600.webview.rc

# === MS600 v99: 硬件解码 —— 自编 A11 兼容的 OMX 插件 ===
PRODUCT_PACKAGES += \
    libstagefrighthw
# === MS600 v99c: 上面的两个 prebuilt 必须进 PRODUCT_PACKAGES 才会真的安装 ===
# === MS600 v99i: 硬解 perf 提频（OMX-VDEC 需要 ro.vendor.extension_library）===
# 注意：本设备非 SAR(vendor=system/vendor)，PRODUCT_VENDOR_PROPERTIES 会被丢弃，
#       必须用 PRODUCT_PROPERTY_OVERRIDES（写 /system/build.prop）。
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.extension_library=libqti-perfd-client.so
PRODUCT_PACKAGES += \
    libstagefright_xmlparser_vendor_arm64_ms600 \
    libstagefright_xmlparser_vendor_arm_ms600

# 免授权 adb key（本机 ~/.android/adbkey.pub）
PRODUCT_COPY_FILES += device/iflytek/MS600/adbkey.pub:$(TARGET_COPY_OUT_RAMDISK)/adb_keys
PRODUCT_COPY_FILES += device/iflytek/MS600/adbkey.pub:$(TARGET_COPY_OUT_SYSTEM)/etc/adb_keys

# MS600 2026-10-03: linkerconfig 需要 ro.vndk.version（否则 Check failed VENDOR_VNDK_VERSION -> init SEGV）
PRODUCT_PROPERTY_OVERRIDES += ro.vndk.version=30

# === MS600 v90 (2026-10-05): ART 堆配置 —— 修复「所有 App Java 堆上限仅 16MB」===
# 证据: logcat "Clamp target GC heap from 16MB to 16MB" + 哔哩哔哩HD 启动即 OutOfMemoryError。
# 原因: AOSP 主线不提供 dalvik.vm.heap* 默认值（由 OEM vendor 提供），本设备树从未补上，
#       zygote 读不到 heapgrowthlimit/heapsize => ART 退回内置最小值(16MB)。
# 后果: 任何稍大的 App(B站/Chrome/游戏/相机)全部活不下来。
# 设备 RAM 2912MB + zram 511MB => 采用 3GB 档配置。
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=16m \
    dalvik.vm.heapgrowthlimit=256m \
    dalvik.vm.heapsize=512m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=4m \
    dalvik.vm.heapmaxfree=16m

# === MS600 v91 (2026-10-05): 补 8.1 audio HAL 缺失库 => 修复「完全无声」===
# 证据: AudioFlinger "loadHwModule() error -19 loading module primary"
#       linker  "audio.primary.msm8953.so: library libaudioroute.so not found"
# 原因: libaudioroute 是 A11 已删除的库；libtinyalsa 存在但不在 A11 VNDK
#       shared_libs 白名单 => [vendor] 命名空间都够不着 /system/lib64。
# 修法: 取原厂 8.1 system.img 的库(ABI 完全匹配 blob)，物理放进 vendor。
#   (a2dp/usb/r_submix 能起、唯独 primary 起不来，就是这两个库卡的。)
PRODUCT_COPY_FILES += \
    device/iflytek/MS600/vendor-blobs/libaudiolibs/libaudioroute.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libaudioroute.so \
    device/iflytek/MS600/vendor-blobs/libaudiolibs/libaudioroute32.so:$(TARGET_COPY_OUT_VENDOR)/lib/libaudioroute.so \
    device/iflytek/MS600/vendor-blobs/libaudiolibs/libtinyalsa.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libtinyalsa.so \
    device/iflytek/MS600/vendor-blobs/libaudiolibs/libtinyalsa32.so:$(TARGET_COPY_OUT_VENDOR)/lib/libtinyalsa.so

# MS600 v94 (2026-10-05): 音频符号垫片 —— libaudioroute.so(/vendor/lib{,64}) 的 DT_NEEDED
#   指向它（patchelf 注入），靠它提供 A11 已从 libcutils 移除的 set_sched_policy，
#   否则 8.1 的 audio.primary.msm8953.so 会 dlopen 失败 => 全程无声。
#   必须两个架构都装：/vendor/lib 给 32 位 audio HAL，/vendor/lib64 给 64 位路径。
PRODUCT_PACKAGES += libms600_audio_compat

# === MS600 2026-10-03: EGL/GLES 驱动选择 ===
# A11 的 libEGL Loader 用 ro.hardware.egl 拼出 libEGL_<prop>.so
# (frameworks/native/opengl/libs/EGL/Loader.cpp:143 DRIVER_SUFFIX_PROPERTY)。
# 该属性在 porting 时丢失 -> Loader 只能去找不存在的 /vendor/lib64/egl/libEGL.so
# -> GLESRenderEngine::create() abort -> SurfaceFlinger 起不来(全程 boot_completed=0)。
# 原厂 8.1 vendor.prop / 官方 msm8953 vendor.prop 均为 ro.hardware.egl=adreno。
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.egl=adreno \
    ro.hardware.gralloc=msm8953 \
    ro.opengles.version=196610 \
    debug.egl.hw=0 \
    debug.sf.hw=0

# MS600 2026-10-03: 安装非隔离 ld.config.txt（原本是孤儿文件，从未进镜像）
PRODUCT_COPY_FILES += device/iflytek/MS600/ld.config.txt:$(TARGET_COPY_OUT_SYSTEM)/etc/ld.config.txt

# MS600 v129: 已移除调试用的 ms600_probe.sh（全树零引用）

# MS600 v129: 已移除调试看门狗 ms600_watchdog.sh（v82 起 init.rc 已不引用；脚本会 reboot bootloader，属隐患）

# MS600: 禁用残缺的 precompiled sepolicy（18.1 编出的 precompiled 缺 143 个 plat 类型，
# 会导致 linkerconfig/apexd 起不来）。禁用后 init 走动态合并路径，策略完整。
PRODUCT_PRECOMPILED_SEPOLICY := false
# === MS600 A11 display HAL packages (patch v19, corrected) ===
PRODUCT_PACKAGES += \
    gralloc.msm8953 \
    hwcomposer.msm8953 \
    memtrack.msm8953 \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.mapper@2.0-impl \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    libdisplayconfig \
    libqdutils \
    libqdMetaData \
    android.hardware.light@2.0-service \
    android.hardware.light@2.0-impl \
    android.hardware.health@2.1-service \
    android.hardware.health@2.1-impl \
    android.hardware.vibrator@1.0-service \
    android.hardware.vibrator@1.0-impl \
    android.hardware.sensors@1.0-service \
    android.hardware.sensors@1.0-impl \
    android.hardware.audio.service \
    android.hardware.audio@2.0-impl \
    android.hardware.audio.effect@2.0-impl \
    libeffects \
    android.hardware.soundtrigger@2.0-impl \
    android.hardware.thermal@1.0-service \
    android.hardware.thermal@1.0-impl \
    android.hardware.keymaster@3.0-service \
    android.hardware.keymaster@3.0-impl \
    libkeymaster3device \
    libqservice

# === MS600 v27: 强制使用 A11 源码编译的 vndservicemanager/vndservice ===
PRODUCT_PACKAGES += \
    vndservicemanager \
    vndservice

# === MS600 v32: power HAL 换 A11 源码版 ===
# 8.1 blob 缺 libhidltransport 起不来 -> SystemServer PowerManagerService
# connectPowerHalLocked() 永久 Waiter::wait -> boot_completed 永远为 0。
PRODUCT_PACKAGES += android.hardware.power@1.0-service
PRODUCT_PACKAGES += android.hardware.power@1.0-impl

# --- MS600_SHIM53: Android 11 兼容垫片 ---------------------------------
# 原厂(Android 9 时代)的 31 个 vendor 二进制 DT_NEEDED 引用了 A11 已删除的
# libhidltransport.so / libhwbinder.so，不装这两个空壳就会全部 CANNOT LINK，
# 导致 WiFi/蓝牙/相机/GPS/门锁/媒体硬解/电话 全链路瘫痪。
# A11 源码里本就保留了两个空壳模块（注释标 deprecated），启用即可。
PRODUCT_PACKAGES += \
    libhidltransport \
    libhwbinder \
    ms600_hidl_shim_anchor

# [v75] 使用 A11 自编译的 libminijail_vendor（8.1 blob 解析 A11 seccomp policy 会 abort）
PRODUCT_PACKAGES += \
    libminijail_vendor

# [v75] A11 版 libavservices_minijail_vendor（8.1 OMX 服务 DT_NEEDED 引用它）
PRODUCT_PACKAGES += \
    libavservices_minijail_vendor

# [v75] A11 蓝牙栈默认启动超时 2900ms，而 QTI libbt-vendor.so 首轮初始化需 ~5s
#     （等待 hciattach/固件配置），导致 startup_timer_expired 后上层放弃。
#     实测把超时放宽到 15s 后，HAL 能完整走到 event_finish_startup。
PRODUCT_SYSTEM_PROPERTIES += \
    bluetooth.enable_timeout_ms=15000

# ==================== v76 ====================
# 【蓝牙】两个根因：
#  1) Java 侧 AdapterState 硬编码 BLE_START_TIMEOUT_DELAY=4000ms，而 QTI
#     libbt-vendor.so 首轮要等 hciattach ~5s -> BLE_START_TIMEOUT -> 栈自关。
#     已改 AdapterState.java 到 15000ms。（原生侧 bluetooth.enable_timeout_ms 见上）
#  2) 蓝牙芯片（QTI BTS 402x / WCNSS SMD）从未初始化，控制器返回占位地址
#     00:00:00:00:5A:AD。用 hci_qcomm_init -d /dev/smd3 初始化 + 常驻 hciattach 服务。
#     ro.qualcomm.bt.hci_transport=smd 让 hci_qcomm_init 选 SMD 而不是 /dev/ttyHS0。
PRODUCT_SYSTEM_PROPERTIES += \
    ro.qualcomm.bt.hci_transport=smd

PRODUCT_COPY_FILES += \
    device/iflytek/MS600/ms600_bt_init.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/ms600_bt_init.sh \
    device/iflytek/MS600/init.ms600.bt.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.ms600.bt.rc

# MS600 v81: 内置存储修复（/mnt 必须是 tmpfs）


# MS600 v111: 启用设备 overlay（以太网设置页 + config_voice_capable=false 屏蔽电话UI）
PRODUCT_PACKAGE_OVERLAYS += device/iflytek/MS600/overlay

# MS600 v112: 移除电话/短信/通讯录等 4G 相关应用
PRODUCT_PACKAGES += MS600RemovePackages


# MS600 v114: wpa_supplicant 退出崩溃修复（LD_PRELOAD 垫片）
PRODUCT_PACKAGES += libms600_mutex_compat

# MS600 v115: 「设备设置」App（F1/F2 按键自定义）
PRODUCT_PACKAGES += MS600Settings
# MS600 v140: 自研网络定位提供者（本机无 GNSS 硬件，靠固定坐标 + geo-IP）
PRODUCT_PACKAGES += MS600Nlp
PRODUCT_COPY_FILES += \
    device/iflytek/MS600/privapp-permissions-ms600.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-ms600.xml

# MS600 v159 (A1): 额外特性声明（leanback / type.television / gamepad / ethernet）
#   配套：SystemUI 的 leanback 判定已强制 false，避免走 TV 皮肤导致启动崩溃。
PRODUCT_COPY_FILES += \
    device/iflytek/MS600/ms600-features.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/ms600-features.xml

# MS600 v137: 投屏接收端（platform 签名，预置为 priv-app）
#   自带 Miracast/DLNA/AirPlay 接收实现（独立 APK，依赖 Gradle 体系外的库，不并入 Soong）。
PRODUCT_PACKAGES += MS600Cast

# MS600 v116: 旁路充电 —— 放开充电使能节点的写权限（给 system_server）
PRODUCT_COPY_FILES += \
    device/iflytek/MS600/init.ms600.power.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.ms600.power.rc

# === MS600 v141: 游戏手柄专用按键映射（Zikway, Vendor 3537 / Product 1041）===
PRODUCT_COPY_FILES += \
    device/iflytek/MS600/Vendor_3537_Product_1041.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_3537_Product_1041.kl

# MS600 v157 (A3): 本机无基带、无 SIM 槽。
#   声明"没有 radio"后 TelephonyManager 不再假装有手机功能
#   （注意：这只影响电话栈行为，不会摘掉 vendor 里声明的
#    android.hardware.telephony 特性 —— 那些来自 /vendor/etc/permissions/*.xml）
PRODUCT_PROPERTY_OVERRIDES += \
    ro.radio.noril=1

# MS600 v184: 补 android.hardware.camera.back feature（第三方相机兼容）
PRODUCT_COPY_FILES += device/iflytek/MS600/ms600-camera-features.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/ms600-camera-features.xml
