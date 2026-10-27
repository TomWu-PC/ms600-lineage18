#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#
# ===========================================================================
#  MS600（讯飞听见 L1）BoardConfig —— 移植自 LineageOS 官方 msm8953-common
#  所有硬件参数均为 2026-09-30 本机实测值，与官方 msm8953 参照逐项核对一致
# ===========================================================================

# ---------------------------- 架构 -----------------------------------------
# SDM450 / msm8953 = Cortex-A53 x8，64 位（设备实测 ABI = arm64-v8a）
TARGET_ARCH             := arm64
TARGET_ARCH_VARIANT     := armv8-a
TARGET_CPU_ABI          := arm64-v8a
TARGET_CPU_ABI2         :=
TARGET_CPU_VARIANT      := cortex-a53

TARGET_2ND_ARCH         := arm
# ⚠️ 必须是 armv8-a，不能写 armv7-a-neon！
#    Android 10+ 的 build/make/core/combo/TARGET_linux-arm.mk:53 强制要求：
#    64 位设备上的 32 位第二架构，CPU 实际是 ARMv8，写 armv7-a-neon 会直接报
#      error: Incorrect TARGET_2ND_ARCH_VARIANT, armv7-a-neon. Use armv8-a instead..
#    → dumpvars 失败 → lunch 失败 → 编译一行都没跑（2026-09-30 第二次云编译死因）
#    注意：Android 8.1 时代的 msm8953 设备树写的是 armv7-a-neon，不可照搬！
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI      := armeabi-v7a
TARGET_2ND_CPU_ABI2     := armeabi
TARGET_2ND_CPU_VARIANT  := cortex-a53

TARGET_USES_64_BIT_BINDER  := true
TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_SUPPORTS_32_BIT_APPS := true

# ---------------------------- 平台 -----------------------------------------
TARGET_BOARD_PLATFORM        := msm8953
TARGET_BOOTLOADER_BOARD_NAME := MS600
TARGET_BOARD_PLATFORM_GPU    := qcom-adreno506
TARGET_NO_BOOTLOADER         := true

# ---------------------------- 内核（★ 2026-10-01 更新）-----------------------
# 【背景】设备为 user 构建，原厂 kernel 已单独提取（prebuilt/kernel）。
#   但 18.1 的 vendor/lineage/build/soong/Android.bp 有个 lineage_generator
#   「generated_kernel_includes」，会无条件跑
#       make -C $(TARGET_KERNEL_SOURCE) ARCH=arm64 headers_install
#   只要树里任何 Android.mk 的 LOCAL_C_INCLUDES/LOCAL_CFLAGS 含
#   out/.../KERNEL_OBJ/usr/include（151 处 qcom CAF 模块，见 binary.mk:38-51），
#   build 就会自动加上 generated_kernel_headers 依赖 → 必须能跑通 headers_install。
#
# 【解法】拉真实 3.18 内核源码供 headers_install 导出 uapi：
#   ★ KudProject/kernel_xiaomi_msm8953-3.18 @ android-8.1
#     实测 VERSION=3 / PATCHLEVEL=18 / SUBLEVEL=137，与设备原厂 3.18.71 同代。
#   ⚠️ 反例：deadman96385/android_kernel_qcom_msm8953 @ LA.UM.6.6.2.r1 其实是 4.9.82！
#     CAF 代号速查：LA.UM.5.x = 3.18；LA.UM.6.6 = 4.9
#   ★ 只用于导出头文件，最终 boot.img 仍用 TARGET_PREBUILT_KERNEL
#     （原厂内核 3.18.71，与设备驱动精确匹配，不能换）。
#
# 【默认路径】vendor/lineage/config/BoardConfigKernel.mk:42-43
#     TARGET_AUTO_KDIR := $(shell echo $(TARGET_DEVICE_DIR) | sed -e 's/^device/kernel/g')
#     TARGET_KERNEL_SOURCE ?= $(TARGET_AUTO_KDIR)
#   → device/iflytek/MS600 自动映射成 kernel/iflytek/MS600（已按此路径克隆）
#   ★★ 实测（2026-10-01）：一旦该目录存在，vendor/lineage/build/tasks/kernel.mk 会判定
#      「有源码」→ FULL_KERNEL_BUILD := true → 【真的去编译整个 3.18 内核】，
#      最后在 out/.../KERNEL_OBJ 里 CC net/... 之后 Error 2 失败。
#      而我们的内核必须是原厂 3.18.71（魔改过，有厂商驱动/DTS），绝不能换自编内核。
TARGET_KERNEL_SOURCE       := kernel/iflytek/MS600      # 仅供 soong 的 headers_install 导出 uapi
TARGET_KERNEL_CONFIG       := msm8937_defconfig         # msm8937/msm8953 共用此 defconfig
TARGET_KERNEL_ARCH         := arm64
# ★★★ 关键开关（Lineage kernel.mk 官方支持，见其文件头注释）：
#   TARGET_FORCE_PREBUILT_KERNEL = 即使内核源码存在，也强制使用 TARGET_PREBUILT_KERNEL
#   ⇒ 既让 headers_install 能跑通（源码在），又保证 boot.img 用原厂内核（不编内核）
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL     := device/iflytek/MS600/prebuilt/kernel
BOARD_KERNEL_IMAGE_NAME    := Image.gz-dtb
BOARD_KERNEL_BASE          := 0x80000000
BOARD_KERNEL_PAGESIZE      := 2048
BOARD_KERNEL_TAGS_OFFSET   := 0x00000100
BOARD_RAMDISK_OFFSET       := 0x01000000
BOARD_KERNEL_OFFSET        := 0x00008000
BOARD_DTB_OFFSET           := 0x01f00000
BOARD_MKBOOTIMG_ARGS       := --ramdisk_offset 0x01000000 --tags_offset 0x00000100
# ⚠️ 这里【不要】写 buildvariant=xxx！
#    原因：DTB 的 bootargs 里本来就自带 `buildvariant=user`（实测 dtb_ms600_live.fdt 确认），
#    而 build 系统还会按 lunch 变体再追加一个 `buildvariant=<变体>`。
#    自己再写一个 → 三份重复，且末尾那个覆盖前面，行为不可控。
#
#   实测 2026-09-30 第二轮：lunch 选了 -eng，结果 cmdline 变成
#       ... buildvariant=user buildvariant=eng    ← 末尾 eng 生效，错的
#    正解：lunch 用 lineage_MS600-userdebug，让 build 系统自己追加 userdebug。
BOARD_KERNEL_CMDLINE       := console=ttyHSL0,115200,n8 \
                              androidboot.console=ttyHSL0 \
                              androidboot.hardware=qcom \
                              msm_rtb.filter=0x237 \
                              ehci-hcd.park=3 \
                              lpm_levels.sleep_disabled=1 \
                              androidboot.bootdevice=7824900.sdhci \
                              earlycon=msm_hsl_uart,0x78af000

