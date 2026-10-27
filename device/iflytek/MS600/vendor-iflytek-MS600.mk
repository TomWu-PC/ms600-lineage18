#
# vendor-iflytek-MS600.mk
#
# ★ 自动生成（2026-10-01）—— 由 _工具/vendor_extract_plan_c.py 产出
# 用途：把原厂 Android 8.1 的 vendor 内容装进 18.1 的 system 分区。
#
# 机制：目标路径写 $(TARGET_COPY_OUT_VENDOR)/xxx
#       → 18.1 里该变量 = system/vendor（AOSP 11 默认）
#       → 于是全部内容落进 /system/vendor/，与 system 同分区
#       → Treble 的 VNDK 分区边界约束不适用，无需降级 VNDK
#

LOCAL_VENDOR_PATH := device/iflytek/MS600/vendor-blobs

# ---------------------------- vendor 文件 ----------------------------
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/ATFWD-daemon:$(TARGET_COPY_OUT_VENDOR)/bin/ATFWD-daemon
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/DR_AP_Service:$(TARGET_COPY_OUT_VENDOR)/bin/DR_AP_Service
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/KmInstallKeybox:$(TARGET_COPY_OUT_VENDOR)/bin/KmInstallKeybox
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/LKCore:$(TARGET_COPY_OUT_VENDOR)/bin/LKCore
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/PktRspTest:$(TARGET_COPY_OUT_VENDOR)/bin/PktRspTest
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/SoterProvisioningTool:$(TARGET_COPY_OUT_VENDOR)/bin/SoterProvisioningTool
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/StoreKeybox:$(TARGET_COPY_OUT_VENDOR)/bin/StoreKeybox
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/WifiLogger_app:$(TARGET_COPY_OUT_VENDOR)/bin/WifiLogger_app
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/adsprpcd:$(TARGET_COPY_OUT_VENDOR)/bin/adsprpcd
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/athdiag:$(TARGET_COPY_OUT_VENDOR)/bin/athdiag
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/audioflacapp:$(TARGET_COPY_OUT_VENDOR)/bin/audioflacapp
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/btnvtool:$(TARGET_COPY_OUT_VENDOR)/bin/btnvtool
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/cnd:$(TARGET_COPY_OUT_VENDOR)/bin/cnd
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/cnss-daemon:$(TARGET_COPY_OUT_VENDOR)/bin/cnss-daemon
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/cnss_diag:$(TARGET_COPY_OUT_VENDOR)/bin/cnss_diag
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/cplay:$(TARGET_COPY_OUT_VENDOR)/bin/cplay
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/diag_callback_sample:$(TARGET_COPY_OUT_VENDOR)/bin/diag_callback_sample
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/diag_dci_sample:$(TARGET_COPY_OUT_VENDOR)/bin/diag_dci_sample
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/diag_klog:$(TARGET_COPY_OUT_VENDOR)/bin/diag_klog
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/diag_mdlog:$(TARGET_COPY_OUT_VENDOR)/bin/diag_mdlog
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/diag_socket_log:$(TARGET_COPY_OUT_VENDOR)/bin/diag_socket_log
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/diag_uart_log:$(TARGET_COPY_OUT_VENDOR)/bin/diag_uart_log
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/dpmQmiMgr:$(TARGET_COPY_OUT_VENDOR)/bin/dpmQmiMgr
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/e_loop:$(TARGET_COPY_OUT_VENDOR)/bin/e_loop
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/energy-awareness:$(TARGET_COPY_OUT_VENDOR)/bin/energy-awareness
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/fm_qsoc_patches:$(TARGET_COPY_OUT_VENDOR)/bin/fm_qsoc_patches
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/ftmdaemon:$(TARGET_COPY_OUT_VENDOR)/bin/ftmdaemon
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/gamed:$(TARGET_COPY_OUT_VENDOR)/bin/gamed
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/garden_app:$(TARGET_COPY_OUT_VENDOR)/bin/garden_app
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/grep:$(TARGET_COPY_OUT_VENDOR)/bin/grep
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hal_proxy_daemon:$(TARGET_COPY_OUT_VENDOR)/bin/hal_proxy_daemon
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hbtp_daemon:$(TARGET_COPY_OUT_VENDOR)/bin/hbtp_daemon
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hci_qcomm_init:$(TARGET_COPY_OUT_VENDOR)/bin/hci_qcomm_init
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hostapd:$(TARGET_COPY_OUT_VENDOR)/bin/hostapd
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hostapd_cli:$(TARGET_COPY_OUT_VENDOR)/bin/hostapd_cli
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hvdcp_opti:$(TARGET_COPY_OUT_VENDOR)/bin/hvdcp_opti
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/android.hardware.bluetooth@1.0-service-qti:$(TARGET_COPY_OUT_VENDOR)/bin/hw/android.hardware.bluetooth@1.0-service-qti
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/android.hardware.camera.provider@2.4-service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/android.hardware.camera.provider@2.4-service
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/android.hardware.cas@1.0-service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/android.hardware.cas@1.0-service
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/android.hardware.configstore@1.0-service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/android.hardware.configstore@1.0-service
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/android.hardware.drm@1.0-service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/android.hardware.drm@1.0-service
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/android.hardware.gatekeeper@1.0-service-qti:$(TARGET_COPY_OUT_VENDOR)/bin/hw/android.hardware.gatekeeper@1.0-service-qti
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/android.hardware.media.omx@1.0-service:$(TARGET_COPY_OUT_VENDOR)/bin/ms600_disabled/omx-service.bin
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/android.hardware.wifi@1.0-service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/android.hardware.wifi@1.0-service
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/rild:$(TARGET_COPY_OUT_VENDOR)/bin/hw/rild
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/vendor.display.color@1.0-service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/vendor.display.color@1.0-service
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/vendor.qti.esepowermanager@1.0-service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/vendor.qti.esepowermanager@1.0-service
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/vendor.qti.gnss@1.0-service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/vendor.qti.gnss@1.0-service
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/vendor.qti.hardware.alarm@1.0-service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/vendor.qti.hardware.alarm@1.0-service
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/vendor.qti.hardware.factory@1.0-service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/vendor.qti.hardware.factory@1.0-service
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/vendor.qti.hardware.perf@1.0-service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/vendor.qti.hardware.perf@1.0-service
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/vendor.qti.hardware.qdutils_disp@1.0-service-qti:$(TARGET_COPY_OUT_VENDOR)/bin/hw/vendor.qti.hardware.qdutils_disp@1.0-service-qti
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/vendor.qti.hardware.qteeconnector@1.0-service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/vendor.qti.hardware.qteeconnector@1.0-service
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/vendor.qti.hardware.tui_comm@1.0-service-qti:$(TARGET_COPY_OUT_VENDOR)/bin/hw/vendor.qti.hardware.tui_comm@1.0-service-qti
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/hw/wpa_supplicant:$(TARGET_COPY_OUT_VENDOR)/bin/hw/wpa_supplicant
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/icm:$(TARGET_COPY_OUT_VENDOR)/bin/icm
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/ims_rtp_daemon:$(TARGET_COPY_OUT_VENDOR)/bin/ims_rtp_daemon
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/imsdatadaemon:$(TARGET_COPY_OUT_VENDOR)/bin/imsdatadaemon
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/imsqmidaemon:$(TARGET_COPY_OUT_VENDOR)/bin/imsqmidaemon
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/imsrcsd:$(TARGET_COPY_OUT_VENDOR)/bin/imsrcsd
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.class_main.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.class_main.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.crda.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.crda.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.mdm.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.mdm.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.qcom.class_core.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.class_core.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.qcom.coex.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.coex.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.qcom.crashdata.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.crashdata.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.qcom.early_boot.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.early_boot.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.qcom.efs.sync.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.efs.sync.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.qcom.post_boot.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.post_boot.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.qcom.sdio.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.sdio.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.qcom.sensors.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.sensors.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.qcom.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.qcom.syspart_fixup.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.syspart_fixup.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.qcom.usb.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.usb.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.qcom.wifi.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.wifi.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.qti.fm.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qti.fm.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.qti.ims.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qti.ims.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/init.qti.qseecomd.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qti.qseecomd.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/ipacm:$(TARGET_COPY_OUT_VENDOR)/bin/ipacm
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/ipacm-diag:$(TARGET_COPY_OUT_VENDOR)/bin/ipacm-diag
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/irsc_util:$(TARGET_COPY_OUT_VENDOR)/bin/irsc_util
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/loc_launcher:$(TARGET_COPY_OUT_VENDOR)/bin/loc_launcher
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/lowi-server:$(TARGET_COPY_OUT_VENDOR)/bin/lowi-server
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/mlid:$(TARGET_COPY_OUT_VENDOR)/bin/mlid
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/mm-audio-ftm:$(TARGET_COPY_OUT_VENDOR)/bin/mm-audio-ftm
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/mm-pp-dpps:$(TARGET_COPY_OUT_VENDOR)/bin/mm-pp-dpps
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/mm-qcamera-app:$(TARGET_COPY_OUT_VENDOR)/bin/mm-qcamera-app
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/mm-qcamera-daemon:$(TARGET_COPY_OUT_VENDOR)/bin/mm-qcamera-daemon
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/mm-qjpeg-dec-test:$(TARGET_COPY_OUT_VENDOR)/bin/mm-qjpeg-dec-test
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/mm-qjpeg-enc-test:$(TARGET_COPY_OUT_VENDOR)/bin/mm-qjpeg-enc-test
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/mm-qomx-idec-test:$(TARGET_COPY_OUT_VENDOR)/bin/mm-qomx-idec-test
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/mm-qomx-ienc-test:$(TARGET_COPY_OUT_VENDOR)/bin/mm-qomx-ienc-test
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/mm-vidc-omx-test:$(TARGET_COPY_OUT_VENDOR)/bin/mm-vidc-omx-test
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/mmid:$(TARGET_COPY_OUT_VENDOR)/bin/mmid
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/msm_irqbalance:$(TARGET_COPY_OUT_VENDOR)/bin/msm_irqbalance
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/netmgrd:$(TARGET_COPY_OUT_VENDOR)/bin/netmgrd
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/pm-proxy:$(TARGET_COPY_OUT_VENDOR)/bin/pm-proxy
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/pm-service:$(TARGET_COPY_OUT_VENDOR)/bin/pm-service
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/port-bridge:$(TARGET_COPY_OUT_VENDOR)/bin/port-bridge
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/power_off_alarm:$(TARGET_COPY_OUT_VENDOR)/bin/power_off_alarm
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/ptt_socket_app:$(TARGET_COPY_OUT_VENDOR)/bin/ptt_socket_app
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/qca6234-service.sh:$(TARGET_COPY_OUT_VENDOR)/bin/qca6234-service.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/qjpeg-dma-test:$(TARGET_COPY_OUT_VENDOR)/bin/qjpeg-dma-test
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/qmi-framework-tests/qmi_test_mt_client_init_instance:$(TARGET_COPY_OUT_VENDOR)/bin/qmi-framework-tests/qmi_test_mt_client_init_instance
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/qmi_simple_ril_test:$(TARGET_COPY_OUT_VENDOR)/bin/qmi_simple_ril_test
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/qseecom_sample_client:$(TARGET_COPY_OUT_VENDOR)/bin/qseecom_sample_client
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/qseecomd:$(TARGET_COPY_OUT_VENDOR)/bin/qseecomd
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/qti:$(TARGET_COPY_OUT_VENDOR)/bin/qti
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/rmt_storage:$(TARGET_COPY_OUT_VENDOR)/bin/rmt_storage
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/secure_ui_sample_client:$(TARGET_COPY_OUT_VENDOR)/bin/secure_ui_sample_client
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/sensors.qcom:$(TARGET_COPY_OUT_VENDOR)/bin/sensors.qcom
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/sh:$(TARGET_COPY_OUT_VENDOR)/bin/sh
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/sigma_dut:$(TARGET_COPY_OUT_VENDOR)/bin/sigma_dut
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/slim_daemon:$(TARGET_COPY_OUT_VENDOR)/bin/slim_daemon
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/ssr_diag:$(TARGET_COPY_OUT_VENDOR)/bin/ssr_diag
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/ssr_setup:$(TARGET_COPY_OUT_VENDOR)/bin/ssr_setup
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/subsystem_ramdump:$(TARGET_COPY_OUT_VENDOR)/bin/subsystem_ramdump
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/tbaseLoader:$(TARGET_COPY_OUT_VENDOR)/bin/tbaseLoader
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/test_diag:$(TARGET_COPY_OUT_VENDOR)/bin/test_diag
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/tftp_server:$(TARGET_COPY_OUT_VENDOR)/bin/tftp_server
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/thermal-engine:$(TARGET_COPY_OUT_VENDOR)/bin/thermal-engine
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/time_daemon:$(TARGET_COPY_OUT_VENDOR)/bin/time_daemon
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/toolbox_vendor:$(TARGET_COPY_OUT_VENDOR)/bin/toolbox_vendor
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/toybox_vendor:$(TARGET_COPY_OUT_VENDOR)/bin/toybox_vendor
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/vendor_cmd_tool:$(TARGET_COPY_OUT_VENDOR)/bin/vendor_cmd_tool
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/wcnss_filter:$(TARGET_COPY_OUT_VENDOR)/bin/wcnss_filter
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/wcnss_service:$(TARGET_COPY_OUT_VENDOR)/bin/wcnss_service
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/wdsdaemon:$(TARGET_COPY_OUT_VENDOR)/bin/wdsdaemon
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/wifidisplayhalservice:$(TARGET_COPY_OUT_VENDOR)/bin/wifidisplayhalservice
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/xtra-daemon:$(TARGET_COPY_OUT_VENDOR)/bin/xtra-daemon
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/xtwifi-client:$(TARGET_COPY_OUT_VENDOR)/bin/xtwifi-client
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/bin/xtwifi-inet-agent:$(TARGET_COPY_OUT_VENDOR)/bin/xtwifi-inet-agent
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/IPACM_cfg.xml:$(TARGET_COPY_OUT_VENDOR)/etc/IPACM_cfg.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/MTP/MTP_Bluetooth_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/MTP_Bluetooth_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/MTP/MTP_General_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/MTP_General_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/MTP/MTP_Global_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/MTP_Global_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/MTP/MTP_Handset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/MTP_Handset_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/MTP/MTP_Hdmi_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/MTP_Hdmi_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/MTP/MTP_Headset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/MTP_Headset_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/MTP/MTP_Speaker_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/MTP_Speaker_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/MTP/MTP_workspaceFile.qwsp:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/MTP_workspaceFile.qwsp
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/MTP/msm8953-tasha-snd-card/MTP_WCD9335_Bluetooth_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/msm8953-tasha-snd-card/MTP_WCD9335_Bluetooth_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/MTP/msm8953-tasha-snd-card/MTP_WCD9335_General_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/msm8953-tasha-snd-card/MTP_WCD9335_General_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/MTP/msm8953-tasha-snd-card/MTP_WCD9335_Global_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/msm8953-tasha-snd-card/MTP_WCD9335_Global_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/MTP/msm8953-tasha-snd-card/MTP_WCD9335_Handset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/msm8953-tasha-snd-card/MTP_WCD9335_Handset_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/MTP/msm8953-tasha-snd-card/MTP_WCD9335_Hdmi_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/msm8953-tasha-snd-card/MTP_WCD9335_Hdmi_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/MTP/msm8953-tasha-snd-card/MTP_WCD9335_Headset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/msm8953-tasha-snd-card/MTP_WCD9335_Headset_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/MTP/msm8953-tasha-snd-card/MTP_WCD9335_Speaker_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/msm8953-tasha-snd-card/MTP_WCD9335_Speaker_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/MTP/msm8953-tasha-snd-card/MTP_WCD9335_workspaceFile.qwsp:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/MTP/msm8953-tasha-snd-card/MTP_WCD9335_workspaceFile.qwsp
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/QRD/QRD_Bluetooth_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/QRD/QRD_Bluetooth_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/QRD/QRD_General_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/QRD/QRD_General_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/QRD/QRD_Global_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/QRD/QRD_Global_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/QRD/QRD_Handset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/QRD/QRD_Handset_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/QRD/QRD_Hdmi_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/QRD/QRD_Hdmi_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/QRD/QRD_Headset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/QRD/QRD_Headset_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/QRD/QRD_Speaker_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/QRD/QRD_Speaker_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/QRD/QRD_workspaceFile.qwsp:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/QRD/QRD_workspaceFile.qwsp
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/QRD/msm8953-sku4-snd-card/QRD_SKU4_Bluetooth_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/QRD/msm8953-sku4-snd-card/QRD_SKU4_Bluetooth_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/QRD/msm8953-sku4-snd-card/QRD_SKU4_General_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/QRD/msm8953-sku4-snd-card/QRD_SKU4_General_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/QRD/msm8953-sku4-snd-card/QRD_SKU4_Global_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/QRD/msm8953-sku4-snd-card/QRD_SKU4_Global_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/QRD/msm8953-sku4-snd-card/QRD_SKU4_Handset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/QRD/msm8953-sku4-snd-card/QRD_SKU4_Handset_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/QRD/msm8953-sku4-snd-card/QRD_SKU4_Hdmi_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/QRD/msm8953-sku4-snd-card/QRD_SKU4_Hdmi_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/QRD/msm8953-sku4-snd-card/QRD_SKU4_Headset_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/QRD/msm8953-sku4-snd-card/QRD_SKU4_Headset_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/QRD/msm8953-sku4-snd-card/QRD_SKU4_Speaker_cal.acdb:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/QRD/msm8953-sku4-snd-card/QRD_SKU4_Speaker_cal.acdb
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/acdbdata/QRD/msm8953-sku4-snd-card/QRD_SKU4_workspaceFile.qwsp:$(TARGET_COPY_OUT_VENDOR)/etc/acdbdata/QRD/msm8953-sku4-snd-card/QRD_SKU4_workspaceFile.qwsp
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/apdr.conf:$(TARGET_COPY_OUT_VENDOR)/etc/apdr.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/audio_policy_configuration.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/audio_effects.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/audio_output_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_output_policy.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/audio_platform_info_extcodec.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info_extcodec.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/audio_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/audio_tuning_mixer.txt:$(TARGET_COPY_OUT_VENDOR)/etc/audio_tuning_mixer.txt
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cacert_location.pem:$(TARGET_COPY_OUT_VENDOR)/etc/cacert_location.pem
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/camera_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/camera_config.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/csidtg_camera.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/csidtg_camera.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/csidtg_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/csidtg_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/imx214_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx214_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/imx230_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx230_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/imx230_qc2002_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx230_qc2002_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/imx230_qc2002_with_gyro_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx230_qc2002_with_gyro_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/imx258_bear_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx258_bear_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/imx258_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx258_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/imx258_mono_bear_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx258_mono_bear_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/imx258_mono_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx258_mono_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/imx298_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx298_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/imx298_gt24c64_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx298_gt24c64_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/imx318_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx318_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/imx362_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx362_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/imx362_chromatix_bear.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx362_chromatix_bear.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/imx378_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx378_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/ov13850_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/ov13850_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/ov13850_q13v06k_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/ov13850_q13v06k_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/ov13855_m24c64_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/ov13855_m24c64_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/ov2281_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/ov2281_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/ov2680_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/ov2680_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/ov4688_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/ov4688_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/ov5670_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/ov5670_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/ov5670_f5670bq_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/ov5670_f5670bq_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/ov5695_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/ov5695_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/ov7251_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/ov7251_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/ov8856_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/ov8856_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/ov8858_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/ov8858_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/ov8865_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/ov8865_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/s5k2l7_8953_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/s5k2l7_8953_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/s5k2l7_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/s5k2l7_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/s5k3l8_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/s5k3l8_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/s5k3l8_f3l8yam_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/s5k3l8_f3l8yam_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/s5k3l8_mono_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/s5k3l8_mono_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/s5k3m2xm_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/s5k3m2xm_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/s5k3m2xm_chromatix_bear.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/s5k3m2xm_chromatix_bear.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/s5k3m2xx_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/s5k3m2xx_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/s5k3p3sm_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/s5k3p3sm_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/camera/s5k3p8sp_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/s5k3p8sp_chromatix.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ATT/ATT_profile1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ATT/ATT_profile1.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ATT/ATT_profile2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ATT/ATT_profile2.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ATT/ATT_profile3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ATT/ATT_profile3.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ATT/ATT_profile4.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ATT/ATT_profile4.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ATT/ATT_profile5.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ATT/ATT_profile5.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ATT/ATT_profile6.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ATT/ATT_profile6.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ROW/ROW_profile1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ROW/ROW_profile1.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ROW/ROW_profile15.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ROW/ROW_profile15.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ROW/ROW_profile16.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ROW/ROW_profile16.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ROW/ROW_profile17.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ROW/ROW_profile17.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ROW/ROW_profile18.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ROW/ROW_profile18.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ROW/ROW_profile19.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ROW/ROW_profile19.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ROW/ROW_profile2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ROW/ROW_profile2.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ROW/ROW_profile20.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ROW/ROW_profile20.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ROW/ROW_profile21.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ROW/ROW_profile21.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ROW/ROW_profile3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ROW/ROW_profile3.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ROW/ROW_profile32.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ROW/ROW_profile32.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ROW/ROW_profile4.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ROW/ROW_profile4.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ROW/ROW_profile5.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ROW/ROW_profile5.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ROW/ROW_profile6.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ROW/ROW_profile6.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/ROW/ROW_profile7.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/ROW/ROW_profile7.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/VZW/VZW_profile1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/VZW/VZW_profile1.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/VZW/VZW_profile2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/VZW/VZW_profile2.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/VZW/VZW_profile3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/VZW/VZW_profile3.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/VZW/VZW_profile4.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/VZW/VZW_profile4.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/VZW/VZW_profile5.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/VZW/VZW_profile5.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/cne/wqeclient/VZW/VZW_profile6.xml:$(TARGET_COPY_OUT_VENDOR)/etc/cne/wqeclient/VZW/VZW_profile6.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/data/dsi_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/data/dsi_config.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/data/netmgr_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/data/netmgr_config.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/drc/drc_cfg_5.1.txt:$(TARGET_COPY_OUT_VENDOR)/etc/drc/drc_cfg_5.1.txt
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/drc/drc_cfg_AZ.txt:$(TARGET_COPY_OUT_VENDOR)/etc/drc/drc_cfg_AZ.txt
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/flp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/flp.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/ftm_test_config:$(TARGET_COPY_OUT_VENDOR)/etc/ftm_test_config
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/ftm_test_config_msm8953-sku3-tasha-snd-card:$(TARGET_COPY_OUT_VENDOR)/etc/ftm_test_config_msm8953-sku3-tasha-snd-card
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/ftm_test_config_msm8953-sku4-snd-card:$(TARGET_COPY_OUT_VENDOR)/etc/ftm_test_config_msm8953-sku4-snd-card
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/ftm_test_config_mtp:$(TARGET_COPY_OUT_VENDOR)/etc/ftm_test_config_mtp
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/ftm_test_config_wcd9335:$(TARGET_COPY_OUT_VENDOR)/etc/ftm_test_config_wcd9335
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/gps.conf:$(TARGET_COPY_OUT_VENDOR)/etc/gps.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/hbtp/hbtpcfg.dat:$(TARGET_COPY_OUT_VENDOR)/etc/hbtp/hbtpcfg.dat
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/hbtp/hbtpcfg2.dat:$(TARGET_COPY_OUT_VENDOR)/etc/hbtp/hbtpcfg2.dat
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/hbtp/hbtpcfg_msm8953_800s_fhd.dat:$(TARGET_COPY_OUT_VENDOR)/etc/hbtp/hbtpcfg_msm8953_800s_fhd.dat
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/hbtp/qtc800h.bin:$(TARGET_COPY_OUT_VENDOR)/etc/hbtp/qtc800h.bin
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/hbtp/qtc800s_dsp.bin:$(TARGET_COPY_OUT_VENDOR)/etc/hbtp/qtc800s_dsp.bin
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/hbtp/qtc800s_msm8937.bin:$(TARGET_COPY_OUT_VENDOR)/etc/hbtp/qtc800s_msm8937.bin
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/android.hardware.bluetooth@1.0-service-qti.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.bluetooth@1.0-service-qti.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/android.hardware.camera.provider@2.4-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.camera.provider@2.4-service.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/android.hardware.cas@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.cas@1.0-service.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/android.hardware.configstore@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.configstore@1.0-service.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/android.hardware.drm@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.drm@1.0-service.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/android.hardware.gatekeeper@1.0-service-qti.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.gatekeeper@1.0-service-qti.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/android.hardware.media.omx@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ms600_disabled/omx-service.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/android.hardware.wifi@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.wifi@1.0-service.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/com.qualcomm.qti.wifidisplayhal@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/com.qualcomm.qti.wifidisplayhal@1.0-service.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/hostapd.android.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hostapd.android.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/hw/init.msm.usb.configfs.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.msm.usb.configfs.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/hw/init.qcom.factory.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.qcom.factory.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/hw/init.qcom.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.qcom.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/hw/init.qcom.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.qcom.usb.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/hw/init.target.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.target.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/rild.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/rild.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/vendor.display.color@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.display.color@1.0-service.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/vendor.qti.esepowermanager@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.qti.esepowermanager@1.0-service.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/vendor.qti.gnss@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.qti.gnss@1.0-service.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/vendor.qti.hardware.alarm@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.qti.hardware.alarm@1.0-service.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/vendor.qti.hardware.factory@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.qti.hardware.factory@1.0-service.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/vendor.qti.hardware.perf@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.qti.hardware.perf@1.0-service.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/vendor.qti.hardware.qdutils_disp@1.0-service-qti.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.qti.hardware.qdutils_disp@1.0-service-qti.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/vendor.qti.hardware.qteeconnector@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.qti.hardware.qteeconnector@1.0-service.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/init/vendor.qti.hardware.tui_comm@1.0-service-qti.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.qti.hardware.tui_comm@1.0-service-qti.rc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/izat.conf:$(TARGET_COPY_OUT_VENDOR)/etc/izat.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/lowi.conf:$(TARGET_COPY_OUT_VENDOR)/etc/lowi.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/media_codecs_8953.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_8953.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/media_codecs_8953_v1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_8953_v1.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/media_codecs_google_video_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video_le.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/media_codecs_performance_8953.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance_8953.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/media_codecs_performance_8953_v1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance_8953_v1.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/media_codecs_vendor_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_vendor_audio.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/media_profiles_8953_v1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_8953_v1.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/media_profiles_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_vendor.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/mixer_paths_mtp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_mtp.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/mixer_paths_qrd_sku3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_qrd_sku3.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/mixer_paths_qrd_skuh.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_qrd_skuh.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/mixer_paths_qrd_skuhf.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_qrd_skuhf.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/mixer_paths_qrd_skui.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_qrd_skui.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/mixer_paths_qrd_skum.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_qrd_skum.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/mixer_paths_qrd_skun.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_qrd_skun.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/mixer_paths_skuk.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_skuk.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/mixer_paths_wcd9306.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_wcd9306.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/mixer_paths_wcd9326.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_wcd9326.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/mixer_paths_wcd9330.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_wcd9330.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/mixer_paths_wcd9335.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_wcd9335.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/mkshrc:$(TARGET_COPY_OUT_VENDOR)/etc/mkshrc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/msm_irqbalance_little_big.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance_little_big.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/perf/gamedwhitelist.xml:$(TARGET_COPY_OUT_VENDOR)/etc/perf/gamedwhitelist.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/perf/perfboostsconfig.xml:$(TARGET_COPY_OUT_VENDOR)/etc/perf/perfboostsconfig.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.light.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.telephony.cdma.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.cdma.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute-0.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.vulkan.level-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-0.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.vulkan.version-1_0_3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_0_3.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/permissions/vendor.qti.hardware.factory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/vendor.qti.hardware.factory.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/qti-logkit/IMS.dmc:$(TARGET_COPY_OUT_VENDOR)/etc/qti-logkit/IMS.dmc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/qti-logkit/audiobasic.dmc:$(TARGET_COPY_OUT_VENDOR)/etc/qti-logkit/audiobasic.dmc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/qti-logkit/gnsslocationlogging.dmc:$(TARGET_COPY_OUT_VENDOR)/etc/qti-logkit/gnsslocationlogging.dmc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/qti-logkit/goldenlogmask.dmc:$(TARGET_COPY_OUT_VENDOR)/etc/qti-logkit/goldenlogmask.dmc
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/qti-logkit/qti_logkit_command.xml:$(TARGET_COPY_OUT_VENDOR)/etc/qti-logkit/qti_logkit_command.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/qti-logkit/qti_logkit_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/qti-logkit/qti_logkit_config.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/qti-logkit/scenarios/IMS.png:$(TARGET_COPY_OUT_VENDOR)/etc/qti-logkit/scenarios/IMS.png
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/qti-logkit/scenarios/bluetooth.png:$(TARGET_COPY_OUT_VENDOR)/etc/qti-logkit/scenarios/bluetooth.png
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/qti-logkit/scenarios/default.png:$(TARGET_COPY_OUT_VENDOR)/etc/qti-logkit/scenarios/default.png
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/qvr/ov7251_640x480_cam_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/qvr/ov7251_640x480_cam_config.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/qvr/ov9282_stereo_1280x400_cam_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/qvr/ov9282_stereo_1280x400_cam_config.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/qvr/ov9282_stereo_2560x800_cam_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/qvr/ov9282_stereo_2560x800_cam_config.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/qvr/qvrservice_6dof_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/qvr/qvrservice_6dof_config.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/qvr/qvrservice_6dof_config_stereo.xml:$(TARGET_COPY_OUT_VENDOR)/etc/qvr/qvrservice_6dof_config_stereo.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/qvr/qvrservice_config.txt:$(TARGET_COPY_OUT_VENDOR)/etc/qvr/qvrservice_config.txt
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/sap.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sap.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/sec_config:$(TARGET_COPY_OUT_VENDOR)/etc/sec_config
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/seccomp_policy/configstore@1.0.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/configstore@1.0.policy
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/seccomp_policy/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/seccomp_policy/mediaextractor.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/selinux/nonplat_hwservice_contexts:$(TARGET_COPY_OUT_VENDOR)/etc/selinux/nonplat_hwservice_contexts
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/selinux/nonplat_mac_permissions.xml:$(TARGET_COPY_OUT_VENDOR)/etc/selinux/nonplat_mac_permissions.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/selinux/nonplat_property_contexts:$(TARGET_COPY_OUT_VENDOR)/etc/selinux/nonplat_property_contexts
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/selinux/nonplat_seapp_contexts:$(TARGET_COPY_OUT_VENDOR)/etc/selinux/nonplat_seapp_contexts
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/selinux/nonplat_sepolicy.cil:$(TARGET_COPY_OUT_VENDOR)/etc/selinux/nonplat_sepolicy.cil
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/selinux/nonplat_service_contexts:$(TARGET_COPY_OUT_VENDOR)/etc/selinux/nonplat_service_contexts
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/selinux/plat_sepolicy_vers.txt:$(TARGET_COPY_OUT_VENDOR)/etc/selinux/plat_sepolicy_vers.txt
#MS600-NOPRECOMPILED PRODUCT_COPY_FILES += \
#MS600-NOPRECOMPILED     $(LOCAL_VENDOR_PATH)/etc/selinux/precompiled_sepolicy:$(TARGET_COPY_OUT_VENDOR)/etc/selinux/precompiled_sepolicy
#MS600-NOPRECOMPILED PRODUCT_COPY_FILES += \
#MS600-NOPRECOMPILED     $(LOCAL_VENDOR_PATH)/etc/selinux/precompiled_sepolicy.plat_and_mapping.sha256:$(TARGET_COPY_OUT_VENDOR)/etc/selinux/precompiled_sepolicy.plat_and_mapping.sha256
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/selinux/vndservice_contexts:$(TARGET_COPY_OUT_VENDOR)/etc/selinux/vndservice_contexts
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/sensors/sensor_def_qcomdev.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/sensor_def_qcomdev.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/sound_trigger_mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_mixer_paths.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/sound_trigger_mixer_paths_wcd9306.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_mixer_paths_wcd9306.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/sound_trigger_mixer_paths_wcd9330.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_mixer_paths_wcd9330.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/sound_trigger_mixer_paths_wcd9335.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_mixer_paths_wcd9335.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/sound_trigger_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_platform_info.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/surround_sound_3mic/surround_sound_rec_5.1.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/surround_sound_3mic/surround_sound_rec_5.1.cfg
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/surround_sound_3mic/surround_sound_rec_AZ.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/surround_sound_3mic/surround_sound_rec_AZ.cfg
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/thermal-engine.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/wifi/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/wifi/wpa_supplicant.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/xtra_root_cert.pem:$(TARGET_COPY_OUT_VENDOR)/etc/xtra_root_cert.pem
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/etc/xtwifi.conf:$(TARGET_COPY_OUT_VENDOR)/etc/xtwifi.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a225_pfp.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/a225_pfp.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a225_pm4.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/a225_pm4.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a225p5_pm4.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/a225p5_pm4.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a300_pfp.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/a300_pfp.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a300_pm4.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/a300_pm4.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a330_pfp.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/a330_pfp.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a330_pm4.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/a330_pm4.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a420_pfp.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/a420_pfp.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a420_pm4.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/a420_pm4.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a506_zap.b00:$(TARGET_COPY_OUT_VENDOR)/firmware/a506_zap.b00
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a506_zap.b01:$(TARGET_COPY_OUT_VENDOR)/firmware/a506_zap.b01
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a506_zap.b02:$(TARGET_COPY_OUT_VENDOR)/firmware/a506_zap.b02
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a506_zap.elf:$(TARGET_COPY_OUT_VENDOR)/firmware/a506_zap.elf
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a506_zap.mdt:$(TARGET_COPY_OUT_VENDOR)/firmware/a506_zap.mdt
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a530_gpmu.fw2:$(TARGET_COPY_OUT_VENDOR)/firmware/a530_gpmu.fw2
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a530_pfp.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/a530_pfp.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a530_pm4.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/a530_pm4.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a530v1_pfp.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/a530v1_pfp.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a530v1_pm4.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/a530v1_pm4.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a530v2_seq.fw2:$(TARGET_COPY_OUT_VENDOR)/firmware/a530v2_seq.fw2
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a530v3_gpmu.fw2:$(TARGET_COPY_OUT_VENDOR)/firmware/a530v3_gpmu.fw2
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a530v3_seq.fw2:$(TARGET_COPY_OUT_VENDOR)/firmware/a530v3_seq.fw2
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/a540_gpmu.fw2:$(TARGET_COPY_OUT_VENDOR)/firmware/a540_gpmu.fw2
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/cpp_firmware_v1_10_0.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/cpp_firmware_v1_10_0.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/cpp_firmware_v1_12_0.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/cpp_firmware_v1_12_0.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/cpp_firmware_v1_1_1.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/cpp_firmware_v1_1_1.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/cpp_firmware_v1_1_6.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/cpp_firmware_v1_1_6.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/cpp_firmware_v1_2_0.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/cpp_firmware_v1_2_0.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/cpp_firmware_v1_4_0.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/cpp_firmware_v1_4_0.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/cpp_firmware_v1_5_0.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/cpp_firmware_v1_5_0.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/cpp_firmware_v1_5_1.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/cpp_firmware_v1_5_1.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/cpp_firmware_v1_5_2.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/cpp_firmware_v1_5_2.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/cpp_firmware_v1_6_0.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/cpp_firmware_v1_6_0.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/cpp_firmware_v1_8_0.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/cpp_firmware_v1_8_0.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/leia_pfp_470.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/leia_pfp_470.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/firmware/leia_pm4_470.fw:$(TARGET_COPY_OUT_VENDOR)/firmware/leia_pm4_470.fw
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/android.hidl.base@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/android.hidl.base@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/camera.device@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/camera.device@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/camera.device@3.2-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/camera.device@3.2-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/camera.device@3.3-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/camera.device@3.3-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/com.qualcomm.qti.ant@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/com.qualcomm.qti.ant@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/com.qualcomm.qti.bluetooth_audio@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/com.qualcomm.qti.bluetooth_audio@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/com.qualcomm.qti.dpm.api@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/com.qualcomm.qti.dpm.api@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/com.qualcomm.qti.imscmservice@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/com.qualcomm.qti.imscmservice@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/com.qualcomm.qti.imscmservice@1.1_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/com.qualcomm.qti.imscmservice@1.1_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/com.qualcomm.qti.wifidisplayhal@1.0-halimpl.so:$(TARGET_COPY_OUT_VENDOR)/lib/com.qualcomm.qti.wifidisplayhal@1.0-halimpl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/com.qualcomm.qti.wifidisplayhal@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/com.qualcomm.qti.wifidisplayhal@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/com.qualcomm.qti.wifidisplayhal@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/com.qualcomm.qti.wifidisplayhal@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/com.quicinc.cne.api@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/com.quicinc.cne.api@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/com.quicinc.cne.constants@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/com.quicinc.cne.constants@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/com.quicinc.cne.constants@2.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/com.quicinc.cne.constants@2.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/com.quicinc.cne.server@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/com.quicinc.cne.server@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/com.quicinc.cne.server@2.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/com.quicinc.cne.server@2.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/egl/eglSubDriverAndroid.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/eglSubDriverAndroid.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/egl/libEGL_adreno.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libEGL_adreno.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/egl/libGLESv1_CM_adreno.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libGLESv1_CM_adreno.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/egl/libGLESv2_adreno.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libGLESv2_adreno.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/egl/libQTapGLES.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libQTapGLES.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/egl/libq3dtools_adreno.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libq3dtools_adreno.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/egl/libq3dtools_esx.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libq3dtools_esx.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/activity_recognition.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/activity_recognition.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/android.hardware.bluetooth@1.0-impl-qti.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/android.hardware.bluetooth@1.0-impl-qti.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/android.hardware.camera.provider@2.4-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/android.hardware.camera.provider@2.4-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/android.hardware.drm@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/android.hardware.drm@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/android.hardware.gatekeeper@1.0-impl-qti.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/android.hardware.gatekeeper@1.0-impl-qti.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/android.hardware.gnss@1.0-impl-qti.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/android.hardware.gnss@1.0-impl-qti.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/android.hardware.renderscript@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/android.hardware.renderscript@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/audio.primary.default.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/audio.primary.default.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/audio.primary.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/audio.primary.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/audio.r_submix.default.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/audio.r_submix.default.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/audio.usb.default.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/audio.usb.default.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/camera.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/camera.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/com.qualcomm.qti.ant@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/com.qualcomm.qti.ant@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/gatekeeper.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/gatekeeper.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/gralloc.default.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/gralloc.default.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/keystore.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/keystore.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/lights.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/lights.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/local_time.default.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/local_time.default.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/power.default.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/power.default.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/power.qcom.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/power.qcom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/sound_trigger.primary.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/sound_trigger.primary.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/thermal.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/thermal.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/vendor.qti.esepowermanager@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/vendor.qti.esepowermanager@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/vendor.qti.gnss@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/vendor.qti.gnss@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/vendor.qti.hardware.alarm@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/vendor.qti.hardware.alarm@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/vendor.qti.hardware.factory@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/vendor.qti.hardware.factory@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/vendor.qti.hardware.fm@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/vendor.qti.hardware.fm@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/vendor.qti.hardware.iop@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/vendor.qti.hardware.iop@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/vendor.qti.hardware.qteeconnector@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/vendor.qti.hardware.qteeconnector@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/vibrator.default.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/vibrator.default.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/hw/vulkan.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/vulkan.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/lib-dplmedia.so:$(TARGET_COPY_OUT_VENDOR)/lib/lib-dplmedia.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/lib-imsSDP.so:$(TARGET_COPY_OUT_VENDOR)/lib/lib-imsSDP.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/lib-imscmservice.so:$(TARGET_COPY_OUT_VENDOR)/lib/lib-imscmservice.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/lib-imsdpl.so:$(TARGET_COPY_OUT_VENDOR)/lib/lib-imsdpl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/lib-imsqimf.so:$(TARGET_COPY_OUT_VENDOR)/lib/lib-imsqimf.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/lib-imsrcs-v2.so:$(TARGET_COPY_OUT_VENDOR)/lib/lib-imsrcs-v2.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/lib-imsxml.so:$(TARGET_COPY_OUT_VENDOR)/lib/lib-imsxml.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/lib-rtpcommon.so:$(TARGET_COPY_OUT_VENDOR)/lib/lib-rtpcommon.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/lib-rtpcore.so:$(TARGET_COPY_OUT_VENDOR)/lib/lib-rtpcore.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/lib-rtpdaemoninterface.so:$(TARGET_COPY_OUT_VENDOR)/lib/lib-rtpdaemoninterface.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/lib-rtpsl.so:$(TARGET_COPY_OUT_VENDOR)/lib/lib-rtpsl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/lib-siputility.so:$(TARGET_COPY_OUT_VENDOR)/lib/lib-siputility.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/lib-uceservice.so:$(TARGET_COPY_OUT_VENDOR)/lib/lib-uceservice.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libAlacSwDec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libAlacSwDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libApeSwDec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libApeSwDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libC2D2.so:$(TARGET_COPY_OUT_VENDOR)/lib/libC2D2.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libCB.so:$(TARGET_COPY_OUT_VENDOR)/lib/libCB.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libDRPlugin.so:$(TARGET_COPY_OUT_VENDOR)/lib/libDRPlugin.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libFIDOKeyProvisioning.so:$(TARGET_COPY_OUT_VENDOR)/lib/libFIDOKeyProvisioning.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libFidoCrypto_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/libFidoCrypto_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libFlacSwDec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libFlacSwDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libGPTEE_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/libGPTEE_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libGPreqcancel.so:$(TARGET_COPY_OUT_VENDOR)/lib/libGPreqcancel.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libGPreqcancel_svc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libGPreqcancel_svc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libI420colorconvert.so:$(TARGET_COPY_OUT_VENDOR)/lib/libI420colorconvert.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxAacDec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxAacDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxAacEnc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxAacEnc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxAlacDec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxAlacDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxAlacDecSw.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxAlacDecSw.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxAmrDec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxAmrDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxAmrEnc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxAmrEnc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxAmrwbplusDec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxAmrwbplusDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxApeDec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxApeDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxApeDecSw.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxApeDecSw.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxCore.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxCore.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxDsdDec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxDsdDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxEvrcDec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxEvrcDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxEvrcEnc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxEvrcEnc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxG711Dec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxG711Dec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxG711Enc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxG711Enc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxQcelp13Dec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxQcelp13Dec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxQcelp13Enc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxQcelp13Enc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxVdec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxVdec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxVenc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxVenc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxVideoDSMode.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxVideoDSMode.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxVpp.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxVpp.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOmxWmaDec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOmxWmaDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libOpenCL.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOpenCL.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libQSEEComAPI.so:$(TARGET_COPY_OUT_VENDOR)/lib/libQSEEComAPI.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libQTEEConnector_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/libQTEEConnector_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libRSDriver_adreno.so:$(TARGET_COPY_OUT_VENDOR)/lib/libRSDriver_adreno.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libSecureUILib.so:$(TARGET_COPY_OUT_VENDOR)/lib/libSecureUILib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libStDrvInt.so:$(TARGET_COPY_OUT_VENDOR)/lib/libStDrvInt.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libSubSystemShutdown.so:$(TARGET_COPY_OUT_VENDOR)/lib/libSubSystemShutdown.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libUBWC.so:$(TARGET_COPY_OUT_VENDOR)/lib/libUBWC.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libUserAgent.so:$(TARGET_COPY_OUT_VENDOR)/lib/libUserAgent.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/lib_drplugin_server.so:$(TARGET_COPY_OUT_VENDOR)/lib/lib_drplugin_server.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/lib_remote_simlock.so:$(TARGET_COPY_OUT_VENDOR)/lib/lib_remote_simlock.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libacdb-fts.so:$(TARGET_COPY_OUT_VENDOR)/lib/libacdb-fts.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libacdbloader.so:$(TARGET_COPY_OUT_VENDOR)/lib/libacdbloader.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libacdbmapper.so:$(TARGET_COPY_OUT_VENDOR)/lib/libacdbmapper.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libacdbrtac.so:$(TARGET_COPY_OUT_VENDOR)/lib/libacdbrtac.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_ad5816g.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_ad5816g.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_ad5823.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_ad5823.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_ak7345.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_ak7345.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_bu64244gwz.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_bu64244gwz.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_bu64297.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_bu64297.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_dw9714.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_dw9714.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_dw9714v_m24c64.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_dw9714v_m24c64.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_dw9716.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_dw9716.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_dw9761b.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_dw9761b.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_dw9763.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_dw9763.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_lc898122.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_lc898122.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_lc898212xd_qc2002.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_lc898212xd_qc2002.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_pseudo.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_pseudo.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libactuator_rohm_bu64243gwz.so:$(TARGET_COPY_OUT_VENDOR)/lib/libactuator_rohm_bu64243gwz.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libadiertac.so:$(TARGET_COPY_OUT_VENDOR)/lib/libadiertac.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libadm.so:$(TARGET_COPY_OUT_VENDOR)/lib/libadm.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libadpcmdec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libadpcmdec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libadreno_utils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libadreno_utils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libadsp_default_listener.so:$(TARGET_COPY_OUT_VENDOR)/lib/libadsp_default_listener.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libadsprpc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libadsprpc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libalarmservice_jni.so:$(TARGET_COPY_OUT_VENDOR)/lib/libalarmservice_jni.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libalsautils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libalsautils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libaudcal.so:$(TARGET_COPY_OUT_VENDOR)/lib/libaudcal.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libaudio_log_utils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libaudio_log_utils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libaudioalsa.so:$(TARGET_COPY_OUT_VENDOR)/lib/libaudioalsa.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libaudioparsers.so:$(TARGET_COPY_OUT_VENDOR)/lib/libaudioparsers.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libbase64.so:$(TARGET_COPY_OUT_VENDOR)/lib/libbase64.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libbccQTI.so:$(TARGET_COPY_OUT_VENDOR)/lib/libbccQTI.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libbt-hidlclient.so:$(TARGET_COPY_OUT_VENDOR)/lib/libbt-hidlclient.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libbt-vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/libbt-vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libbthost_if.so:$(TARGET_COPY_OUT_VENDOR)/lib/libbthost_if.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libbtnv.so:$(TARGET_COPY_OUT_VENDOR)/lib/libbtnv.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libc2d30-a3xx.so:$(TARGET_COPY_OUT_VENDOR)/lib/libc2d30-a3xx.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libc2d30-a4xx.so:$(TARGET_COPY_OUT_VENDOR)/lib/libc2d30-a4xx.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libc2d30-a5xx.so:$(TARGET_COPY_OUT_VENDOR)/lib/libc2d30-a5xx.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libc2d30_bltlib.so:$(TARGET_COPY_OUT_VENDOR)/lib/libc2d30_bltlib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libc2dcolorconvert.so:$(TARGET_COPY_OUT_VENDOR)/lib/libc2dcolorconvert.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libcdsprpc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libcdsprpc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromaflash.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromaflash.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_csidtg_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_csidtg_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_csidtg_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_csidtg_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_csidtg_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_csidtg_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_csidtg_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_csidtg_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_csidtg_zsl_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_csidtg_zsl_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_4k_preview_lc898122.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_4k_preview_lc898122.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_4k_video_lc898122.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_4k_video_lc898122.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_cpp_snapshot_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_cpp_snapshot_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_cpp_video_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_cpp_video_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_default_preview_lc898122.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_default_preview_lc898122.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_default_video_lc898122.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_default_video_lc898122.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_hdr_snapshot_lc898122.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_hdr_snapshot_lc898122.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_hdr_video_lc898122.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_hdr_video_lc898122.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_hfr_120_lc898122.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_hfr_120_lc898122.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_hfr_60_lc898122.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_hfr_60_lc898122.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_hfr_90_lc898122.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_hfr_90_lc898122.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_snapshot_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_snapshot_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_video_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_video_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_zsl_preview_lc898122.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_zsl_preview_lc898122.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx214_zsl_video_lc898122.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx214_zsl_video_lc898122.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_1080p_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_1080p_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_1080p_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_1080p_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_4k_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_4k_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_4k_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_4k_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_cpp_hfr_240.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_cpp_hfr_240.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_cpp_raw_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_cpp_raw_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_cpp_snapshot_downscale.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_cpp_snapshot_downscale.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_cpp_snapshot_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_cpp_snapshot_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_cpp_snapshot_upscale.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_cpp_snapshot_upscale.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_cpp_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_cpp_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_cpp_video_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_cpp_video_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_default_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_default_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_default_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_default_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_hdr_snapshot_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_hdr_snapshot_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_hdr_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_hdr_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_hfr_120_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_hfr_120_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_hfr_240.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_hfr_240.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_hfr_240_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_hfr_240_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_hfr_60_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_hfr_60_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_hfr_90_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_hfr_90_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_1080p_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_1080p_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_1080p_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_1080p_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_4k_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_4k_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_4k_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_4k_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_cpp_hfr_240.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_cpp_hfr_240.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_cpp_snapshot_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_cpp_snapshot_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_cpp_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_cpp_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_cpp_video_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_cpp_video_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_default_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_default_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_default_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_default_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_hdr_snapshot_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_hdr_snapshot_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_hdr_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_hdr_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_hfr_120_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_hfr_120_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_hfr_240.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_hfr_240.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_hfr_240_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_hfr_240_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_hfr_60_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_hfr_60_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_hfr_90_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_hfr_90_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_snapshot_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_snapshot_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_video_16M_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_video_16M_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_video_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_video_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_1080p_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_1080p_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_1080p_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_1080p_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_4k_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_4k_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_4k_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_4k_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_hfr_240.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_hfr_240.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_snapshot_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_snapshot_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_video_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_cpp_video_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_default_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_default_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_default_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_default_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_hdr_snapshot_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_hdr_snapshot_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_hdr_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_hdr_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_hfr_120_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_hfr_120_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_hfr_240.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_hfr_240.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_hfr_240_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_hfr_240_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_hfr_60_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_hfr_60_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_hfr_90_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_hfr_90_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_snapshot_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_snapshot_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_video_16M_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_video_16M_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_video_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_video_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_zsl_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_zsl_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_with_gyro_zsl_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_with_gyro_zsl_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_zsl_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_zsl_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_qc2002_zsl_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_qc2002_zsl_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_raw_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_raw_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_raw_hdr_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_raw_hdr_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_snapshot_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_snapshot_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_video_16M_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_video_16M_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_video_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_video_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_zsl_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_zsl_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx230_zsl_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx230_zsl_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_4k_preview_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_4k_preview_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_4k_video_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_4k_video_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_4k_preview_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_4k_preview_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_4k_video_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_4k_video_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_cpp_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_cpp_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_default_preview_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_default_preview_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_default_video_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_default_video_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_hfr_120_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_hfr_120_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_hfr_60_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_hfr_60_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_hfr_90_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_hfr_90_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_zsl_preview_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_zsl_preview_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_bear_zsl_video_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_bear_zsl_video_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_cpp_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_cpp_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_default_preview_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_default_preview_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_default_video_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_default_video_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_hfr_120_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_hfr_120_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_hfr_60_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_hfr_60_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_hfr_90_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_hfr_90_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_4k_preview_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_4k_preview_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_4k_video_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_4k_video_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_4k_preview_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_4k_preview_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_4k_video_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_4k_video_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_cpp_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_cpp_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_default_preview_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_default_preview_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_default_video_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_default_video_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_hfr_120_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_hfr_120_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_hfr_60_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_hfr_60_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_hfr_90_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_hfr_90_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_zsl_preview_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_zsl_preview_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_bear_zsl_video_lc898217xc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_bear_zsl_video_lc898217xc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_cpp_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_cpp_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_default_preview_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_default_preview_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_default_video_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_default_video_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_hfr_120_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_hfr_120_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_hfr_60_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_hfr_60_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_hfr_90_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_hfr_90_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_zsl_preview_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_zsl_preview_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_mono_zsl_video_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_mono_zsl_video_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_zsl_preview_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_zsl_preview_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx258_zsl_video_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx258_zsl_video_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_4K_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_4K_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_4K_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_4K_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_cpp_snapshot_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_cpp_snapshot_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_cpp_video_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_cpp_video_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_default_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_default_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_4K_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_4K_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_4K_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_4K_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_cpp_snapshot_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_cpp_snapshot_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_cpp_video_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_cpp_video_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_default_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_default_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_hdr_snapshot_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_hdr_snapshot_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_hdr_video_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_hdr_video_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_hfr_120_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_hfr_120_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_hfr_60_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_hfr_60_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_hfr_90_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_hfr_90_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_snapshot_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_snapshot_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_video_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_video_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_zsl_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_zsl_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_gt24c64_zsl_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_gt24c64_zsl_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_hdr_snapshot_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_hdr_snapshot_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_hdr_video_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_hdr_video_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_hfr_120_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_hfr_120_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_hfr_60_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_hfr_60_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_hfr_90_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_hfr_90_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_snapshot_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_snapshot_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_video_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_video_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_zsl_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_zsl_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx298_zsl_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx298_zsl_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_1080p_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_1080p_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_1080p_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_1080p_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_4k_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_4k_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_4k_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_4k_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_cpp_hfr_240.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_cpp_hfr_240.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_cpp_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_cpp_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_fullsize_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_fullsize_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_fullsize_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_fullsize_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_hfr_120_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_hfr_120_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_hfr_240.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_hfr_240.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_hfr_240_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_hfr_240_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_hfr_60_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_hfr_60_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx318_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx318_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_1080p_preview_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_1080p_preview_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_1080p_preview_3a_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_1080p_preview_3a_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_1080p_video_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_1080p_video_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_1080p_video_3a_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_1080p_video_3a_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_4k_preview_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_4k_preview_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_4k_preview_3a_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_4k_preview_3a_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_4k_video_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_4k_video_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_4k_video_3a_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_4k_video_3a_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_common_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_common_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_hfr_120_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_hfr_120_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_hfr_240.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_hfr_240.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_hfr_240_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_hfr_240_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_hfr_60_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_hfr_60_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_liveshot_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_liveshot_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_preview_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_preview_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_snapshot_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_snapshot_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_snapshot_downscale_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_snapshot_downscale_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_snapshot_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_snapshot_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_snapshot_hdr_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_snapshot_hdr_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_snapshot_upscale_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_snapshot_upscale_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_video_4k_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_video_4k_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_video_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_video_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_video_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_video_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_cpp_video_hdr_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_cpp_video_hdr_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_default_preview_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_default_preview_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_default_preview_3a_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_default_preview_3a_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_default_video_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_default_video_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_default_video_3a_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_default_video_3a_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_default_video_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_default_video_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_fullsize_preview_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_fullsize_preview_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_fullsize_preview_3a_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_fullsize_preview_3a_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_fullsize_video_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_fullsize_video_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_fullsize_video_3a_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_fullsize_video_3a_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_hdr_snapshot_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_hdr_snapshot_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_hdr_snapshot_3a_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_hdr_snapshot_3a_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_hdr_video_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_hdr_video_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_hdr_video_3a_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_hdr_video_3a_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_hfr_120_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_hfr_120_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_hfr_120_3a_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_hfr_120_3a_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_hfr_120_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_hfr_120_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_hfr_240.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_hfr_240.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_hfr_240_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_hfr_240_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_hfr_240_3a_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_hfr_240_3a_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_hfr_240_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_hfr_240_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_hfr_60_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_hfr_60_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_hfr_60_3a_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_hfr_60_3a_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_hfr_60_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_hfr_60_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_postproc_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_postproc_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_preview_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_preview_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_snapshot_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_snapshot_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_snapshot_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_snapshot_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_snapshot_hdr_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_snapshot_hdr_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_video_4k_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_video_4k_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_video_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_video_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx362_video_hdr_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx362_video_hdr_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_4K_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_4K_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_4K_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_4K_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_cpp_hfr_240.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_cpp_hfr_240.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_cpp_snapshot_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_cpp_snapshot_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_cpp_video_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_cpp_video_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_default_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_default_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_hdr_snapshot_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_hdr_snapshot_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_hdr_video_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_hdr_video_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_hfr_120_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_hfr_120_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_hfr_240.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_hfr_240.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_hfr_240_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_hfr_240_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_hfr_60_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_hfr_60_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_hfr_90_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_hfr_90_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_snapshot_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_snapshot_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_video_hdr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_video_hdr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_zsl_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_zsl_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_imx378_zsl_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_imx378_zsl_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_cpp_ds_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_cpp_ds_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_cpp_us_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_cpp_us_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_cpp_video_full.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_cpp_video_full.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_default_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_default_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_default_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_default_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_hfr_120_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_hfr_120_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_hfr_60_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_hfr_60_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_hfr_90_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_hfr_90_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_cpp_ds_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_cpp_ds_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_cpp_us_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_cpp_us_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_cpp_video_full.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_cpp_video_full.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_default_preview_bu64297.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_default_preview_bu64297.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_default_video_bu64297.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_default_video_bu64297.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_hfr_120_bu64297.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_hfr_120_bu64297.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_hfr_60_bu64297.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_hfr_60_bu64297.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_hfr_90_bu64297.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_hfr_90_bu64297.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_video_full.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_video_full.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_zsl_preview_bu64297.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_zsl_preview_bu64297.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_q13v06k_zsl_video_bu64297.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_q13v06k_zsl_video_bu64297.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_video_full.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_video_full.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_zsl_preview_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_zsl_preview_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13850_zsl_video_lc898212xd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13850_zsl_video_lc898212xd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_default_preview_bu64297.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_default_preview_bu64297.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_default_video_bu64297.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_default_video_bu64297.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_hfr_120_bu64297.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_hfr_120_bu64297.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_hfr_60_bu64297.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_hfr_60_bu64297.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_hfr_90_bu64297.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_hfr_90_bu64297.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_zsl_preview_bu64297.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_zsl_preview_bu64297.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov13855_m24c64_zsl_video_bu64297.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov13855_m24c64_zsl_video_bu64297.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2281_a3_default_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2281_a3_default_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2281_a3_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2281_a3_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2281_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2281_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2281_cpp_ds_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2281_cpp_ds_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2281_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2281_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2281_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2281_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2281_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2281_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2281_cpp_us_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2281_cpp_us_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2281_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2281_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2281_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2281_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2281_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2281_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2281_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2281_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2281_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2281_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2281_zsl_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2281_zsl_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2281_zsl_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2281_zsl_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2680_a3_default_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2680_a3_default_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2680_a3_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2680_a3_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2680_a3_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2680_a3_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2680_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2680_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2680_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2680_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2680_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2680_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2680_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2680_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2680_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2680_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2680_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2680_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2680_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2680_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2680_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2680_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2680_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2680_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2680_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2680_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2680_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2680_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2680_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2680_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov2680_zsl_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov2680_zsl_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_hfr_120_ad5823.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_hfr_120_ad5823.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_hfr_60_ad5823.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_hfr_60_ad5823.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_hfr_90_ad5823.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_hfr_90_ad5823.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_zsl_preview_ad5823.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_zsl_preview_ad5823.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov4688_zsl_video_ad5823.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov4688_zsl_video_ad5823.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_a3_default_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_a3_default_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_a3_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_a3_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_a3_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_a3_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_a3_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_a3_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_a3_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_a3_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_cpp_ds_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_cpp_ds_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_cpp_us_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_cpp_us_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_cpp_video_full.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_cpp_video_full.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_a3_default_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_a3_default_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_a3_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_a3_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_a3_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_a3_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_a3_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_a3_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_a3_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_a3_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_cpp_ds_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_cpp_ds_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_cpp_us_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_cpp_us_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_cpp_video_full.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_cpp_video_full.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_video_full.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_video_full.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_zsl_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_zsl_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_f5670bq_zsl_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_f5670bq_zsl_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_video_full.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_video_full.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_zsl_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_zsl_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5670_zsl_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5670_zsl_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_a3_default_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_a3_default_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_a3_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_a3_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_a3_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_a3_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_a3_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_a3_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_a3_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_a3_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_cpp_ds_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_cpp_ds_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_cpp_us_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_cpp_us_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_cpp_video_full.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_cpp_video_full.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_video_full.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_video_full.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_zsl_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_zsl_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov5695_zsl_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov5695_zsl_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov7251_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov7251_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov7251_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov7251_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov7251_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov7251_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov7251_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov7251_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov7251_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov7251_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov7251_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov7251_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov7251_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov7251_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov7251_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov7251_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov7251_zsl_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov7251_zsl_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov7251_zsl_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov7251_zsl_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_a3_default_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_a3_default_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_a3_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_a3_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_a3_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_a3_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_a3_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_a3_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_a3_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_a3_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_cpp_ds_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_cpp_ds_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_cpp_us_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_cpp_us_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_zsl_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_zsl_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8856_zsl_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8856_zsl_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_a3_default_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_a3_default_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_a3_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_a3_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_a3_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_a3_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_a3_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_a3_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_a3_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_a3_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_cpp_ds_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_cpp_ds_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_cpp_us_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_cpp_us_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_zsl_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_zsl_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8858_zsl_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8858_zsl_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_cpp_ds_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_cpp_ds_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_cpp_us_chromatix.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_cpp_us_chromatix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_cpp_video_full.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_cpp_video_full.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_default_preview_dw9714.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_default_preview_dw9714.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_default_video_dw9714.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_default_video_dw9714.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_hfr_120_dw9714.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_hfr_120_dw9714.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_hfr_60_dw9714.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_hfr_60_dw9714.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_hfr_90_dw9714.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_hfr_90_dw9714.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_video_full.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_video_full.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_zsl_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_zsl_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_ov8865_zsl_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_ov8865_zsl_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_4k_preview_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_4k_preview_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_4k_video_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_4k_video_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_4k_preview_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_4k_preview_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_4k_video_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_4k_video_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_cpp_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_cpp_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_default_preview_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_default_preview_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_default_video_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_default_video_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_hfr_120_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_hfr_120_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_hfr_60_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_hfr_60_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_hfr_90_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_hfr_90_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_zsl_preview_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_zsl_preview_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_8953_zsl_video_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_8953_zsl_video_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_cpp_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_cpp_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_default_preview_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_default_preview_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_default_video_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_default_video_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_hfr_120_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_hfr_120_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_hfr_60_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_hfr_60_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_hfr_90_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_hfr_90_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_zsl_preview_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_zsl_preview_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k2l7_zsl_video_ak7371.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k2l7_zsl_video_ak7371.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_default_preview_ak7345.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_default_preview_ak7345.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_default_video_ak7345.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_default_video_ak7345.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_default_preview_dw9763.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_default_preview_dw9763.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_default_video_dw9763.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_default_video_dw9763.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_hfr_120_dw9763.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_hfr_120_dw9763.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_hfr_60_dw9763.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_hfr_60_dw9763.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_hfr_90_dw9763.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_hfr_90_dw9763.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_zsl_preview_dw9763.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_zsl_preview_dw9763.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_f3l8yam_zsl_video_dw9763.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_f3l8yam_zsl_video_dw9763.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_hfr_120_ak7345.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_hfr_120_ak7345.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_hfr_60_ak7345.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_hfr_60_ak7345.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_hfr_90_ak7345.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_hfr_90_ak7345.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_default_preview_ak7345.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_default_preview_ak7345.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_default_video_ak7345.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_default_video_ak7345.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_hfr_120_ak7345.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_hfr_120_ak7345.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_hfr_60_ak7345.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_hfr_60_ak7345.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_hfr_90_ak7345.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_hfr_90_ak7345.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_zsl_preview_ak7345.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_zsl_preview_ak7345.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_mono_zsl_video_ak7345.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_mono_zsl_video_ak7345.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_zsl_preview_ak7345.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_zsl_preview_ak7345.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3l8_zsl_video_ak7345.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3l8_zsl_video_ak7345.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_common_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_common_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_cpp_hfr_120_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_cpp_hfr_120_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_cpp_hfr_60_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_cpp_hfr_60_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_cpp_hfr_90_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_cpp_hfr_90_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_cpp_liveshot_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_cpp_liveshot_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_cpp_preview_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_cpp_preview_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_cpp_snapshot_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_cpp_snapshot_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_cpp_video_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_cpp_video_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_default_preview_dw9761b.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_default_preview_dw9761b.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_default_preview_dw9761b_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_default_preview_dw9761b_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_default_video_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_default_video_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_default_video_dw9761b.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_default_video_dw9761b.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_default_video_dw9761b_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_default_video_dw9761b_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_hfr_120_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_hfr_120_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_hfr_120_dw9761b.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_hfr_120_dw9761b.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_hfr_120_dw9761b_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_hfr_120_dw9761b_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_hfr_60_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_hfr_60_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_hfr_60_dw9761b.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_hfr_60_dw9761b.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_hfr_60_dw9761b_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_hfr_60_dw9761b_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_hfr_90_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_hfr_90_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_hfr_90_dw9761b.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_hfr_90_dw9761b.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_hfr_90_dw9761b_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_hfr_90_dw9761b_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_postproc_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_postproc_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_preview_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_preview_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_snapshot_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_snapshot_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_zsl_preview_dw9761b.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_zsl_preview_dw9761b.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_zsl_preview_dw9761b_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_zsl_preview_dw9761b_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_zsl_video_dw9761b.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_zsl_video_dw9761b.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xm_zsl_video_dw9761b_bear.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xm_zsl_video_dw9761b_bear.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_1080p_preview_ad5816g.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_1080p_preview_ad5816g.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_1080p_video_ad5816g.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_1080p_video_ad5816g.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_4k_preview_ad5816g.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_4k_preview_ad5816g.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_4k_video_ad5816g.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_4k_video_ad5816g.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_cpp_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_cpp_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_cpp_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_cpp_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_cpp_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_cpp_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_cpp_snapshot_downscale.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_cpp_snapshot_downscale.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_cpp_snapshot_upscale.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_cpp_snapshot_upscale.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_cpp_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_cpp_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_default_preview_ad5816g.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_default_preview_ad5816g.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_default_video_ad5816g.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_default_video_ad5816g.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_hfr_120.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_hfr_120.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_hfr_120_ad5816g.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_hfr_120_ad5816g.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_hfr_60.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_hfr_60.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_hfr_60_ad5816g.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_hfr_60_ad5816g.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_hfr_90.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_hfr_90.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_hfr_90_ad5816g.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_hfr_90_ad5816g.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_video_4k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_video_4k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_zsl_preview_ad5816g.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_zsl_preview_ad5816g.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3m2xx_zsl_video_ad5816g.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3m2xx_zsl_video_ad5816g.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p3sm_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p3sm_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p3sm_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p3sm_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p3sm_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p3sm_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p3sm_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p3sm_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p3sm_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p3sm_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p3sm_default_preview_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p3sm_default_preview_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p3sm_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p3sm_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p3sm_default_video_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p3sm_default_video_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p3sm_fullsize_preview_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p3sm_fullsize_preview_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p3sm_fullsize_video_3a.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p3sm_fullsize_video_3a.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p3sm_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p3sm_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p3sm_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p3sm_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p3sm_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p3sm_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p8sp_a3_default_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p8sp_a3_default_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p8sp_a3_default_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p8sp_a3_default_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p8sp_a3_zsl_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p8sp_a3_zsl_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p8sp_a3_zsl_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p8sp_a3_zsl_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p8sp_common.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p8sp_common.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p8sp_cpp_liveshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p8sp_cpp_liveshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p8sp_cpp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p8sp_cpp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p8sp_cpp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p8sp_cpp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p8sp_cpp_video.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p8sp_cpp_video.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p8sp_postproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p8sp_postproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p8sp_preview.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p8sp_preview.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libchromatix_s5k3p8sp_snapshot.so:$(TARGET_COPY_OUT_VENDOR)/lib/libchromatix_s5k3p8sp_snapshot.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libcld80211.so:$(TARGET_COPY_OUT_VENDOR)/lib/libcld80211.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libcne.so:$(TARGET_COPY_OUT_VENDOR)/lib/libcne.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libcneapiclient.so:$(TARGET_COPY_OUT_VENDOR)/lib/libcneapiclient.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libcneoplookup.so:$(TARGET_COPY_OUT_VENDOR)/lib/libcneoplookup.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libcneqmiutils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libcneqmiutils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libconfigdb.so:$(TARGET_COPY_OUT_VENDOR)/lib/libconfigdb.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libcppf.so:$(TARGET_COPY_OUT_VENDOR)/lib/libcppf.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libdataitems.so:$(TARGET_COPY_OUT_VENDOR)/lib/libdataitems.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libdiag.so:$(TARGET_COPY_OUT_VENDOR)/lib/libdiag.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libdiagjni.so:$(TARGET_COPY_OUT_VENDOR)/lib/libdiagjni.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libdisp-aba.so:$(TARGET_COPY_OUT_VENDOR)/lib/libdisp-aba.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libdpmqmihal.so:$(TARGET_COPY_OUT_VENDOR)/lib/libdpmqmihal.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libdrc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libdrc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libdrmfs.so:$(TARGET_COPY_OUT_VENDOR)/lib/libdrmfs.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libdrmtime.so:$(TARGET_COPY_OUT_VENDOR)/lib/libdrmtime.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libdrplugin_client.so:$(TARGET_COPY_OUT_VENDOR)/lib/libdrplugin_client.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libdsd2pcm.so:$(TARGET_COPY_OUT_VENDOR)/lib/libdsd2pcm.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libdsi_netctrl.so:$(TARGET_COPY_OUT_VENDOR)/lib/libdsi_netctrl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libdsutils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libdsutils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libevent_observer.so:$(TARGET_COPY_OUT_VENDOR)/lib/libevent_observer.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libfastcrc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libfastcrc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libfastcvadsp_stub.so:$(TARGET_COPY_OUT_VENDOR)/lib/libfastcvadsp_stub.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libfastcvopt.so:$(TARGET_COPY_OUT_VENDOR)/lib/libfastcvopt.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libfastrpc_utf_stub.so:$(TARGET_COPY_OUT_VENDOR)/lib/libfastrpc_utf_stub.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libfeedbackhandler.so:$(TARGET_COPY_OUT_VENDOR)/lib/libfeedbackhandler.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libflash_pmic.so:$(TARGET_COPY_OUT_VENDOR)/lib/libflash_pmic.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libflp.so:$(TARGET_COPY_OUT_VENDOR)/lib/libflp.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libgcs-calwrapper.so:$(TARGET_COPY_OUT_VENDOR)/lib/libgcs-calwrapper.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libgcs-ipc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libgcs-ipc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libgcs-osal.so:$(TARGET_COPY_OUT_VENDOR)/lib/libgcs-osal.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libgcs.so:$(TARGET_COPY_OUT_VENDOR)/lib/libgcs.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libgdtap.so:$(TARGET_COPY_OUT_VENDOR)/lib/libgdtap.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libgeofence.so:$(TARGET_COPY_OUT_VENDOR)/lib/libgeofence.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libgnss.so:$(TARGET_COPY_OUT_VENDOR)/lib/libgnss.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libgnsspps.so:$(TARGET_COPY_OUT_VENDOR)/lib/libgnsspps.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libgps.utils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libgps.utils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libgpu_tonemapper.so:$(TARGET_COPY_OUT_VENDOR)/lib/libgpu_tonemapper.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libgpustats.so:$(TARGET_COPY_OUT_VENDOR)/lib/libgpustats.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libgsl.so:$(TARGET_COPY_OUT_VENDOR)/lib/libgsl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libhbtpclient.so:$(TARGET_COPY_OUT_VENDOR)/lib/libhbtpclient.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libhbtpdsp.so:$(TARGET_COPY_OUT_VENDOR)/lib/libhbtpdsp.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libhbtpfrmwk.so:$(TARGET_COPY_OUT_VENDOR)/lib/libhbtpfrmwk.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libhdr_tm.so:$(TARGET_COPY_OUT_VENDOR)/lib/libhdr_tm.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libhwc2on1adapter.so:$(TARGET_COPY_OUT_VENDOR)/lib/libhwc2on1adapter.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libhypv_intercept.so:$(TARGET_COPY_OUT_VENDOR)/lib/libhypv_intercept.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libidl.so:$(TARGET_COPY_OUT_VENDOR)/lib/libidl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libizat_client_api.so:$(TARGET_COPY_OUT_VENDOR)/lib/libizat_client_api.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libizat_core.so:$(TARGET_COPY_OUT_VENDOR)/lib/libizat_core.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libjpegdhw.so:$(TARGET_COPY_OUT_VENDOR)/lib/libjpegdhw.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libjpegdmahw.so:$(TARGET_COPY_OUT_VENDOR)/lib/libjpegdmahw.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libjpegehw.so:$(TARGET_COPY_OUT_VENDOR)/lib/libjpegehw.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libjson.so:$(TARGET_COPY_OUT_VENDOR)/lib/libjson.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libkeymasterdeviceutils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libkeymasterdeviceutils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libkeymasterprovision.so:$(TARGET_COPY_OUT_VENDOR)/lib/libkeymasterprovision.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libkeymasterutils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libkeymasterutils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/liblbs_core.so:$(TARGET_COPY_OUT_VENDOR)/lib/liblbs_core.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libllvm-glnext.so:$(TARGET_COPY_OUT_VENDOR)/lib/libllvm-glnext.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libllvm-qcom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libllvm-qcom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libllvm-qgl.so:$(TARGET_COPY_OUT_VENDOR)/lib/libllvm-qgl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libloc_api_v02.so:$(TARGET_COPY_OUT_VENDOR)/lib/libloc_api_v02.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libloc_core.so:$(TARGET_COPY_OUT_VENDOR)/lib/libloc_core.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libloc_ds_api.so:$(TARGET_COPY_OUT_VENDOR)/lib/libloc_ds_api.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libloc_externalDr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libloc_externalDr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libloc_pla.so:$(TARGET_COPY_OUT_VENDOR)/lib/libloc_pla.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libloc_stub.so:$(TARGET_COPY_OUT_VENDOR)/lib/libloc_stub.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/liblocation_api.so:$(TARGET_COPY_OUT_VENDOR)/lib/liblocation_api.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/liblocationservice.so:$(TARGET_COPY_OUT_VENDOR)/lib/liblocationservice.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/liblocationservice_glue.so:$(TARGET_COPY_OUT_VENDOR)/lib/liblocationservice_glue.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/liblowi_client.so:$(TARGET_COPY_OUT_VENDOR)/lib/liblowi_client.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/liblowi_wifihal.so:$(TARGET_COPY_OUT_VENDOR)/lib/liblowi_wifihal.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/liblqe.so:$(TARGET_COPY_OUT_VENDOR)/lib/liblqe.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmdmdetect.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmdmdetect.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmdsprpc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmdsprpc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmediacodecservice.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmediacodecservice.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmm-color-convertor.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmm-color-convertor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmm-disp-apis.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmm-disp-apis.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmm-hdcpmgr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmm-hdcpmgr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmm-omxcore.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmm-omxcore.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmm-qcamera.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmm-qcamera.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmm-qdcm.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmm-qdcm.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera2_c2d_module.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera2_c2d_module.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera2_cpp_module.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera2_cpp_module.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera2_dcrf.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera2_dcrf.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera2_frame_algorithm.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera2_frame_algorithm.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera2_iface_modules.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera2_iface_modules.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera2_imglib_modules.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera2_imglib_modules.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera2_is.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera2_is.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera2_isp_modules.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera2_isp_modules.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera2_mct.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera2_mct.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera2_mct_shimlayer.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera2_mct_shimlayer.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera2_pp_buf_mgr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera2_pp_buf_mgr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera2_pproc_modules.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera2_pproc_modules.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera2_q3a_core.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera2_q3a_core.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera2_sensor_modules.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera2_sensor_modules.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera2_stats_algorithm.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera2_stats_algorithm.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera2_stats_modules.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera2_stats_modules.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_atmel_at24c32e_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_atmel_at24c32e_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_cac3_lib.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_cac3_lib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_chromaflash_lib.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_chromaflash_lib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_csidtg.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_csidtg.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_dbg.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_dbg.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_dcrf_lib.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_dcrf_lib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_dummyalgo.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_dummyalgo.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_dw9761b_2d_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_dw9761b_2d_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_eebinparse.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_eebinparse.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_eeprom_util.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_eeprom_util.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_eztune_module.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_eztune_module.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_facedetection_lib.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_facedetection_lib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_faceproc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_faceproc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_faceproc2.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_faceproc2.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_hdr_gb_lib.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_hdr_gb_lib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_imglib.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_imglib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_imx214.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_imx214.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_imx230.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_imx230.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_imx258.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_imx258.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_imx258_gt24c16_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_imx258_gt24c16_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_imx258_gt24c32_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_imx258_gt24c32_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_imx258_mono.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_imx258_mono.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_imx258_mono_gt24c32_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_imx258_mono_gt24c32_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_imx298.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_imx298.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_imx318.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_imx318.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_imx362.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_imx362.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_imx378.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_imx378.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_interface.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_interface.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_abf40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_abf40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_bcc40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_bcc40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_be_stats44.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_be_stats44.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_bf_stats47.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_bf_stats47.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_bg_stats44.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_bg_stats44.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_bhist_stats44.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_bhist_stats44.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_bpc40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_bpc40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_chroma_enhan40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_chroma_enhan40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_chroma_suppress40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_chroma_suppress40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_clamp_encoder40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_clamp_encoder40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_clamp_video40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_clamp_video40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_clamp_viewfinder40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_clamp_viewfinder40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_color_correct40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_color_correct40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_color_xform_encoder40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_color_xform_encoder40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_color_xform_viewfinder40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_color_xform_viewfinder40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_cs_stats44.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_cs_stats44.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_demosaic40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_demosaic40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_demux40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_demux40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_fovcrop_encoder40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_fovcrop_encoder40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_fovcrop_viewfinder40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_fovcrop_viewfinder40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_gamma40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_gamma40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_ihist_stats44.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_ihist_stats44.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_linearization40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_linearization40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_ltm44.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_ltm44.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_luma_adaptation40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_luma_adaptation40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_mce40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_mce40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_mesh_rolloff40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_mesh_rolloff40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_rs_stats44.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_rs_stats44.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_scaler_encoder44.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_scaler_encoder44.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_scaler_viewfinder44.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_scaler_viewfinder44.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_sce40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_sce40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_sub_module.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_sub_module.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_template.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_template.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_isp_wb40.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_isp_wb40.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_le2464c_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_le2464c_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_le2464c_master_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_le2464c_master_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_llvd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_llvd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_onsemi_cat24c16_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_onsemi_cat24c16_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_onsemi_cat24c32_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_onsemi_cat24c32_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_onsemi_cat24c32_imx362_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_onsemi_cat24c32_imx362_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_optizoom_lib.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_optizoom_lib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ov13850.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ov13850.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ov13850_q13v06k.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ov13850_q13v06k.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ov13855_m24c64.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ov13855_m24c64.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ov2281.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ov2281.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ov2680.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ov2680.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ov2685.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ov2685.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ov2685_scv3b4035.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ov2685_scv3b4035.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ov4688.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ov4688.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ov4688_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ov4688_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ov5645.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ov5645.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ov5670.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ov5670.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ov5695.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ov5695.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ov7251.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ov7251.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ov8856.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ov8856.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ov8858.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ov8858.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ov8865.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ov8865.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_paaf_lib.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_paaf_lib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_pdaf.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_pdaf.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_pdafcamif.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_pdafcamif.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ppbase_module.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ppbase_module.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_qtech_f3l8yam_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_qtech_f3l8yam_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_qtech_f5670bq_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_qtech_f5670bq_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_quadracfa.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_quadracfa.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_rohm_brcg064gwz_3_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_rohm_brcg064gwz_3_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_s5k2l7.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_s5k2l7.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_s5k3l8.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_s5k3l8.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_s5k3l8_mono.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_s5k3l8_mono.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_s5k3m2xm.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_s5k3m2xm.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_s5k3m2xx.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_s5k3m2xx.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_s5k3p3sm.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_s5k3p3sm.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_s5k3p8sp.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_s5k3p8sp.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_sony_imx214_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_sony_imx214_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_sony_imx298_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_sony_imx298_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_sony_imx378_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_sony_imx378_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_sonyimx135_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_sonyimx135_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_stillmore_lib.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_stillmore_lib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_sunny_8865_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_sunny_8865_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_sunny_gt24c64_imx298_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_sunny_gt24c64_imx298_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_sunny_gt24c64_s5k2l7_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_sunny_gt24c64_s5k2l7_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_sunny_gt24c64a_imx362_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_sunny_gt24c64a_imx362_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_sunny_q13v06k_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_sunny_q13v06k_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_sunny_q5v41b_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_sunny_q5v41b_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_sw2d_lib.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_sw2d_lib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_thread_services.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_thread_services.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_tintless_algo.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_tintless_algo.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_tintless_bg_pca_algo.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_tintless_bg_pca_algo.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_trueportrait_lib.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_trueportrait_lib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_truly_cma481_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_truly_cma481_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_truly_cmb433_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_truly_cmb433_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_truly_m24c64_eeprom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_truly_m24c64_eeprom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmcamera_ubifocus_lib.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmcamera_ubifocus_lib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmi_jni.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmi_jni.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmjpeg.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmjpeg.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmjpeg_interface.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmjpeg_interface.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmosal_proprietary.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmosal_proprietary.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmqjpeg_codec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmqjpeg_codec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libmmqjpegdma.so:$(TARGET_COPY_OUT_VENDOR)/lib/libmmqjpegdma.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libnbaio_mono.so:$(TARGET_COPY_OUT_VENDOR)/lib/libnbaio_mono.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libnetmgr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libnetmgr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/liboemaids_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/liboemaids_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/liboemcrypto.so:$(TARGET_COPY_OUT_VENDOR)/lib/liboemcrypto.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libois_lc898122.so:$(TARGET_COPY_OUT_VENDOR)/lib/libois_lc898122.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/liboptizoom.so:$(TARGET_COPY_OUT_VENDOR)/lib/liboptizoom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libpdmapper.so:$(TARGET_COPY_OUT_VENDOR)/lib/libpdmapper.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libpdnotifier.so:$(TARGET_COPY_OUT_VENDOR)/lib/libpdnotifier.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libperfgluelayer.so:$(TARGET_COPY_OUT_VENDOR)/lib/libperfgluelayer.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libperipheral_client.so:$(TARGET_COPY_OUT_VENDOR)/lib/libperipheral_client.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libpvr.so:$(TARGET_COPY_OUT_VENDOR)/lib/libpvr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqcci_legacy.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqcci_legacy.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqcmaputils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqcmaputils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqcrilFramework.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqcrilFramework.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqdi.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqdi.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqdp.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqdp.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqisl.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqisl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqmi.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqmi.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqmi_cci.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqmi_cci.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqmi_client_helper.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqmi_client_helper.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqmi_client_qmux.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqmi_client_qmux.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqmi_common_so.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqmi_common_so.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqmi_csi.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqmi_csi.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqmi_encdec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqmi_encdec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqmiservices.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqmiservices.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqomx_core.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqomx_core.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqomx_jpegdec.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqomx_jpegdec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqomx_jpegenc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqomx_jpegenc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqomx_jpegenc_pipe.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqomx_jpegenc_pipe.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqti-gt-prop.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqti-gt-prop.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqti-iopd-client.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqti-iopd-client.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqti-perfd-client.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqti-perfd-client.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqti-perfd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqti-perfd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqti-util.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqti-util.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqti-utils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqti-utils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libqtigef.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqtigef.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libquipc_os_api.so:$(TARGET_COPY_OUT_VENDOR)/lib/libquipc_os_api.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/librecovery_updater_msm.so:$(TARGET_COPY_OUT_VENDOR)/lib/librecovery_updater_msm.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libreference-ril.so:$(TARGET_COPY_OUT_VENDOR)/lib/libreference-ril.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libremosaic_daemon.so:$(TARGET_COPY_OUT_VENDOR)/lib/libremosaic_daemon.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libril-qc-hal-qmi.so:$(TARGET_COPY_OUT_VENDOR)/lib/libril-qc-hal-qmi.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libril-qc-ltedirectdisc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libril-qc-ltedirectdisc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libril-qc-qmi-1.so:$(TARGET_COPY_OUT_VENDOR)/lib/libril-qc-qmi-1.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libril-qc-radioconfig.so:$(TARGET_COPY_OUT_VENDOR)/lib/libril-qc-radioconfig.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libril-qcril-hook-oem.so:$(TARGET_COPY_OUT_VENDOR)/lib/libril-qcril-hook-oem.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libril.so:$(TARGET_COPY_OUT_VENDOR)/lib/libril.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/librilqmiservices.so:$(TARGET_COPY_OUT_VENDOR)/lib/librilqmiservices.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/librilutils.so:$(TARGET_COPY_OUT_VENDOR)/lib/librilutils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/librmnetctl.so:$(TARGET_COPY_OUT_VENDOR)/lib/librmnetctl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/librmp.so:$(TARGET_COPY_OUT_VENDOR)/lib/librmp.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/librpmb.so:$(TARGET_COPY_OUT_VENDOR)/lib/librpmb.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/librs_adreno.so:$(TARGET_COPY_OUT_VENDOR)/lib/librs_adreno.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/librs_adreno_sha1.so:$(TARGET_COPY_OUT_VENDOR)/lib/librs_adreno_sha1.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libscalar.so:$(TARGET_COPY_OUT_VENDOR)/lib/libscalar.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libscveBlobDescriptor.so:$(TARGET_COPY_OUT_VENDOR)/lib/libscveBlobDescriptor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libscveBlobDescriptor_stub.so:$(TARGET_COPY_OUT_VENDOR)/lib/libscveBlobDescriptor_stub.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libscveCommon.so:$(TARGET_COPY_OUT_VENDOR)/lib/libscveCommon.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libscveCommon_stub.so:$(TARGET_COPY_OUT_VENDOR)/lib/libscveCommon_stub.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libscveImageCorrection.so:$(TARGET_COPY_OUT_VENDOR)/lib/libscveImageCorrection.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libscveObjectSegmentation.so:$(TARGET_COPY_OUT_VENDOR)/lib/libscveObjectSegmentation.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libscveObjectTracker.so:$(TARGET_COPY_OUT_VENDOR)/lib/libscveObjectTracker.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libscveObjectTracker_stub.so:$(TARGET_COPY_OUT_VENDOR)/lib/libscveObjectTracker_stub.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libscvePanorama.so:$(TARGET_COPY_OUT_VENDOR)/lib/libscvePanorama.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libscvePanorama_lite.so:$(TARGET_COPY_OUT_VENDOR)/lib/libscvePanorama_lite.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsdedrm.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsdedrm.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsdm-color.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsdm-color.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsdm-diag.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsdm-diag.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsdm-disp-vndapis.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsdm-disp-vndapis.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsdmextension.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsdmextension.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsdsprpc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsdsprpc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsecureui.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsecureui.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsecureui_svcsock.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsecureui_svcsock.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libseemore.so:$(TARGET_COPY_OUT_VENDOR)/lib/libseemore.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsensor1.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsensor1.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsensor_reg.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsensor_reg.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsettings.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsettings.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsi.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsi.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libslimclient.so:$(TARGET_COPY_OUT_VENDOR)/lib/libslimclient.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsmemlog.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsmemlog.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsmwrapper.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsmwrapper.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libssd.so:$(TARGET_COPY_OUT_VENDOR)/lib/libssd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libstagefrighthw.so:$(TARGET_COPY_OUT_VENDOR)/lib/libstagefrighthw.so.blob_disabled
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libstreamparser.so:$(TARGET_COPY_OUT_VENDOR)/lib/libstreamparser.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsubsystem_control.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsubsystem_control.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsurround_3mic_proc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsurround_3mic_proc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libsystem_health_mon.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsystem_health_mon.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libthermalclient.so:$(TARGET_COPY_OUT_VENDOR)/lib/libthermalclient.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libtime_genoff.so:$(TARGET_COPY_OUT_VENDOR)/lib/libtime_genoff.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libtinycompress_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/libtinycompress_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libtinyxml.so:$(TARGET_COPY_OUT_VENDOR)/lib/libtinyxml.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libtinyxml2_1.so:$(TARGET_COPY_OUT_VENDOR)/lib/libtinyxml2_1.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libts_detected_face_hal.so:$(TARGET_COPY_OUT_VENDOR)/lib/libts_detected_face_hal.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libts_face_beautify_hal.so:$(TARGET_COPY_OUT_VENDOR)/lib/libts_face_beautify_hal.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libtzdrmgenprov.so:$(TARGET_COPY_OUT_VENDOR)/lib/libtzdrmgenprov.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libubifocus.so:$(TARGET_COPY_OUT_VENDOR)/lib/libubifocus.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libulp2.so:$(TARGET_COPY_OUT_VENDOR)/lib/libulp2.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libvideoutils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libvideoutils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libvpplibrary.so:$(TARGET_COPY_OUT_VENDOR)/lib/libvpplibrary.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libvpptestutils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libvpptestutils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libvqzip.so:$(TARGET_COPY_OUT_VENDOR)/lib/libvqzip.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libvraudio_client.so:$(TARGET_COPY_OUT_VENDOR)/lib/libvraudio_client.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libwebrtc_audio_preprocessing.so:$(TARGET_COPY_OUT_VENDOR)/lib/libwebrtc_audio_preprocessing.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libwfdcommonutils_proprietary.so:$(TARGET_COPY_OUT_VENDOR)/lib/libwfdcommonutils_proprietary.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libwfdhaldsmanager.so:$(TARGET_COPY_OUT_VENDOR)/lib/libwfdhaldsmanager.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libwfdhdcpcp.so:$(TARGET_COPY_OUT_VENDOR)/lib/libwfdhdcpcp.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libwfdmmservice.so:$(TARGET_COPY_OUT_VENDOR)/lib/libwfdmmservice.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libwfdmodulehdcpsession.so:$(TARGET_COPY_OUT_VENDOR)/lib/libwfdmodulehdcpsession.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libwifi-hal-qcom.so:$(TARGET_COPY_OUT_VENDOR)/lib/libwifi-hal-qcom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libwms.so:$(TARGET_COPY_OUT_VENDOR)/lib/libwms.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libwpa_client.so:$(TARGET_COPY_OUT_VENDOR)/lib/libwpa_client.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libwqe.so:$(TARGET_COPY_OUT_VENDOR)/lib/libwqe.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libxml.so:$(TARGET_COPY_OUT_VENDOR)/lib/libxml.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libxtadapter.so:$(TARGET_COPY_OUT_VENDOR)/lib/libxtadapter.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/libxtwifi_ulp_adaptor.so:$(TARGET_COPY_OUT_VENDOR)/lib/libxtwifi_ulp_adaptor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/mediacas/libclearkeycasplugin.so:$(TARGET_COPY_OUT_VENDOR)/lib/mediacas/libclearkeycasplugin.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/mediadrm/libdrmclearkeyplugin.so:$(TARGET_COPY_OUT_VENDOR)/lib/mediadrm/libdrmclearkeyplugin.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/modules/pronto/pronto_wlan.ko:$(TARGET_COPY_OUT_VENDOR)/lib/modules/pronto/pronto_wlan.ko
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/qcdrm/playready/lib/drm/libdrmprplugin_customer.so:$(TARGET_COPY_OUT_VENDOR)/lib/qcdrm/playready/lib/drm/libdrmprplugin_customer.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/qcdrm/playready/lib/libprdrmdecrypt_customer.so:$(TARGET_COPY_OUT_VENDOR)/lib/qcdrm/playready/lib/libprdrmdecrypt_customer.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/qcdrm/playready/lib/libtzplayready_customer.so:$(TARGET_COPY_OUT_VENDOR)/lib/qcdrm/playready/lib/libtzplayready_customer.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/qcdrm/playready/lib/mediadrm/libprmediadrmdecrypt_customer.so:$(TARGET_COPY_OUT_VENDOR)/lib/qcdrm/playready/lib/mediadrm/libprmediadrmdecrypt_customer.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/qcdrm/playready/lib/mediadrm/libprmediadrmplugin_customer.so:$(TARGET_COPY_OUT_VENDOR)/lib/qcdrm/playready/lib/mediadrm/libprmediadrmplugin_customer.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/rfsa/adsp/libFastRPC_AUE_Forward_skel.so:$(TARGET_COPY_OUT_VENDOR)/lib/rfsa/adsp/libFastRPC_AUE_Forward_skel.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/rfsa/adsp/libFastRPC_UTF_Forward_Qtc2_skel.so:$(TARGET_COPY_OUT_VENDOR)/lib/rfsa/adsp/libFastRPC_UTF_Forward_Qtc2_skel.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/rfsa/adsp/libapps_mem_heap.so:$(TARGET_COPY_OUT_VENDOR)/lib/rfsa/adsp/libapps_mem_heap.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/rfsa/adsp/libdspCV_skel.so:$(TARGET_COPY_OUT_VENDOR)/lib/rfsa/adsp/libdspCV_skel.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/rfsa/adsp/libexternal_dog_skel.so:$(TARGET_COPY_OUT_VENDOR)/lib/rfsa/adsp/libexternal_dog_skel.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/rfsa/adsp/libfastcvadsp.so:$(TARGET_COPY_OUT_VENDOR)/lib/rfsa/adsp/libfastcvadsp.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/rfsa/adsp/libfastcvadsp_skel.so:$(TARGET_COPY_OUT_VENDOR)/lib/rfsa/adsp/libfastcvadsp_skel.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/rfsa/adsp/libscveBlobDescriptor_skel.so:$(TARGET_COPY_OUT_VENDOR)/lib/rfsa/adsp/libscveBlobDescriptor_skel.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/rfsa/adsp/libscveT2T_skel.so:$(TARGET_COPY_OUT_VENDOR)/lib/rfsa/adsp/libscveT2T_skel.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/sensor_calibrate.so:$(TARGET_COPY_OUT_VENDOR)/lib/sensor_calibrate.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/sensors.ssc.so:$(TARGET_COPY_OUT_VENDOR)/lib/sensors.ssc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/soundfx/libasphere.so:$(TARGET_COPY_OUT_VENDOR)/lib/soundfx/libasphere.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/soundfx/libaudiopreprocessing.so:$(TARGET_COPY_OUT_VENDOR)/lib/soundfx/libaudiopreprocessing.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/soundfx/libbundlewrapper.so:$(TARGET_COPY_OUT_VENDOR)/lib/soundfx/libbundlewrapper.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/soundfx/libdownmix.so:$(TARGET_COPY_OUT_VENDOR)/lib/soundfx/libdownmix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/soundfx/libeffectproxy.so:$(TARGET_COPY_OUT_VENDOR)/lib/soundfx/libeffectproxy.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/soundfx/libldnhncr.so:$(TARGET_COPY_OUT_VENDOR)/lib/soundfx/libldnhncr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/soundfx/libqcbassboost.so:$(TARGET_COPY_OUT_VENDOR)/lib/soundfx/libqcbassboost.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/soundfx/libqcompostprocbundle.so:$(TARGET_COPY_OUT_VENDOR)/lib/soundfx/libqcompostprocbundle.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/soundfx/libqcomvisualizer.so:$(TARGET_COPY_OUT_VENDOR)/lib/soundfx/libqcomvisualizer.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/soundfx/libqcomvoiceprocessing.so:$(TARGET_COPY_OUT_VENDOR)/lib/soundfx/libqcomvoiceprocessing.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/soundfx/libqcreverb.so:$(TARGET_COPY_OUT_VENDOR)/lib/soundfx/libqcreverb.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/soundfx/libqcvirt.so:$(TARGET_COPY_OUT_VENDOR)/lib/soundfx/libqcvirt.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/soundfx/libreverbwrapper.so:$(TARGET_COPY_OUT_VENDOR)/lib/soundfx/libreverbwrapper.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/soundfx/libshoebox.so:$(TARGET_COPY_OUT_VENDOR)/lib/soundfx/libshoebox.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/soundfx/libvisualizer.so:$(TARGET_COPY_OUT_VENDOR)/lib/soundfx/libvisualizer.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.display.color@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.display.color@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.display.config@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.display.config@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.display.config@1.1_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.display.config@1.1_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.display.postproc@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.display.postproc@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.esepowermanager@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.esepowermanager@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.gnss@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.gnss@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.alarm@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.alarm@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.camera.device@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.camera.device@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.data.latency@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.data.latency@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.fingerprint@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.fingerprint@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.fm@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.fm@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.improvetouch.blobmanager@1.0-service.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.improvetouch.blobmanager@1.0-service.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.improvetouch.blobmanager@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.improvetouch.blobmanager@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.improvetouch.gesturemanager@1.0-service.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.improvetouch.gesturemanager@1.0-service.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.improvetouch.gesturemanager@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.improvetouch.gesturemanager@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.improvetouch.touchcompanion@1.0-service.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.improvetouch.touchcompanion@1.0-service.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.improvetouch.touchcompanion@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.improvetouch.touchcompanion@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.iop@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.iop@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.iop@2.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.iop@2.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.limits@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.limits@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.perf@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.perf@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.qdutils_disp@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.qdutils_disp@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.qteeconnector@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.qteeconnector@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.radio.am@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.radio.am@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.radio.atcmdfwd@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.radio.atcmdfwd@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.radio.ims@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.radio.ims@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.radio.lpa@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.radio.lpa@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.radio.qcrilhook@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.radio.qcrilhook@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.radio.qtiradio@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.radio.qtiradio@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.radio.uim@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.radio.uim@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.radio.uim@1.1_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.radio.uim@1.1_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.radio.uim_remote_client@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.radio.uim_remote_client@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.radio.uim_remote_server@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.radio.uim_remote_server@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.sensorscalibrate@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.sensorscalibrate@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.tui_comm@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.tui_comm@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.vpp@1.1_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.vpp@1.1_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.hardware.wipower@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.wipower@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.imsrtpservice@1.0-service-Impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.imsrtpservice@1.0-service-Impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.imsrtpservice@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.imsrtpservice@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib/vendor.qti.voiceprint@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.voiceprint@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/android.hidl.base@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/android.hidl.base@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/camera.device@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/camera.device@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/camera.device@3.2-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/camera.device@3.2-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/camera.device@3.3-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/camera.device@3.3-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/com.qualcomm.qti.ant@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/com.qualcomm.qti.ant@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/com.qualcomm.qti.bluetooth_audio@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/com.qualcomm.qti.bluetooth_audio@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/com.qualcomm.qti.dpm.api@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/com.qualcomm.qti.dpm.api@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/com.qualcomm.qti.imscmservice@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/com.qualcomm.qti.imscmservice@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/com.qualcomm.qti.imscmservice@1.1_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/com.qualcomm.qti.imscmservice@1.1_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/com.qualcomm.qti.wifidisplayhal@1.0-halimpl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/com.qualcomm.qti.wifidisplayhal@1.0-halimpl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/com.qualcomm.qti.wifidisplayhal@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/com.qualcomm.qti.wifidisplayhal@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/com.qualcomm.qti.wifidisplayhal@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/com.qualcomm.qti.wifidisplayhal@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/com.quicinc.cne.api@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/com.quicinc.cne.api@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/com.quicinc.cne.constants@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/com.quicinc.cne.constants@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/com.quicinc.cne.constants@2.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/com.quicinc.cne.constants@2.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/com.quicinc.cne.server@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/com.quicinc.cne.server@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/com.quicinc.cne.server@2.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/com.quicinc.cne.server@2.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/egl/eglSubDriverAndroid.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/eglSubDriverAndroid.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/egl/libEGL_adreno.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libEGL_adreno.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/egl/libGLESv1_CM_adreno.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libGLESv1_CM_adreno.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/egl/libGLESv2_adreno.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libGLESv2_adreno.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/egl/libQTapGLES.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libQTapGLES.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/egl/libq3dtools_adreno.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libq3dtools_adreno.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/egl/libq3dtools_esx.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libq3dtools_esx.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/activity_recognition.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/activity_recognition.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/android.hardware.bluetooth@1.0-impl-qti.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/android.hardware.bluetooth@1.0-impl-qti.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/android.hardware.camera.provider@2.4-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/android.hardware.camera.provider@2.4-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/android.hardware.gatekeeper@1.0-impl-qti.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/android.hardware.gatekeeper@1.0-impl-qti.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/android.hardware.gnss@1.0-impl-qti.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/android.hardware.gnss@1.0-impl-qti.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/android.hardware.renderscript@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/android.hardware.renderscript@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/audio.primary.default.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/audio.primary.default.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/audio.primary.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/audio.primary.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/audio.r_submix.default.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/audio.r_submix.default.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/audio.usb.default.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/audio.usb.default.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/com.qualcomm.qti.ant@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/com.qualcomm.qti.ant@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/gatekeeper.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/gatekeeper.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/gralloc.default.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/gralloc.default.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/keystore.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/keystore.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/lights.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/lights.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/local_time.default.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/local_time.default.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/power.default.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/power.default.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/power.qcom.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/power.qcom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/sound_trigger.primary.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/sound_trigger.primary.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/thermal.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/thermal.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/vendor.qti.esepowermanager@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/vendor.qti.esepowermanager@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/vendor.qti.gnss@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/vendor.qti.gnss@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/vendor.qti.hardware.alarm@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/vendor.qti.hardware.alarm@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/vendor.qti.hardware.factory@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/vendor.qti.hardware.factory@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/vendor.qti.hardware.fm@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/vendor.qti.hardware.fm@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/vendor.qti.hardware.iop@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/vendor.qti.hardware.iop@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/vendor.qti.hardware.qteeconnector@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/vendor.qti.hardware.qteeconnector@1.0-impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/vibrator.default.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/vibrator.default.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/hw/vulkan.msm8953.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/vulkan.msm8953.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/lib-dplmedia.so:$(TARGET_COPY_OUT_VENDOR)/lib64/lib-dplmedia.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/lib-imsSDP.so:$(TARGET_COPY_OUT_VENDOR)/lib64/lib-imsSDP.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/lib-imscmservice.so:$(TARGET_COPY_OUT_VENDOR)/lib64/lib-imscmservice.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/lib-imsdpl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/lib-imsdpl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/lib-imsqimf.so:$(TARGET_COPY_OUT_VENDOR)/lib64/lib-imsqimf.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/lib-imsrcs-v2.so:$(TARGET_COPY_OUT_VENDOR)/lib64/lib-imsrcs-v2.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/lib-imsxml.so:$(TARGET_COPY_OUT_VENDOR)/lib64/lib-imsxml.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/lib-rtpcommon.so:$(TARGET_COPY_OUT_VENDOR)/lib64/lib-rtpcommon.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/lib-rtpcore.so:$(TARGET_COPY_OUT_VENDOR)/lib64/lib-rtpcore.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/lib-rtpdaemoninterface.so:$(TARGET_COPY_OUT_VENDOR)/lib64/lib-rtpdaemoninterface.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/lib-rtpsl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/lib-rtpsl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/lib-siputility.so:$(TARGET_COPY_OUT_VENDOR)/lib64/lib-siputility.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/lib-uceservice.so:$(TARGET_COPY_OUT_VENDOR)/lib64/lib-uceservice.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libAlacSwDec.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libAlacSwDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libApeSwDec.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libApeSwDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libC2D2.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libC2D2.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libCB.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libCB.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libDRPlugin.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libDRPlugin.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libFIDOKeyProvisioning.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libFIDOKeyProvisioning.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libFidoCrypto_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libFidoCrypto_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libFlacSwDec.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libFlacSwDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libGPTEE_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libGPTEE_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libGPreqcancel.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libGPreqcancel.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libGPreqcancel_svc.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libGPreqcancel_svc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libI420colorconvert.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libI420colorconvert.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxAacDec.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxAacDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxAacEnc.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxAacEnc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxAlacDec.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxAlacDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxAlacDecSw.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxAlacDecSw.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxAmrDec.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxAmrDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxAmrEnc.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxAmrEnc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxAmrwbplusDec.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxAmrwbplusDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxApeDec.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxApeDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxApeDecSw.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxApeDecSw.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxCore.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxCore.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxEvrcDec.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxEvrcDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxEvrcEnc.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxEvrcEnc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxG711Dec.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxG711Dec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxG711Enc.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxG711Enc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxQcelp13Dec.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxQcelp13Dec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxQcelp13Enc.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxQcelp13Enc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxVdec.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxVdec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxVenc.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxVenc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxVpp.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxVpp.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOmxWmaDec.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOmxWmaDec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libOpenCL.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOpenCL.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libQSEEComAPI.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libQSEEComAPI.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libQTEEConnector_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libQTEEConnector_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libRSDriver_adreno.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libRSDriver_adreno.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libSecureUILib.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libSecureUILib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libStDrvInt.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libStDrvInt.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libSubSystemShutdown.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libSubSystemShutdown.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libUBWC.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libUBWC.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libUserAgent.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libUserAgent.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/lib_drplugin_server.so:$(TARGET_COPY_OUT_VENDOR)/lib64/lib_drplugin_server.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/lib_remote_simlock.so:$(TARGET_COPY_OUT_VENDOR)/lib64/lib_remote_simlock.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libacdb-fts.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libacdb-fts.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libacdbloader.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libacdbloader.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libacdbmapper.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libacdbmapper.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libacdbrtac.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libacdbrtac.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libadiertac.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libadiertac.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libadreno_utils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libadreno_utils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libadsp_default_listener.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libadsp_default_listener.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libadsprpc.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libadsprpc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libalarmservice_jni.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libalarmservice_jni.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libalsautils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libalsautils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libaudcal.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libaudcal.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libaudio_log_utils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libaudio_log_utils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libaudioalsa.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libaudioalsa.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libaudioparsers.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libaudioparsers.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libbase64.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libbase64.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libbccQTI.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libbccQTI.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libbt-hidlclient.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libbt-hidlclient.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libbt-vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libbt-vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libbthost_if.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libbthost_if.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libbtnv.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libbtnv.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libc2d30-a3xx.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libc2d30-a3xx.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libc2d30-a4xx.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libc2d30-a4xx.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libc2d30-a5xx.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libc2d30-a5xx.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libc2d30_bltlib.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libc2d30_bltlib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libc2dcolorconvert.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libc2dcolorconvert.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libcdsprpc.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libcdsprpc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libcld80211.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libcld80211.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libcne.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libcne.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libcneapiclient.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libcneapiclient.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libcneoplookup.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libcneoplookup.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libcneqmiutils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libcneqmiutils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libconfigdb.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libconfigdb.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libdataitems.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libdataitems.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libdiag.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libdiag.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libdiagjni.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libdiagjni.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libdisp-aba.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libdisp-aba.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libdpmqmihal.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libdpmqmihal.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libdrmfs.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libdrmfs.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libdrmtime.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libdrmtime.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libdrplugin_client.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libdrplugin_client.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libdsi_netctrl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libdsi_netctrl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libdsutils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libdsutils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libevent_observer.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libevent_observer.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libfastcrc.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libfastcrc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libfastcvadsp_stub.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libfastcvadsp_stub.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libfastcvopt.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libfastcvopt.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libfastrpc_utf_stub.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libfastrpc_utf_stub.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libfeedbackhandler.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libfeedbackhandler.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libflp.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libflp.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libgcs-calwrapper.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgcs-calwrapper.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libgcs-ipc.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgcs-ipc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libgcs-osal.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgcs-osal.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libgcs.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgcs.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libgdtap.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgdtap.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libgeofence.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgeofence.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libgnss.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgnss.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libgnsspps.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgnsspps.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libgps.utils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgps.utils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libgpu_tonemapper.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgpu_tonemapper.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libgpustats.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgpustats.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libgsl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgsl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libhbtpclient.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libhbtpclient.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libhbtpdsp.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libhbtpdsp.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libhbtpfrmwk.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libhbtpfrmwk.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libhdr_tm.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libhdr_tm.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libhwc2on1adapter.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libhwc2on1adapter.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libhwminijail.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libhwminijail.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libhypv_intercept.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libhypv_intercept.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libidl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libidl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libipanat.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libipanat.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libizat_client_api.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libizat_client_api.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libizat_core.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libizat_core.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libjson.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libjson.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libkeymasterdeviceutils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libkeymasterdeviceutils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libkeymasterprovision.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libkeymasterprovision.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libkeymasterutils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libkeymasterutils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libkeystore-engine-wifi-hidl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libkeystore-engine-wifi-hidl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libkeystore-wifi-hidl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libkeystore-wifi-hidl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/liblbs_core.so:$(TARGET_COPY_OUT_VENDOR)/lib64/liblbs_core.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libllvm-glnext.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libllvm-glnext.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libllvm-qcom.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libllvm-qcom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libllvm-qgl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libllvm-qgl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libloc_api_v02.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libloc_api_v02.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libloc_core.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libloc_core.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libloc_ds_api.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libloc_ds_api.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libloc_externalDr.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libloc_externalDr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libloc_pla.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libloc_pla.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libloc_stub.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libloc_stub.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/liblocation_api.so:$(TARGET_COPY_OUT_VENDOR)/lib64/liblocation_api.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/liblocationservice.so:$(TARGET_COPY_OUT_VENDOR)/lib64/liblocationservice.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/liblocationservice_glue.so:$(TARGET_COPY_OUT_VENDOR)/lib64/liblocationservice_glue.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/liblowi_client.so:$(TARGET_COPY_OUT_VENDOR)/lib64/liblowi_client.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/liblowi_wifihal.so:$(TARGET_COPY_OUT_VENDOR)/lib64/liblowi_wifihal.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/liblqe.so:$(TARGET_COPY_OUT_VENDOR)/lib64/liblqe.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmdmdetect.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmdmdetect.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmdsprpc.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmdsprpc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmm-color-convertor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmm-color-convertor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmm-disp-apis.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmm-disp-apis.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmm-hdcpmgr.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmm-hdcpmgr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmm-omxcore.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmm-omxcore.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmm-qdcm.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmm-qdcm.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmmcamera2_frame_algorithm.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmmcamera2_frame_algorithm.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmmcamera2_is.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmmcamera2_is.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmmcamera2_q3a_core.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmmcamera2_q3a_core.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmmcamera2_stats_algorithm.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmmcamera2_stats_algorithm.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmmcamera_cac3_lib.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmmcamera_cac3_lib.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmmcamera_dbg.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmmcamera_dbg.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmmcamera_tintless_algo.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmmcamera_tintless_algo.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmmcamera_tintless_bg_pca_algo.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmmcamera_tintless_bg_pca_algo.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmmi_jni.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmmi_jni.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libmmosal_proprietary.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmmosal_proprietary.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libnbaio_mono.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libnbaio_mono.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libnetfilter_conntrack.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libnetfilter_conntrack.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libnetmgr.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libnetmgr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libnfnetlink.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libnfnetlink.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/liboemaids_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/liboemaids_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/liboffloadhal.so:$(TARGET_COPY_OUT_VENDOR)/lib64/liboffloadhal.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/liboptizoom.so:$(TARGET_COPY_OUT_VENDOR)/lib64/liboptizoom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libpdmapper.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libpdmapper.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libpdnotifier.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libpdnotifier.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libperfgluelayer.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libperfgluelayer.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libperipheral_client.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libperipheral_client.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libpvr.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libpvr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqcci_legacy.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqcci_legacy.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqcmaputils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqcmaputils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqcrilFramework.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqcrilFramework.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqdi.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqdi.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqdp.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqdp.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqisl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqisl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqmi.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqmi.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqmi_cci.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqmi_cci.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqmi_client_helper.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqmi_client_helper.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqmi_client_qmux.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqmi_client_qmux.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqmi_common_so.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqmi_common_so.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqmi_csi.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqmi_csi.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqmi_encdec.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqmi_encdec.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqmiservices.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqmiservices.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqti-gt-prop.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqti-gt-prop.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqti-iopd-client.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqti-iopd-client.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqti-perfd-client.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqti-perfd-client.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqti-perfd.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqti-perfd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqti-util.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqti-util.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqti-utils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqti-utils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libqtigef.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqtigef.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libquipc_os_api.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libquipc_os_api.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/librecovery_updater_msm.so:$(TARGET_COPY_OUT_VENDOR)/lib64/librecovery_updater_msm.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libreference-ril.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libreference-ril.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libril-qc-hal-qmi.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libril-qc-hal-qmi.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libril-qc-ltedirectdisc.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libril-qc-ltedirectdisc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libril-qc-qmi-1.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libril-qc-qmi-1.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libril-qc-radioconfig.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libril-qc-radioconfig.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libril-qcril-hook-oem.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libril-qcril-hook-oem.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libril.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libril.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/librilqmiservices.so:$(TARGET_COPY_OUT_VENDOR)/lib64/librilqmiservices.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/librilutils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/librilutils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/librmnetctl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/librmnetctl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/librmp.so:$(TARGET_COPY_OUT_VENDOR)/lib64/librmp.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/librpmb.so:$(TARGET_COPY_OUT_VENDOR)/lib64/librpmb.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/librs_adreno.so:$(TARGET_COPY_OUT_VENDOR)/lib64/librs_adreno.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/librs_adreno_sha1.so:$(TARGET_COPY_OUT_VENDOR)/lib64/librs_adreno_sha1.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libscalar.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libscalar.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libscveBlobDescriptor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libscveBlobDescriptor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libscveBlobDescriptor_stub.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libscveBlobDescriptor_stub.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libscveCommon.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libscveCommon.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libscveCommon_stub.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libscveCommon_stub.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libscveImageCorrection.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libscveImageCorrection.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libscveObjectSegmentation.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libscveObjectSegmentation.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libscveObjectTracker.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libscveObjectTracker.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libscveObjectTracker_stub.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libscveObjectTracker_stub.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libscvePanorama.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libscvePanorama.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libscvePanorama_lite.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libscvePanorama_lite.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libsdedrm.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsdedrm.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libsdm-color.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsdm-color.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libsdm-diag.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsdm-diag.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libsdm-disp-vndapis.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsdm-disp-vndapis.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libsdmextension.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsdmextension.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libsdsprpc.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsdsprpc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libsecureui.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsecureui.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libsecureui_svcsock.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsecureui_svcsock.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libseemore.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libseemore.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libselinux_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libselinux_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libsensor1.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsensor1.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libsensor_reg.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsensor_reg.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libsettings.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsettings.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libsi.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsi.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libslimclient.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libslimclient.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libsmemlog.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsmemlog.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libssd.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libssd.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libstagefrighthw.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libstagefrighthw.so.blob_disabled
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libstreamparser.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libstreamparser.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libsubsystem_control.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsubsystem_control.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libsystem_health_mon.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsystem_health_mon.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libthermalclient.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libthermalclient.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libthermalioctl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libthermalioctl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libtime_genoff.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libtime_genoff.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libtinycompress_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libtinycompress_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libtinyxml.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libtinyxml.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libtinyxml2_1.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libtinyxml2_1.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libts_detected_face_hal.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libts_detected_face_hal.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libts_face_beautify_hal.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libts_face_beautify_hal.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libtzdrmgenprov.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libtzdrmgenprov.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libubifocus.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libubifocus.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libulp2.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libulp2.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libvideoutils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libvideoutils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libvpplibrary.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libvpplibrary.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libvpptestutils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libvpptestutils.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libvraudio_client.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libvraudio_client.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libwebrtc_audio_preprocessing.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libwebrtc_audio_preprocessing.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libwfdcommonutils_proprietary.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libwfdcommonutils_proprietary.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libwfdhaldsmanager.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libwfdhaldsmanager.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libwfdhdcpcp.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libwfdhdcpcp.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libwfdmmservice.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libwfdmmservice.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libwfdmodulehdcpsession.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libwfdmodulehdcpsession.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libwifi-hal-qcom.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libwifi-hal-qcom.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libwifi-hal.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libwifi-hal.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libwms.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libwms.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libwpa_client.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libwpa_client.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libwqe.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libwqe.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libxml.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libxml.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libxtadapter.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libxtadapter.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libxtwifi_ulp_adaptor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libxtwifi_ulp_adaptor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/mediacas/libclearkeycasplugin.so:$(TARGET_COPY_OUT_VENDOR)/lib64/mediacas/libclearkeycasplugin.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/mediadrm/libdrmclearkeyplugin.so:$(TARGET_COPY_OUT_VENDOR)/lib64/mediadrm/libdrmclearkeyplugin.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/sensor_calibrate.so:$(TARGET_COPY_OUT_VENDOR)/lib64/sensor_calibrate.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/sensors.ssc.so:$(TARGET_COPY_OUT_VENDOR)/lib64/sensors.ssc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/soundfx/libasphere.so:$(TARGET_COPY_OUT_VENDOR)/lib64/soundfx/libasphere.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/soundfx/libaudiopreprocessing.so:$(TARGET_COPY_OUT_VENDOR)/lib64/soundfx/libaudiopreprocessing.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/soundfx/libbundlewrapper.so:$(TARGET_COPY_OUT_VENDOR)/lib64/soundfx/libbundlewrapper.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/soundfx/libdownmix.so:$(TARGET_COPY_OUT_VENDOR)/lib64/soundfx/libdownmix.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/soundfx/libeffectproxy.so:$(TARGET_COPY_OUT_VENDOR)/lib64/soundfx/libeffectproxy.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/soundfx/libldnhncr.so:$(TARGET_COPY_OUT_VENDOR)/lib64/soundfx/libldnhncr.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/soundfx/libqcbassboost.so:$(TARGET_COPY_OUT_VENDOR)/lib64/soundfx/libqcbassboost.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/soundfx/libqcompostprocbundle.so:$(TARGET_COPY_OUT_VENDOR)/lib64/soundfx/libqcompostprocbundle.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/soundfx/libqcomvisualizer.so:$(TARGET_COPY_OUT_VENDOR)/lib64/soundfx/libqcomvisualizer.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/soundfx/libqcomvoiceprocessing.so:$(TARGET_COPY_OUT_VENDOR)/lib64/soundfx/libqcomvoiceprocessing.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/soundfx/libqcreverb.so:$(TARGET_COPY_OUT_VENDOR)/lib64/soundfx/libqcreverb.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/soundfx/libqcvirt.so:$(TARGET_COPY_OUT_VENDOR)/lib64/soundfx/libqcvirt.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/soundfx/libreverbwrapper.so:$(TARGET_COPY_OUT_VENDOR)/lib64/soundfx/libreverbwrapper.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/soundfx/libshoebox.so:$(TARGET_COPY_OUT_VENDOR)/lib64/soundfx/libshoebox.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/soundfx/libvisualizer.so:$(TARGET_COPY_OUT_VENDOR)/lib64/soundfx/libvisualizer.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.display.color@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.display.color@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.display.config@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.display.config@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.display.config@1.1_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.display.config@1.1_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.display.postproc@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.display.postproc@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.esepowermanager@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.esepowermanager@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.gnss@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.gnss@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.alarm@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.alarm@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.camera.device@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.camera.device@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.data.latency@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.data.latency@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.fingerprint@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.fingerprint@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.fm@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.fm@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.improvetouch.blobmanager@1.0-service.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.improvetouch.blobmanager@1.0-service.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.improvetouch.blobmanager@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.improvetouch.blobmanager@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.improvetouch.gesturemanager@1.0-service.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.improvetouch.gesturemanager@1.0-service.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.improvetouch.gesturemanager@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.improvetouch.gesturemanager@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.improvetouch.touchcompanion@1.0-service.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.improvetouch.touchcompanion@1.0-service.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.improvetouch.touchcompanion@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.improvetouch.touchcompanion@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.iop@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.iop@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.iop@2.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.iop@2.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.limits@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.limits@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.perf@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.perf@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.qdutils_disp@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.qdutils_disp@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.qteeconnector@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.qteeconnector@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.radio.am@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.radio.am@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.radio.atcmdfwd@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.radio.atcmdfwd@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.radio.ims@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.radio.ims@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.radio.lpa@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.radio.lpa@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.radio.qcrilhook@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.radio.qcrilhook@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.radio.qtiradio@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.radio.qtiradio@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.radio.uim@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.radio.uim@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.radio.uim@1.1_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.radio.uim@1.1_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.radio.uim_remote_client@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.radio.uim_remote_client@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.radio.uim_remote_server@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.radio.uim_remote_server@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.sensorscalibrate@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.sensorscalibrate@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.tui_comm@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.tui_comm@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.vpp@1.1_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.vpp@1.1_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.wifi.supplicant@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.wifi.supplicant@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.wifi.supplicant@1.1_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.wifi.supplicant@1.1_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.hardware.wipower@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.wipower@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.imsrtpservice@1.0-service-Impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.imsrtpservice@1.0-service-Impl.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.imsrtpservice@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.imsrtpservice@1.0_vendor.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/vendor.qti.voiceprint@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.voiceprint@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/CTA/.preloadspec:$(TARGET_COPY_OUT_VENDOR)/package/CTA/.preloadspec
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/CTA/system/vendor/vendor.prop:$(TARGET_COPY_OUT_VENDOR)/package/CTA/system/vendor/vendor.prop
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/ChinaMobile/.preloadspec:$(TARGET_COPY_OUT_VENDOR)/package/ChinaMobile/.preloadspec
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/ChinaMobile/exclude.list:$(TARGET_COPY_OUT_VENDOR)/package/ChinaMobile/exclude.list
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/ChinaMobile/system/vendor/hosts:$(TARGET_COPY_OUT_VENDOR)/package/ChinaMobile/system/vendor/hosts
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/ChinaMobile/system/vendor/vendor.prop:$(TARGET_COPY_OUT_VENDOR)/package/ChinaMobile/system/vendor/vendor.prop
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/ChinaTelecom/.preloadspec:$(TARGET_COPY_OUT_VENDOR)/package/ChinaTelecom/.preloadspec
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/ChinaTelecom/exclude.list:$(TARGET_COPY_OUT_VENDOR)/package/ChinaTelecom/exclude.list
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/ChinaTelecom/system/vendor/vendor.prop:$(TARGET_COPY_OUT_VENDOR)/package/ChinaTelecom/system/vendor/vendor.prop
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/ChinaUnicom/.preloadspec:$(TARGET_COPY_OUT_VENDOR)/package/ChinaUnicom/.preloadspec
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/ChinaUnicom/exclude.list:$(TARGET_COPY_OUT_VENDOR)/package/ChinaUnicom/exclude.list
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/ChinaUnicom/system/vendor/vendor.prop:$(TARGET_COPY_OUT_VENDOR)/package/ChinaUnicom/system/vendor/vendor.prop
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/Default/.preloadspec:$(TARGET_COPY_OUT_VENDOR)/package/Default/.preloadspec
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/Default/system/build.prop:$(TARGET_COPY_OUT_VENDOR)/package/Default/system/build.prop
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/Default/system/vendor/default.prop:$(TARGET_COPY_OUT_VENDOR)/package/Default/system/vendor/default.prop
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/EUCommon/.preloadspec:$(TARGET_COPY_OUT_VENDOR)/package/EUCommon/.preloadspec
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/EUCommon/system/vendor/vendor.prop:$(TARGET_COPY_OUT_VENDOR)/package/EUCommon/system/vendor/vendor.prop
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/TelefonicaGermany/.preloadspec:$(TARGET_COPY_OUT_VENDOR)/package/TelefonicaGermany/.preloadspec
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/TelefonicaGermany/data/modem_config/msm8998/mcfg_sw.mbn:$(TARGET_COPY_OUT_VENDOR)/package/TelefonicaGermany/data/modem_config/msm8998/mcfg_sw.mbn
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/TelefonicaGermany/data/modem_row_config/msm8998/mcfg_sw.mbn:$(TARGET_COPY_OUT_VENDOR)/package/TelefonicaGermany/data/modem_row_config/msm8998/mcfg_sw.mbn
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/TelefonicaGermany/system/vendor/vendor.prop:$(TARGET_COPY_OUT_VENDOR)/package/TelefonicaGermany/system/vendor/vendor.prop
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/VodafoneGroup/.preloadspec:$(TARGET_COPY_OUT_VENDOR)/package/VodafoneGroup/.preloadspec
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/VodafoneGroup/system/vendor/vendor.prop:$(TARGET_COPY_OUT_VENDOR)/package/VodafoneGroup/system/vendor/vendor.prop
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/VodafoneUK/.preloadspec:$(TARGET_COPY_OUT_VENDOR)/package/VodafoneUK/.preloadspec
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/VodafoneUK/data/modem_row_config/msm8998/mcfg_sw.mbn:$(TARGET_COPY_OUT_VENDOR)/package/VodafoneUK/data/modem_row_config/msm8998/mcfg_sw.mbn
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/VodafoneUK/system/vendor/vendor.prop:$(TARGET_COPY_OUT_VENDOR)/package/VodafoneUK/system/vendor/vendor.prop
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/package/default.prop:$(TARGET_COPY_OUT_VENDOR)/package/default.prop
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/radio/qcril_database/qcril.db:$(TARGET_COPY_OUT_VENDOR)/radio/qcril_database/qcril.db
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/speccfg/switch_spec.sh:$(TARGET_COPY_OUT_VENDOR)/speccfg/switch_spec.sh

