#!/system/bin/sh
# MS600 v76 --- QTI BTS 402x 蓝牙芯片初始化（经 WCNSS SMD 通道 /dev/smd3）
#
# 背景：原厂 8.1 没有提供 init.qcom.bt.sh / hciattach 之类的芯片初始化入口，
#   A11 移植里芯片从未被初始化 -> HCI 读回占位 BD_ADDR 00:00:00:00:5A:AD、
#   service_mask:0x0 -> 蓝牙栈启动完被上层判定失败。
#   实测 /vendor/bin/hci_qcomm_init -d /dev/smd3 可完成初始化（得到真实 MAC）。
#   （另需 ro.qualcomm.bt.hci_transport=smd，否则它退回不存在的 /dev/ttyHS0）
#
# 另一个作用：QTI libbt-vendor.so 在 BT_VND_OP_POWER_CTRL 时会 ctl.start hciattach
#   并轮询 init.svc.hciattach；本服务常驻，使它不再空等。

LOG=/data/local/tmp/ms600_bt.log

{
    echo "=== ms600_bt_init $(date) ==="
    echo "transport=$(getprop ro.qualcomm.bt.hci_transport)"

    # 兜底：确保传输选 SMD（ro. 属性只在未设时可写）
    setprop ro.qualcomm.bt.hci_transport smd

    # 等 WCNSS 子系统起来（最多 40s）
    i=0
    while [ $i -lt 80 ]; do
        [ -e /sys/devices/platform/WCNSS_CTRL.6 ] && break
        i=$((i + 1)); sleep 0.5
    done
    # 再等 wcnss-service 跑起来
    i=0
    while [ $i -lt 60 ]; do
        [ "$(getprop init.svc.wcnss-service)" = "running" ] && break
        i=$((i + 1)); sleep 0.5
    done

    # 给蓝牙 rfkill 上电（bt_power 驱动注册的 rfkill0），芯片才肯应答
    [ -w /sys/class/rfkill/rfkill0/state ] && echo 1 > /sys/class/rfkill/rfkill0/state
    echo "rfkill0=$(cat /sys/class/rfkill/rfkill0/state 2>/dev/null)"

    # 初始化芯片：实测前期可能连续失败，必须咬牙重试
    n=0
    while [ $n -lt 30 ]; do
        out=$(/vendor/bin/hci_qcomm_init -d /dev/smd3 2>&1)
        rc=$?
        echo "try$n rc=$rc : $out"
        [ $rc -eq 0 ] && break
        n=$((n + 1)); sleep 3
    done

    echo "--- NV dump ---"
    /vendor/bin/btnvtool -p
    echo "=== done $(date) ==="
} >> "$LOG" 2>&1

# 常驻：保持 init.svc.hciattach = running（QTI vendor lib 会轮询它）
while true; do sleep 3600; done