# ---------------------------- 分区（★ 本机实测）---------------------------
# system 3.0GB · vendor 1.0GB · boot/recovery 64MB · cache 256MB
BOARD_BOOTIMAGE_PARTITION_SIZE     := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 3221225472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 21196642816
BOARD_CACHEIMAGE_PARTITION_SIZE    := 268435456
BOARD_FLASH_BLOCK_SIZE             := 131072

# ─────────────────────────────────────────────────────────────────────────────
# ★★★ 2026-10-01 血泪教训（连坑 3 个 run：#43 / #44 / #45）★★★
#     —— /dsp → /firmware 连环报错的【真正根因】与【最终处置】
# ─────────────────────────────────────────────────────────────────────────────
# 【症状】每次都是编到 99.999%（102667/102668），最后打包 system.img 时炸：
#     set_selinux_xattr: No such file or directory searching for label "/xxx"
#     e2fsdroid: No such file or directory while configuring the file system
#     ninja: build stopped: subcommand failed.
#   其中 /xxx 先是 \"/dsp\"，删掉后又变成 \"/firmware\"、下一个会是 \"/persist\"。
#
# 【完整机制】（AOSP 打包链，务必理解，否则会一直"打地鼠"）
#   ① BOARD_ROOT_EXTRA_FOLDERS / BOARD_ROOT_EXTRA_SYMLINKS 建的产物
#      都落在 TARGET_ROOT_OUT（out/target/product/MS600/root/），也就是 ramdisk。
#   ② 但本设备的 system.img 用的是 system-as-root（e2fsdroid -a /），
#      Makefile 里 FULL_SYSTEMIMAGE_DEPS += $(INTERNAL_ROOT_FILES)，
#      ⇒ root/ 的内容会被【合并进 system.img】。
#   ③ e2fsdroid 打包时会遍历镜像内 inode 树，给每个条目查 SELinux 标签。
#      ⇒ 镜像里出现 /firmware、/persist 这些【真实目录】就必须有对应规则。
#   ④ 而本设备采用的 sepolicy 组合里【没有】/dsp、/firmware、/persist 的规则
#      （实测：strings file_contexts.bin | grep -cE '^/(dsp|firmware|persist)' = 0）
#      ⇒ selabel_lookup 失败 ⇒ e2fsdroid 直接报错退出。
#
# 【为什么 15.1（Android 8.1）没事】
#   Android 8.1 的 e2fsdroid 对"查不到标签"只告警不失败；Android 11 直接 fail。
#   同一份设备树，15.1 能编过、18.1 编不过 —— 不是配置错了，是新版本更严格。
#
# 【★ 最关键的坑：改声明 ≠ 清产物】
#   BOARD_ROOT_EXTRA_* 的产物是 init.environ.rc 的 post-install 副作用，
#   删掉声明后 init.environ.rc 会重生，但【旧的软链/目录不会被删除】——
#   它们变成"僵尸产物"，下一轮编译照样被合并进 system.img，照炸不误。
#   ⇒ 改完声明后，【必须】手工清掉 out/.../<dev>/root/ 里对应的僵尸条目！
#
# 【最终处置】本设备定位为【普通平板】：
#   - 无音频 DSP 需求        ⇒ 不需要 /dsp
#   - /firmware、/persist 的挂载由 recovery.fstab / fstab.qcom 负责
#     （init 会在开机时按 fstab 挂载），不需要在 ramdisk 里预建挂载点目录。
#   ⇒ 整块移除 BOARD_ROOT_EXTRA_FOLDERS 与 BOARD_ROOT_EXTRA_SYMLINKS。
#   ⚠️ 删完记得清 out/.../<dev>/root/{dsp,firmware,persist} 三个僵尸。
# ─────────────────────────────────────────────────────────────────────────────
# （原内容，已按上述结论移除，保留备查）
#   BOARD_ROOT_EXTRA_FOLDERS  := persist firmware
#   BOARD_ROOT_EXTRA_SYMLINKS := \
#       /vendor/firmware_mnt:/firmware \
#       /mnt/vendor/persist:/persist
BOARD_ROOT_EXTRA_FOLDERS  :=
BOARD_ROOT_EXTRA_SYMLINKS :=