# ---------------------------- build 自身生成的文件 ------------------------
# ★ 这些文件由 AOSP build 系统生成，若同时拷贝会造成 ninja 依赖环
#   （如 dependency cycle: system/vendor/etc/NOTICE.xml.gz -> ...）
#   - etc/NOTICE.xml.gz
#   - etc/fs_config_dirs
#   - etc/fs_config_files
#   - etc/selinux/nonplat_file_contexts

# ---------------------------- VINTF 元数据（改走 BoardConfig）--------------
# ★ AOSP 11 禁止用 PRODUCT_COPY_FILES 拷贝 VINTF 元数据：
#   （error: VINTF metadata found in PRODUCT_COPY_FILES ...)
#   以下两个文件改由 BoardConfig.mk 的 DEVICE_MANIFEST_FILE / DEVICE_MATRIX_FILE 引入：
#   - compatibility_matrix.xml
#   - manifest.xml

# ---------------------------- 已跳过的文件 ----------------------------
# ★ AOSP 11 禁止用 PRODUCT_COPY_FILES 拷贝 .apk / .jar
#   （error: Prebuilt apk found in PRODUCT_COPY_FILES ... use BUILD_PREBUILT instead!）
#   以下为厂商工具类 APK/JAR，与「让 ROM 开机」无关，第一轮整体跳过：
#   - app/CABLService/CABLService.apk
#   - app/Perfdump/Perfdump.apk
#   - app/PowerOffAlarm/PowerOffAlarm.apk
#   - app/Qmmi/Qmmi.apk
#   - app/SVIService/SVIService.apk
#   - app/SnapdragonMusic/SnapdragonMusic.apk
#   - app/TimeService/TimeService.apk
#   - app/colorservice/colorservice.apk
#   - app/qti-logkit/qti-logkit.apk
#   - framework/qti-vzw-ims-internal.jar
#   - framework/vendor.qti.hardware.alarm-V1.0-java.jar
#   - framework/vendor.qti.hardware.factory-V1.0-java.jar
#   - framework/vendor.qti.hardware.sensorscalibrate-V1.0-java.jar
#   - overlay/OptInAppOverlay/OptInAppOverlay.apk
#   - overlay/SysuiDarkTheme/SysuiDarkThemeOverlay.apk
#   - package/CTA/system/vendor/overlay/CTAMmsRes/CTAMmsRes.apk
#   - package/CTA/system/vendor/overlay/CTANetworkSettingRes/CTANetworkSettingRes.apk
#   - package/CTA/system/vendor/overlay/CTASettingsProviderRes/CTASettingsProviderRes.apk
#   - package/CTA/system/vendor/overlay/CTASystemUIRes/CTASystemUIRes.apk
#   - package/ChinaMobile/system/app/Backup/Backup.apk
#   - package/ChinaMobile/system/vendor/overlay/CmccMmsRes/CmccMmsRes.apk
#   - package/ChinaMobile/system/vendor/overlay/CmccMusicRes/CmccMusicRes.apk
#   - package/ChinaMobile/system/vendor/overlay/CmccSettingsProviderRes/CmccSettingsProviderRes.apk
#   - package/ChinaMobile/system/vendor/overlay/CmccSettingsRes/CmccSettingsRes.apk
#   - package/ChinaMobile/system/vendor/overlay/CmccSystemUIRes/CmccSystemUIRes.apk
#   - package/ChinaTelecom/system/vendor/overlay/CtSettingsProviderRes/CtSettingsProviderRes.apk
#   - package/ChinaTelecom/system/vendor/overlay/CtSystemUIRes/CtSystemUIRes.apk
#   - package/ChinaUnicom/system/vendor/overlay/CuSettingsProviderRes/CuSettingsProviderRes.apk
#   - package/ChinaUnicom/system/vendor/overlay/CuSystemUIRes/CuSystemUIRes.apk
#   - package/EUCommon/system/vendor/overlay/EUCommonFrameworksRes/EUCommonFrameworksRes.apk
#   - package/EUCommon/system/vendor/overlay/EUCommonPhoneFeaturesRes/EUCommonPhoneFeaturesRes.apk
#   - package/EUCommon/system/vendor/overlay/EUCommonSettingsProviderRes/EUCommonSettingsProviderRes.apk
#   - package/TelefonicaGermany/system/vendor/overlay/TelefonicaGermanyBrowserRes/TelefonicaGermanyBrowserRes.apk
#   - package/TelefonicaGermany/system/vendor/overlay/TelefonicaGermanyContactsRes/TelefonicaGermanyContactsRes.apk
#   - package/TelefonicaGermany/system/vendor/overlay/TelefonicaGermanyFrameworksRes/TelefonicaGermanyFrameworksRes.apk
#   - package/TelefonicaGermany/system/vendor/overlay/TelefonicaGermanyKeyguardRes/TelefonicaGermanyKeyguardRes.apk
#   - package/TelefonicaGermany/system/vendor/overlay/TelefonicaGermanyMmsRes/TelefonicaGermanyMmsRes.apk
#   - package/TelefonicaGermany/system/vendor/overlay/TelefonicaGermanySettingsProviderRes/TelefonicaGermanySettingsProviderRes.apk
#   - package/TelefonicaGermany/system/vendor/overlay/TelefonicaGermanySettingsRes/TelefonicaGermanySettingsRes.apk
#   - package/TelefonicaGermany/system/vendor/overlay/TelefonicaGermanySimContactsRes/TelefonicaGermanySimContactsRes.apk
#   - package/TelefonicaGermany/system/vendor/overlay/TelefonicaGermanyStkRes/TelefonicaGermanyStkRes.apk
#   - package/TelefonicaGermany/system/vendor/overlay/TelefonicaGermanySystemUIRes/TelefonicaGermanySystemUIRes.apk
#   - package/TelefonicaGermany/system/vendor/overlay/TelefonicaGermanyTeleServiceRes/TelefonicaGermanyTeleServiceRes.apk
#   - package/VodafoneGroup/system/vendor/overlay/VodafoneGroupFrameworksRes/VodafoneGroupFrameworksRes.apk
#   - package/VodafoneGroup/system/vendor/overlay/VodafoneGroupNetworkSettingRes/VodafoneGroupNetworkSettingRes.apk
#   - package/VodafoneGroup/system/vendor/overlay/VodafoneGroupTeleServiceRes/VodafoneGroupTeleServiceRes.apk
#   - package/VodafoneUK/system/vendor/overlay/VodafoneUKBrowserRes/VodafoneUKBrowserRes.apk
#   - package/VodafoneUK/system/vendor/overlay/VodafoneUKContactsRes/VodafoneUKContactsRes.apk
#   - package/VodafoneUK/system/vendor/overlay/VodafoneUKDialerRes/VodafoneUKDialerRes.apk
#   - package/VodafoneUK/system/vendor/overlay/VodafoneUKEmailRes/VodafoneUKEmailRes.apk
#   - package/VodafoneUK/system/vendor/overlay/VodafoneUKFrameworksRes/VodafoneUKFrameworksRes.apk
#   - package/VodafoneUK/system/vendor/overlay/VodafoneUKLatinIMERes/VodafoneUKLatinIMERes.apk
#   - package/VodafoneUK/system/vendor/overlay/VodafoneUKMmsRes/VodafoneUKMmsRes.apk
#   - package/VodafoneUK/system/vendor/overlay/VodafoneUKNetworkSettingRes/VodafoneUKNetworkSettingRes.apk
#   - package/VodafoneUK/system/vendor/overlay/VodafoneUKOmaDownloadRes/VodafoneUKOmaDownloadRes.apk
#   - package/VodafoneUK/system/vendor/overlay/VodafoneUKPhoneCommonRes/VodafoneUKPhoneCommonRes.apk
#   - package/VodafoneUK/system/vendor/overlay/VodafoneUKSettingsProviderRes/VodafoneUKSettingsProviderRes.apk
#   - package/VodafoneUK/system/vendor/overlay/VodafoneUKSettingsRes/VodafoneUKSettingsRes.apk
#   - package/VodafoneUK/system/vendor/overlay/VodafoneUKSimContactsRes/VodafoneUKSimContactsRes.apk
#   - package/VodafoneUK/system/vendor/overlay/VodafoneUKSystemUIRes/VodafoneUKSystemUIRes.apk
#   - package/VodafoneUK/system/vendor/overlay/VodafoneUKTeleServiceRes/VodafoneUKTeleServiceRes.apk


