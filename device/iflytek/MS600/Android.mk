LOCAL_PATH := device/iflytek/MS600

# ---------------------------------------------------------------------------
# 修复：Chromium WebView 原生库（18.1 同样踩 15.1 BUG-015：JNI 从未抽出）
# external/chromium-webview/Android.mk 的 LOCAL_PREBUILT_JNI_LIBS 在 Product 分区
# 场景下没有产出 lib 目录 ⇒ 运行时 UnsatisfiedLinkError: webviewchromium
# 这里显式把两个 ABI 的 so 装到 product/app/webview/lib/<abi>/
# ---------------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_PATH                 := device/iflytek/MS600
LOCAL_MODULE               := libwebviewchromium_arm64_ms600
LOCAL_MODULE_CLASS         := ETC
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_TARGET_ARCH   := arm64
LOCAL_MODULE_STEM          := libwebviewchromium.so
LOCAL_SRC_FILES            := vendor_files/libwebviewchromium_arm64.so
LOCAL_MODULE_PATH          := $(TARGET_OUT_PRODUCT_APPS)/webview/lib/arm64
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_PATH                 := device/iflytek/MS600
LOCAL_MODULE               := libwebviewchromium_arm_ms600
LOCAL_MODULE_CLASS         := ETC
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_TARGET_ARCH   := arm arm64
LOCAL_MODULE_STEM          := libwebviewchromium.so
LOCAL_SRC_FILES            := vendor_files/libwebviewchromium_arm.so
LOCAL_MODULE_PATH          := $(TARGET_OUT_PRODUCT_APPS)/webview/lib/arm
include $(BUILD_PREBUILT)


# ===========================================================================
# === MS600 v99: 硬件解码 —— 引入 msm8953 CAF 的 OMX 插件（A11 ABI 兼容）===
# 8.1 原厂 libstagefrighthw 实现的是 8.1 的 OMXPluginBase，与 A11 抽象类
# vtable 不匹配 => OMXMaster 拿不到节点 => 全系统无硬件编解码器。
# 源码: hardware/qcom-caf/msm8953/media (lineage-18.1-caf-msm8953)
# 只引入 libstagefrighthw，不碰 audio/display。
# ===========================================================================
MS600_QCOM_MM := hardware/qcom-caf/msm8953/media
include $(MS600_QCOM_MM)/libstagefrighthw/Android.mk


# ===========================================================================
# === MS600 v99b: 补 vendor 侧缺失的 libstagefright_xmlparser.so ===
# A11 的 OMX 服务(/vendor/bin/hw/)是 vendor 进程，DT_NEEDED 该库；但它只在
# /system/lib64 与 VNDK APEX 里，设备挂载的 vndk.v30 apex 又恰好没有它
# => CANNOT LINK: getDefaultXmlNames => 服务 crash loop => 没有硬件编解码器。
# 这里把编出来的 VNDK 变体装到 /vendor/lib{,64}。
# ===========================================================================
include $(CLEAR_VARS)
LOCAL_PATH                 := device/iflytek/MS600
LOCAL_MODULE               := libstagefright_xmlparser_vendor_arm64_ms600
LOCAL_MODULE_CLASS         := SHARED_LIBRARIES
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_TARGET_ARCH   := arm64
LOCAL_MODULE_STEM          := libstagefright_xmlparser.so
LOCAL_CHECK_ELF_FILES      := false
LOCAL_SRC_FILES            := vendor_files/libstagefright_xmlparser_arm64.so
LOCAL_MODULE_PATH          := $(TARGET_OUT_VENDOR)/lib64
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_PATH                 := device/iflytek/MS600
LOCAL_MODULE               := libstagefright_xmlparser_vendor_arm_ms600
LOCAL_MODULE_CLASS         := SHARED_LIBRARIES
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_TARGET_ARCH   := arm arm64
LOCAL_MODULE_STEM          := libstagefright_xmlparser.so
LOCAL_CHECK_ELF_FILES      := false
LOCAL_SRC_FILES            := vendor_files/libstagefright_xmlparser_arm.so
LOCAL_MODULE_PATH          := $(TARGET_OUT_VENDOR)/lib
include $(BUILD_PREBUILT)


# ===========================================================================
# === MS600 v112: 移除电话 / 短信 / 通讯录等 4G 相关应用 ===
# AOSP 只对 APK 模块支持 LOCAL_OVERRIDES_PACKAGES（见 core/main.mk
# product-installed-files），故用一个空壳系统应用承载该清单。
# 另：本文件已被 soong 的 Android.mk.list 收录，新目录下的 Android.mk
#     不会立刻被扫描到（列表有缓存），故必须放在这里。
# ===========================================================================
include $(CLEAR_VARS)
LOCAL_PATH          := device/iflytek/MS600/remove_packages
LOCAL_MODULE_TAGS   := optional
LOCAL_PACKAGE_NAME  := MS600RemovePackages
LOCAL_CERTIFICATE   := platform
LOCAL_PRIVATE_PLATFORM_APIS := true
LOCAL_RESOURCE_DIR  := device/iflytek/MS600/remove_packages/res
LOCAL_OVERRIDES_PACKAGES := \
    Dialer \
    messaging \
    Contacts \
    LocalContactsBackup \
    MmsService \
    Stk \
    SimAppDialog \
    CellBroadcastLegacyApp
include $(BUILD_PACKAGE)
LOCAL_PATH := device/iflytek/MS600


# ===========================================================================
# === MS600 v114: wpa_supplicant 退出崩溃修复（LD_PRELOAD 垫片）===
# 原厂 8.1 blob 在退出收尾时 double-destroy 一个 mutex（eap_proxy_deinit）；
# 8.1 bionic 容忍，A11 的 FORTIFY 检查直接 abort => 每次 WiFi 重配崩一次。
# 垫片把"对已销毁 mutex 的 destroy"变成静默成功。
# ===========================================================================
include $(CLEAR_VARS)
LOCAL_PATH          := device/iflytek/MS600
LOCAL_MODULE        := libms600_mutex_compat
LOCAL_MODULE_TAGS   := optional
LOCAL_MULTILIB      := 64
# 纯 C 垫片，不需要 C++ 运行时；且 /vendor/lib64 下没有 libc++.so
# （libc/libm/libdl 是 LLNDK，vendor 命名空间可见；libc++ 不是）
LOCAL_CXX_STL       := none
LOCAL_SRC_FILES     := wpa_shim/libms600_mutex_compat.c
LOCAL_MODULE_PATH   := $(TARGET_OUT_VENDOR)/lib64
include $(BUILD_SHARED_LIBRARY)

# ===========================================================================
# === MS600 v137: 投屏接收端（MS600Cast）—— 子目录里的预编译 APK ===
# Kati 只自动扫描 device/*/*/Android.mk（两层目录），三层子目录需显式 include。
# ===========================================================================
include $(LOCAL_PATH)/MS600Cast/Android.mk