# ---------------------------- 文件系统 --------------------------------------
TARGET_USERIMAGES_USE_EXT4             := true
TARGET_USERIMAGES_USE_F2FS             := true
TARGET_USES_MKE2FS                     := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE     := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE   := ext4
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE      := ext4
BOARD_HAS_LARGE_FILESYSTEM             := true

# ---------------------------- 分区表类型 ------------------------------------
# A-only 单槽设备，无 A/B、无 dynamic partitions、无 metadata 分区
AB_OTA_UPDATER                  := false
BOARD_USES_METADATA_PARTITION   := false
BOARD_SUPER_PARTITION_SIZE      :=

# ---------------------------- AVB 验证启动 ----------------------------------
# ★ 实测结论：原厂 boot / recovery 分区内均搜不到 AVB0 / vbmeta 签名，
#   且 bootloader 处于 orange（已解锁）状态 → 本设备不做 AVB 强校验。
#   若强制开启 AVB 会导致编译产物带测试签名，反而可能启动失败，故关闭。
BOARD_AVB_ENABLE := false
# 关闭 dm-verity（与上面呼应，避免 system 被强行加密校验）
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS :=

# ---------------------------- Treble --------------------------------------
# 设备实测 ro.treble.enabled=true，且存在独立 vendor 分区
PRODUCT_FULL_TREBLE_OVERRIDE := true
#
# ★★★ VNDK 版本的两次结论（2026-10-01，重要踩坑记录）
#
#   ── 实测事实 ──
#   ① 服务器 prebuilts/vndk/ 里 v27 / v28 / v29 **三者俱全**
#      （v27/arm64 有 345 个 .so）。此前注释写"只有 v28/v29"是【误判】。
#   ② 原厂 vendor 的 compatibility_matrix.xml 里是：
#          <vndk><version>0.0.0</version></vndk>
#      且 /vendor/lib64 下**没有 vndk-28 / vndk-sp-28 分层目录**
#      ⇒ 这是 Android 8.1 早期 Treble 的 VNDK-SP minimal 形态。
#
#   ── ❌ 走过的弯路：BOARD_VNDK_VERSION := 27（实测失败）──
#   本以为把 VNDK 降到 27 就能对齐 8.1 vendor。实测：
#     · lunch 通过 ✅（get_build_var 返回 27）
#     · 但编译爆出 **122 个链接错误**：
#         libril   (native:vendor) can not link against libbase (native:platform)
#         rild     (native:vendor) can not link against libqemu_pipe (native:platform)
#         libwifi-hal (native:vendor) can not link against libgtest (native:platform)
#     · 真因：libbase / libgtest / libqemu_pipe / libclang_rt.ubsan_minimal
#       这些库在 Android 11 里**已不在 VNDK 名单中**（8.1 时代才在），
#       vendor 模块去链接它们时被 VNDK 强制规则拦下。
#     · 结论：这是 11 与 8.1 的 VNDK 名单差异造成的**架构性不兼容，配置绕不过**。
#
#   ── ✅ 正确路线：vendor 内容装进 system（走 AOSP 默认 system/vendor 布局）──
#   实测 lunch 后：
#       TARGET_COPY_OUT_VENDOR = system/vendor   ← AOSP 11 默认
#       BOARD_USES_VENDORIMAGE  = (空/false)     ← 不建独立 vendor.img、不建软链
#   ⇒ 只要不设 BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE，
#      PRODUCT_COPY_FILES 里写 $(TARGET_COPY_OUT_VENDOR)/xxx
#      就会自动装进 /system/vendor/ —— **同一分区内，VNDK 分区边界约束不适用**。
#   ⇒ 因此 **不需要** 降级 VNDK，保持 current 即可。
#
BOARD_VNDK_VERSION := current