# ─── MS600_V54_FIRMWARE: 原厂固件入库（WiFi/音频/视频 治本补丁）───────────────
# 内核在 /etc/firmware、/odm/firmware、/vendor/firmware、/firmware/image
# 四处找固件；原厂靠挂载 modem 分区到 /firmware，A11 里 mkdir /firmware 会失败
# （根 fs 只读），故直接放进 /vendor/firmware（搜索路径第 3 位，必然命中）。
# 素材取自原厂 modem 分区(p1, vfat) 的 /image/。
PRODUCT_COPY_FILES += \
    device/iflytek/MS600/vendor-blobs/firmware/adsp.b00:$(TARGET_COPY_OUT_VENDOR)/firmware/adsp.b00 \
    device/iflytek/MS600/vendor-blobs/firmware/adsp.b01:$(TARGET_COPY_OUT_VENDOR)/firmware/adsp.b01 \
    device/iflytek/MS600/vendor-blobs/firmware/adsp.b02:$(TARGET_COPY_OUT_VENDOR)/firmware/adsp.b02 \
    device/iflytek/MS600/vendor-blobs/firmware/adsp.b03:$(TARGET_COPY_OUT_VENDOR)/firmware/adsp.b03 \
    device/iflytek/MS600/vendor-blobs/firmware/adsp.b04:$(TARGET_COPY_OUT_VENDOR)/firmware/adsp.b04 \
    device/iflytek/MS600/vendor-blobs/firmware/adsp.b05:$(TARGET_COPY_OUT_VENDOR)/firmware/adsp.b05 \
    device/iflytek/MS600/vendor-blobs/firmware/adsp.b06:$(TARGET_COPY_OUT_VENDOR)/firmware/adsp.b06 \
    device/iflytek/MS600/vendor-blobs/firmware/adsp.b07:$(TARGET_COPY_OUT_VENDOR)/firmware/adsp.b07 \
    device/iflytek/MS600/vendor-blobs/firmware/adsp.b08:$(TARGET_COPY_OUT_VENDOR)/firmware/adsp.b08 \
    device/iflytek/MS600/vendor-blobs/firmware/adsp.b09:$(TARGET_COPY_OUT_VENDOR)/firmware/adsp.b09 \
    device/iflytek/MS600/vendor-blobs/firmware/adsp.b10:$(TARGET_COPY_OUT_VENDOR)/firmware/adsp.b10 \
    device/iflytek/MS600/vendor-blobs/firmware/adsp.b11:$(TARGET_COPY_OUT_VENDOR)/firmware/adsp.b11 \
    device/iflytek/MS600/vendor-blobs/firmware/adsp.b12:$(TARGET_COPY_OUT_VENDOR)/firmware/adsp.b12 \
    device/iflytek/MS600/vendor-blobs/firmware/adsp.b13:$(TARGET_COPY_OUT_VENDOR)/firmware/adsp.b13 \
    device/iflytek/MS600/vendor-blobs/firmware/adsp.b14:$(TARGET_COPY_OUT_VENDOR)/firmware/adsp.b14 \
    device/iflytek/MS600/vendor-blobs/firmware/adsp.mdt:$(TARGET_COPY_OUT_VENDOR)/firmware/adsp.mdt \
    device/iflytek/MS600/vendor-blobs/firmware/venus.b00:$(TARGET_COPY_OUT_VENDOR)/firmware/venus.b00 \
    device/iflytek/MS600/vendor-blobs/firmware/venus.b01:$(TARGET_COPY_OUT_VENDOR)/firmware/venus.b01 \
    device/iflytek/MS600/vendor-blobs/firmware/venus.b02:$(TARGET_COPY_OUT_VENDOR)/firmware/venus.b02 \
    device/iflytek/MS600/vendor-blobs/firmware/venus.b03:$(TARGET_COPY_OUT_VENDOR)/firmware/venus.b03 \
    device/iflytek/MS600/vendor-blobs/firmware/venus.b04:$(TARGET_COPY_OUT_VENDOR)/firmware/venus.b04 \
    device/iflytek/MS600/vendor-blobs/firmware/venus.mdt:$(TARGET_COPY_OUT_VENDOR)/firmware/venus.mdt \
    device/iflytek/MS600/vendor-blobs/firmware/wcnss.b00:$(TARGET_COPY_OUT_VENDOR)/firmware/wcnss.b00 \
    device/iflytek/MS600/vendor-blobs/firmware/wcnss.b01:$(TARGET_COPY_OUT_VENDOR)/firmware/wcnss.b01 \
    device/iflytek/MS600/vendor-blobs/firmware/wcnss.b02:$(TARGET_COPY_OUT_VENDOR)/firmware/wcnss.b02 \
    device/iflytek/MS600/vendor-blobs/firmware/wcnss.b04:$(TARGET_COPY_OUT_VENDOR)/firmware/wcnss.b04 \
    device/iflytek/MS600/vendor-blobs/firmware/wcnss.b06:$(TARGET_COPY_OUT_VENDOR)/firmware/wcnss.b06 \
    device/iflytek/MS600/vendor-blobs/firmware/wcnss.b09:$(TARGET_COPY_OUT_VENDOR)/firmware/wcnss.b09 \
    device/iflytek/MS600/vendor-blobs/firmware/wcnss.b10:$(TARGET_COPY_OUT_VENDOR)/firmware/wcnss.b10 \
    device/iflytek/MS600/vendor-blobs/firmware/wcnss.b11:$(TARGET_COPY_OUT_VENDOR)/firmware/wcnss.b11 \
    device/iflytek/MS600/vendor-blobs/firmware/wcnss.b12:$(TARGET_COPY_OUT_VENDOR)/firmware/wcnss.b12 \
    device/iflytek/MS600/vendor-blobs/firmware/wcnss.mdt:$(TARGET_COPY_OUT_VENDOR)/firmware/wcnss.mdt

# 原厂 /vendor/lib/modules/wlan.ko -> pronto/pronto_wlan.ko（我们的镜像缺它）
PRODUCT_COPY_FILES += \
    device/iflytek/MS600/vendor-blobs/lib/modules/pronto/pronto_wlan.ko:$(TARGET_COPY_OUT_VENDOR)/lib/modules/wlan.ko

# ─── MS600_V55_WIFI: WLAN NV 固件 + WCNSS 上电触发 ─────────────────────
# 内核请求 wlan/prima/WCNSS_qcom_wlan_nv.bin（WLAN 校准/NV），
# 原厂在 /vendor/firmware/wlan/prima/ 放的是符号链接 -> /persist/...，
# 而我们的 /persist 缺这两个文件 ⇒ 直接放实体文件（素材取自原厂 persist.img 备份）。
PRODUCT_COPY_FILES += \
    device/iflytek/MS600/vendor-blobs/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin \
    device/iflytek/MS600/vendor-blobs/firmware/wlan/prima/WCNSS_wlan_dictionary.dat:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/prima/WCNSS_wlan_dictionary.dat \
    device/iflytek/MS600/vendor-blobs/firmware/wlan/prima/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/prima/WCNSS_qcom_cfg.ini \
    device/iflytek/MS600/vendor-blobs/bin/ms600_wcnss_boot.sh:$(TARGET_COPY_OUT_VENDOR)/bin/ms600_wcnss_boot.sh \
    device/iflytek/MS600/init.ms600.wifi.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.ms600.wifi.rc