# ---------------------------- VINTF 元数据（★★★ 方案C 必需）------------------
# AOSP 11 不允许用 PRODUCT_COPY_FILES 拷贝 VINTF 元数据，必须走这两个变量：
#     DEVICE_MANIFEST_FILE → vendor 侧「我提供哪些 HAL」的声明
#     DEVICE_MATRIX_FILE   → vendor 侧「我依赖 platform 的什么」的兼容矩阵
#
# 由于方案C 把原厂 vendor 内容装进 /system/vendor，这里直接用原厂的两个文件：
#   · vendor/manifest.xml             （660 行 / 40+ 个 HAL 的接口声明）⭐
#   · vendor/compatibility_matrix.xml （含 <vndk><version>0.0.0</version>）
#
# 曾踩坑：一开始把这两个文件写进 PRODUCT_COPY_FILES，报
#   error: VINTF metadata found in PRODUCT_COPY_FILES: ... use DEVICE_MANIFEST_FILE ...
#
# ⚠️ 若后续报「VINTF 不兼容」（如 HAL 版本对不上），改这两个文件即可，
#    不用重编整个 system —— 它们是独立的中间产物。
#
DEVICE_MANIFEST_FILE := device/iflytek/MS600/vendor-blobs/manifest.xml
DEVICE_MATRIX_FILE   := device/iflytek/MS600/vendor-blobs/compatibility_matrix.xml

# ---------------------------- Recovery ------------------------------------
TARGET_RECOVERY_FSTAB    := device/iflytek/MS600/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

# ---------------------------- 显示 / 图形 -----------------------------------
TARGET_USES_ION := true

# ---------------------------- 构建容错 --------------------------------------
# 设备树尚未补齐全部 vendor 依赖时，允许缺失依赖继续构建（便于逐轮迭代）
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# ===== _181_FIX_A_BOARD =====

# [FIX-A-2] HWC2 —— 15.1 根因③（已实机验证）
#   缺此开关：surfaceflinger 被编成 HWC1，去操作设备的 HWC2
#   → SIGSEGV @ HWComposer::queryDisplayProperties → 卡 bootanimation
TARGET_USES_HWC2 := true

# [FIX-A-3] qcom vendor sepolicy —— 15.1 根因②
#   缺它：keymaster/gatekeeper 等 vendor 服务全部 u:object_r:unlabeled → 起不来
#   ⚠️ 必须在 TARGET_BOARD_PLATFORM 之后（本段在文件末尾，天然满足）
include device/qcom/sepolicy/SEPolicy.mk

# [FIX-A-4] SELinux permissive —— 首次上机的保险绳
#   本设备 vendor 是 Android 8.1 的，与 Android 11 的 plat policy 差 3 代，
#   enforcing 下大概率大面积 avc denied。开机稳定、抓全 avc 后再收紧。
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

# MS600-FIX-ROOTFOLDERS: 18.1 的 ramdisk 曾漏掉挂载点目录（ninja 依赖表过期导致），
# first-stage init 挂不上 /system => init 退出 => kernel panic => 15s 掉 fastboot。
# 注意：不要加 vendor（/vendor 是软链 -> /system/vendor，建目录会冲突）
BOARD_ROOT_EXTRA_FOLDERS += system data cache metadata

# MS600: enable QCOM CAF display HAL (A11), replace 8.1 blobs
BOARD_USES_QCOM_HARDWARE := true
USE_DEVICE_SPECIFIC_AUDIO := true
USE_DEVICE_SPECIFIC_MEDIA := true

# === MS600 A11 display/graphics (patch v19, replaces 8.1 blobs) ===
TARGET_USES_ION := true
TARGET_USES_GRALLOC1 := true
TARGET_USES_HWC2 := true
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so

# MS600: 不把 data-ipa-cfg-mgr / dataservices 加入 PRODUCT_SOONG_NAMESPACES
# （ipacm/libipanat 需 v4.5 IPA 内核头，本机 3.18 无；与启动无关，用原厂 blob）
USE_DEVICE_SPECIFIC_DATA_IPA_CFG_MGR := true
USE_DEVICE_SPECIFIC_DATASERVICES := true