# v63: VNDK libgui —— /linkerconfig/ld.config.txt 里 [vendor] 命名空间的
#      link.vndk 白名单不含 libgui.so，而 camera / media.omx / qdutils_disp 等
#      vendor blob 都需要它 ⇒ 直接把 VNDK 版 libgui 放进 /vendor/lib(64)。
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/gui/libgui.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgui.so

PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/gui/libgui32.so:$(TARGET_COPY_OUT_VENDOR)/lib/libgui.so

# v68: 8.1 stock libui（camera.msm8953.so DT_NEEDED；8.1 libgui 也依赖 8.1 libui 符号）
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/gui/libui32.so:$(TARGET_COPY_OUT_VENDOR)/lib/libui.so

# v69: A11 vndk 的 libutilscallstack/libbacktrace 放 vendor ——
#   8.1 的 libui 需要 CallStack(char const*, int)，A11 把它从 libutils 搬到了
#   libutilscallstack（vndk 白名单有）；而它依赖 libbacktrace（不在白名单）⇒ 一并补进 vendor。
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/libutilscallstack/libutilscallstack.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libutilscallstack.so

PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/libutilscallstack/libutilscallstack32.so:$(TARGET_COPY_OUT_VENDOR)/lib/libutilscallstack.so

PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/libutilscallstack/libbacktrace.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libbacktrace.so

PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/libutilscallstack/libbacktrace32.so:$(TARGET_COPY_OUT_VENDOR)/lib/libbacktrace.so

# v70: A11 system 版 libbinder 进 vendor ——
#   8.1 libgui(camera 依赖) 需要 PermissionCache::checkPermission，
#   而 vndk 版 libbinder 被裁剪掉了它（system 版才有）。同源 A11 版 ⇒ 与 A11 HAL 兼容。
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/libbinder/libbinder.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libbinder.so

PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/libbinder/libbinder32.so:$(TARGET_COPY_OUT_VENDOR)/lib/libbinder.so

# v71: 8.1 媒体栈（mediacodec/OMX 硬解）—— media.omx service 是 32 位 8.1 blob，
#     需要 8.1 的 libmedia_omx(OmxStore ctor) / libstagefright_omx / foundation / xmlparser。
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/media81/32_libmedia_omx.so:$(TARGET_COPY_OUT_VENDOR)/etc/ms600_disabled/32_libmedia_omx.so

PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/media81/32_libstagefright_omx.so:$(TARGET_COPY_OUT_VENDOR)/etc/ms600_disabled/32_libstagefright_omx.so

PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/media81/32_libstagefright_omx_utils.so:$(TARGET_COPY_OUT_VENDOR)/etc/ms600_disabled/32_libstagefright_omx_utils.so

PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/media81/32_libstagefright_foundation.so:$(TARGET_COPY_OUT_VENDOR)/lib/libstagefright_foundation.so

PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/media81/32_libstagefright_xmlparser.so:$(TARGET_COPY_OUT_VENDOR)/etc/ms600_disabled/32_libstagefright_xmlparser.so

# v72: 8.1 libpowermanager（libstagefright_foundation DT_NEEDED 它；A11 里它不在 vendor 可见范围）
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/media81/32_libpowermanager.so:$(TARGET_COPY_OUT_VENDOR)/lib/libpowermanager.so


# v64: AOSP 给老 blob 用的 libstdc++ 兼容桩（A11 已删；原厂放在 system 里）
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/stdcpp/libstdc++_64.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libstdc++.so

PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/stdcpp/libstdc++_32.so:$(TARGET_COPY_OUT_VENDOR)/lib/libstdc++.so

# v65: 从原厂 8.1 system 恢复的库（8.1 时代 HIDL 接口库放在 system 里）
# v101: 【勿恢复】8.1 的 android.hardware.media.omx@1.0.so 会抢占 vendor 命名空间，
#       其 HIDL 回复布局与 A11 客户端不兼容 => createInputSurface 回调静默丢失
#       => screenrecord / 相机录像 "create encoder input surface err=-22"。
#       删掉后 linker 回退到 VNDK apex 的 A11 版本（实测恢复）。
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib81/32_libicui18n.so:$(TARGET_COPY_OUT_VENDOR)/lib/libicui18n.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib81/32_libicuuc.so:$(TARGET_COPY_OUT_VENDOR)/lib/libicuuc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib81/32_vendor.qti.hardware.factory@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.factory@1.0.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib81/64_libicui18n.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libicui18n.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib81/64_libicuuc.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libicuuc.so
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib81/64_vendor.qti.hardware.factory@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.factory@1.0.so

# ─── MS600 v106: modem 固件 / 运营商配置 → /vendor/firmware ──────────────────
# 本机是 SAR，镜像根没有 /firmware（原厂 ramdisk 里才有那个空挂载点目录），
# 造成连锁四层（见 _工具/_fix_v106.py 头注释）。这里不改 fstab（避免 mount_all
# 失败导致启动不了），改成把固件放到内核固件搜索路径里已有的 /vendor/firmware
# —— adsp / venus / wcnss 三家都是这么做的。
MS600_MODEM_FW := $(shell find $(LOCAL_VENDOR_PATH)/firmware_modem -type f 2>/dev/null)
PRODUCT_COPY_FILES += $(foreach f,$(MS600_MODEM_FW),$(f):$(TARGET_COPY_OUT_VENDOR)/firmware/$(patsubst $(LOCAL_VENDOR_PATH)/firmware_modem/%,%,$(f)))

# ─── MS600 v108: 补 vendor 命名空间看不到的 libprotobuf-cpp-full.so ───────────
# v107 实测 rild 报 `library "libprotobuf-cpp-full.so" not found: needed by
# vendor/lib64/libsettings.so`。原因：ld.config.txt 的 [vendor] 段
# permitted.paths = /odm /vendor /system/vendor ⇒ vendor 进程看不到 /system/lib64，
# 而 A11 只把该库装在 /system/lib64（它不在 VNDK apex 里）。原厂 vendor 分区也没有。
# 这里用从原厂 system.img 抽出的 8.1 原版（与原厂 libsettings.so 同源，ABI 匹配）。
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/lib64/libprotobuf-cpp-full.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libprotobuf-cpp-full.so

# ─── MS600 v109: 装回原厂 /vendor/ueventd.rc ────────────────────────────────
# 本 ROM 之前完全没有这份文件，导致 /dev/subsys_*、/dev/qmi*、/dev/smd*、
# /dev/smdcntl* 全是默认 0600 root:root，rild(radio) 全部打不开：
#   E PerMgrLib: modem get service fail
#   E RILQ : qcril_data_qmi_wds_init_qmi_client ... rc=-3
PRODUCT_COPY_FILES += \
    $(LOCAL_VENDOR_PATH)/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc
