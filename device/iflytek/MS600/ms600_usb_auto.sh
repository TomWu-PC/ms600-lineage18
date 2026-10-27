#!/system/bin/sh
# MS600 v154: USB 模式守护 + U 盘模式（USB mass_storage）
#   v154 新增：双 VBUS 自愈（peripheral 却开着 OTG 升压时自动纠正）
#   v155 新增：广告拦截（iptables 关键词拦 SNI/Host），由 App 的开关文件驱动
#   v156 修复：开机太早执行导致 OUTPUT 跳转挂不上（0 references）+ 规则数不足，
#        改为每次统计时核对并自愈，启动先等 3 秒
#
# 为什么需要它：
#   本机 dwc3 驱动没有 extcon / usb_role，硬件不做角色检测，
#   插手柄和插电脑在内核看来是一样的，只能靠软件看"外面有没有 5V 进来"。
#
# 判据（2026-10-18 实测）：
#   host + 空载        -> power_supply/usb/online = 0
#   host + 电脑        -> online = 1  (OTG 升压不会反灌到检测)
#   peripheral + 电脑  -> online = 1
#   peripheral + 空载  -> online = 0
#
# 用户选择（「设备设置 -> USB -> USB 模式」）由 App 写到：
CFG=/data/user/0/com.iflytek.ms600.settings/files/usb_mode
# 「U 盘模式」开关（设备设置 -> USB -> U 盘模式）
MSCF=/data/user/0/com.iflytek.ms600.settings/files/usb_msc
MODE=/sys/devices/soc/7000000.ssusb/mode
USB=/sys/class/power_supply/usb
A=/sys/class/android_usb/android0
LOG=/data/local/tmp/ms600_usb_auto.log
MSC_STATE=/data/local/tmp/ms600_msc.state

# v155：广告拦截。开关由 App 写（0/1），统计由这里写、App 读。
ADBF=/data/user/0/com.iflytek.ms600.settings/files/adblock
ADBSTAT=/data/user/0/com.iflytek.ms600.settings/files/adblock_stat
# v164: 拦截关键词可由「设备设置 → 系统 → 拦截规则」自定义，每行一个写进这个文件
ADB_KEYS_FILE=/data/user/0/com.iflytek.ms600.settings/files/adblock_keys
ADB_CHAIN=ADBLOCK
# 只扫前 256 字节：SNI 在 ClientHello 开头，够用且几乎不影响吞吐（实测 1.6→1.94MB/s）
ADB_SCAN=256
# 出厂默认关键词（用户没有自定义规则文件时用这套；与 App 里的默认值保持一致）
ADB_KEYS_DEFAULT="doubleclick googleadservices googlesyndication google-analytics cpro.baidu.com pos.baidu.com tanx.com alimama.com pangolin.snssdk gromore.snssdk gdt.qq.com"
# 当前生效的规则（由 adblock_load_keys 填）
ADB_KEYS=""
# 本轮规则内容是否变化（变了就强制重建一次 iptables）
ADB_KEYS_CHANGED=0
# 每个关键词 x (80,443) 两条，用来判断规则是否装全了
ADB_EXPECT=$(( $(echo $ADB_KEYS_DEFAULT | wc -w) * 2 ))

# v164: 重新读用户规则。文件不存在/空 → 回退出厂列表。
#   主循环每轮都会调，App 改完关键词后下一轮（约 3 秒）自动生效。
adblock_load_keys() {
    _k=""
    if [ -s "$ADB_KEYS_FILE" ]; then
        _k=$(grep -v '^[[:space:]]*#' "$ADB_KEYS_FILE" 2>/dev/null | tr '\n' ' ')
    fi
    _k=$(echo $_k)
    [ -n "$_k" ] || _k="$ADB_KEYS_DEFAULT"
    # 只在内容变化时置 1，没变化时【不要】清 0：
    #   主循环每轮都会调本函数，而 adblock_stat 只在每 3 轮跑一次，
    #   若这里把标记清掉，等到 adblock_stat 时标记已经是 0，改规则就永远不生效
    #   （v164 首版实测踩过：改了关键词 iptables 一直不动）。清 0 由 adblock_stat 重建后负责。
    if [ "$_k" != "$ADB_KEYS" ]; then
        ADB_KEYS_CHANGED=1
    fi
    ADB_KEYS="$_k"
    ADB_EXPECT=$(( $(echo $_k | wc -w) * 2 ))
}

log() { echo "$(date '+%m-%d %H:%M:%S') $*" >> "$LOG"; }

# App 在受限存储下看不到 /storage/<uuid>，所以容量由这里（root）算好写进 App 目录。
# 格式：internal <usedKB> <totalKB> / sd <label|- > <usedKB> <totalKB>
STORAGE=/data/user/0/com.iflytek.ms600.settings/files/storage.txt
dump_storage() {
    int=$(df -k /data 2>/dev/null | awk 'NR==2{print $3" "$2}')
    [ -n "$int" ] || int="0 0"
    pub=$(sm list-volumes all 2>/dev/null | awk '$1 ~ /^public:/ && $2 == "mounted" {print $3; exit}')
    if [ -n "$pub" ]; then
        sd=$(df -k "/storage/$pub" 2>/dev/null | awk 'NR==2{print $3" "$2}')
        [ -n "$sd" ] || sd="0 0"
        set -- $sd
        printf 'internal %s\nsd %s %s %s\n' "$int" "$pub" "$1" "$2" > "$STORAGE.tmp" 2>/dev/null
    else
        printf 'internal %s\nsd - 0 0\n' "$int" > "$STORAGE.tmp" 2>/dev/null
    fi
    if [ -s "$STORAGE.tmp" ]; then
        chmod 0644 "$STORAGE.tmp" 2>/dev/null
        mv "$STORAGE.tmp" "$STORAGE" 2>/dev/null
    fi
}

# ⚠️ 切模式必须经过 none 中转：直接 host -> peripheral 时 gadget 不重新枚举，
#    PC 上 kernel_state=DISCONNECTED，看不到 adb（实测）。
set_mode() {
    _t="$1"
    _cur=$(cat "$MODE" 2>/dev/null)
    _otg=$(cat "$USB/usb_otg" 2>/dev/null)
    # v154：不能"mode 相同就跳过"。实测会出现 mode=peripheral 但 usb_otg=1
    # （dwc3 没把退出 host 的事件通知到 charger，升压一直开着），
    # 这时端口一边当外设一边往 VBUS 灌 5V = 双 VBUS，主机会直接关端口。
    # 所以判"已经到位"必须连升压一起看。
    if [ "$_cur" = "$_t" ] && { [ "$_t" != "peripheral" ] || [ "$_otg" = "0" ]; }; then
        return 0
    fi
    if [ "$_t" = "peripheral" ]; then
        # 先显式关升压，再切角色，最后再复查一次
        echo 0 > "$USB/usb_otg" 2>/dev/null
        sleep 1
    fi
    echo none > "$MODE"
    sleep 1
    echo "$_t" > "$MODE"
    if [ "$_t" = "peripheral" ]; then
        sleep 1
        [ "$(cat "$USB/usb_otg" 2>/dev/null)" = "1" ] && echo 0 > "$USB/usb_otg" 2>/dev/null
    fi
}

# ---------------------------------------------------------------- gadget
# 注意：idVendor/idProduct 由内核按 4 位十六进制解析，写 "18D1" 这种形式。
gadget_adb() {
    echo 0 > $A/enable 2>/dev/null
    echo 18D1 > $A/idVendor
    echo 4EE7 > $A/idProduct
    echo Android > $A/iProduct
    echo ffs > $A/functions
    echo 1 > $A/enable
}

# 找 SD 卡上能直接给 Windows 看的那个分区（vfat / exfat）
find_sd() {
    for p in /dev/block/mmcblk1p1 /dev/block/mmcblk1p2 /dev/block/mmcblk1p3; do
        [ -b "$p" ] || continue
        case "$(blkid "$p" 2>/dev/null)" in
            *vfat*|*exfat*) echo "$p"; return 0 ;;
        esac
    done
    [ -b /dev/block/mmcblk1 ] && echo /dev/block/mmcblk1
}

gadget_msc() {
    # 调试钩子：/data/local/tmp/ms600_msc_dev 里写一个块设备或镜像文件路径，
    # 就用它代替 SD 卡（用于没有公共分区时验证整条链路，不碰用户数据）。
    if [ -f /data/local/tmp/ms600_msc_dev ]; then
        dev=$(cat /data/local/tmp/ms600_msc_dev 2>/dev/null)
        log "msc: using override dev=$dev"
    else
        # 安全闸：只允许把「便携存储（public）」暴露给电脑。
        # 卡如果是「内部存储（adopted/private）」，暴露出去 Windows 看到的是加密分区，
        # 还会诱导用户格式化 ⇒ 直接拒绝。
        if ! sm list-volumes all 2>/dev/null | grep -q "^public:"; then
            log "msc: refused (no public volume; sd is adopted?)"
            return 1
        fi
        dev=$(find_sd)
        # 先把 vold 挂着的卷卸掉，否则 Windows 与 Linux 同时写会写坏
        : > $MSC_STATE
        for v in $(sm list-volumes all 2>/dev/null | awk '/mounted/{print $1}'); do
            case "$v" in
                public:*|private:*)
                    if sm unmount "$v" >/dev/null 2>&1; then
                        echo "$v" >> $MSC_STATE
                        log "msc: unmounted $v"
                    fi
                    ;;
            esac
        done
    fi
    if [ -z "$dev" ]; then
        log "msc: no sd device"
        return 1
    fi
    sleep 1
    echo 0 > $A/enable
    # 用 Linux File-Stor Gadget 的标准 ID：Windows 会直接绑自带的 U 盘驱动。
    # （用 18D1 会被 Google 的 Android 驱动抢去当 ADB 接口，磁盘不出现 —— 实测过）
    echo 0525 > $A/idVendor
    echo A4A5 > $A/idProduct
    echo "MS600 SD Card" > $A/iProduct
    echo MS600 > $A/iManufacturer
    echo mass_storage > $A/functions
    echo "$dev" > $A/f_mass_storage/lun/file
    echo 1 > $A/enable
    log "msc: on ($dev)"
}

gadget_msc_off() {
    echo 0 > $A/enable 2>/dev/null
    echo 18D1 > $A/idVendor
    echo 4EE7 > $A/idProduct
    echo Android > $A/iProduct
    echo ffs > $A/functions
    echo 1 > $A/enable
    if [ -s $MSC_STATE ]; then
        while read -r v; do
            [ -n "$v" ] && sm mount "$v" >/dev/null 2>&1 && log "msc: remounted $v"
        done < $MSC_STATE
    fi
    : > $MSC_STATE
    log "msc: off"
}

# U 盘开关文件由 App 写、这里读。⚠️ 本脚本以 root 跑，创建出来的文件默认是
# 0600 root:root，App（u0_a80）写不进去会被 EACCES 打回 —— 必须放开到 0666。
set_msc_flag() {
    printf '%s\n' "$1" > "$MSCF" 2>/dev/null
    chmod 0666 "$MSCF" 2>/dev/null
}

# ---------------------------------------------------------------- v155 广告拦截
# 原理：HTTP 看明文 Host，HTTPS 看 TLS ClientHello 里的 SNI（明文）。
# ⚠️ 千万别加 -m conntrack --ctstate NEW：TCP 的 SYN 不带 payload，
#    第一个含 SNI 的包状态已经是 ESTABLISHED，加了就一条都匹配不到（踩过）。
adblock_build() {
    iptables -N "$ADB_CHAIN" 2>/dev/null
    iptables -F "$ADB_CHAIN" 2>/dev/null
    _n=0
    for _k in $ADB_KEYS; do
        for _p in 80 443; do
            iptables -A "$ADB_CHAIN" -p tcp --dport "$_p" \
                -m string --string "$_k" --algo bm --to "$ADB_SCAN" \
                -j DROP 2>/dev/null && _n=$((_n + 1))
        done
    done
    if ! iptables -C OUTPUT -j "$ADB_CHAIN" 2>/dev/null; then
        iptables -I OUTPUT 1 -j "$ADB_CHAIN" 2>/dev/null || \
            ( sleep 1; iptables -I OUTPUT 1 -j "$ADB_CHAIN" 2>/dev/null )
    fi
    log "adblock: on ($_n/$ADB_EXPECT rules)"
}

adblock_off() {
    iptables -D OUTPUT -j "$ADB_CHAIN" 2>/dev/null
    iptables -F "$ADB_CHAIN" 2>/dev/null
    iptables -X "$ADB_CHAIN" 2>/dev/null
    log "adblock: off"
}

# 写给 App：第一行 "状态(1/0) 规则数 命中包数"
#
# ⚠️ 这里顺手做自愈。实测（2026-10-26 13:35）：开机后 1 秒执行 adblock_build 时，
#    iptables 的 filter 表还没完全就绪，`-I OUTPUT -j ADBLOCK` 会报
#    "No chain/target/match by that name" 而失败 —— 链建好了、规则也在，
#    但 OUTPUT 里那条跳转没挂上（ADBLOCK 显示 0 references），于是完全没效果。
#    而且规则也会少一两条。所以每次刷统计都核对一遍，不对就重建。
adblock_stat() {
    _want=0
    grep -q "^1" "$ADBF" 2>/dev/null && _want=1

    if [ "$_want" = "1" ]; then
        _on=0
        iptables -C OUTPUT -j "$ADB_CHAIN" 2>/dev/null && _on=1
        _cnt=$(iptables -L "$ADB_CHAIN" -n 2>/dev/null | grep -c DROP)
        # v164: ADB_KEYS_CHANGED=1 表示用户在 App 里改过关键词，
        #   此时不管规则数够不够都要重建一次，否则 iptables 里还是旧规则。
        if [ "$ADB_KEYS_CHANGED" = "1" ] || [ "$_on" != "1" ] || [ "$_cnt" -lt "$ADB_EXPECT" ]; then
            adblock_build
            ADB_KEYS_CHANGED=0
            iptables -C OUTPUT -j "$ADB_CHAIN" 2>/dev/null && _on=1
        fi
    else
        _on=0
    fi

    if [ "$_on" = "1" ]; then
        _r=$(iptables -L "$ADB_CHAIN" -n 2>/dev/null | grep -c DROP)
        _hit=$(iptables -L "$ADB_CHAIN" -n -v 2>/dev/null | awk 'NR>2 {s+=$1} END {printf "%d", s+0}')
    else
        _r=0
        _hit=0
    fi
    printf '%s %s %s\n' "$_on" "$_r" "$_hit" > "$ADBSTAT.tmp" 2>/dev/null
    chmod 0644 "$ADBSTAT.tmp" 2>/dev/null
    mv "$ADBSTAT.tmp" "$ADBSTAT" 2>/dev/null
}

# ---------------------------------------------------------------- main
log "=== ms600_usb_auto start (pid $$) ==="
# 等 iptables/网络子系统就绪（开机后过早操作 filter 表会失败）
sleep 3
# 开机不进 U 盘模式：否则每次开机 SD 卡都处于卸载状态，App 看不到
set_msc_flag 0
: > $MSC_STATE

idle=0
msc=0
tick=0
adbon=-1     # -1 = 未知，首轮一定执行一次（把 /data 里的持久开关应用上）

while true; do
    # 每 5 秒刷新一次存储容量（给「设备设置 -> 存储」用）
    tick=$((tick + 1))
    if [ $((tick % 5)) -eq 1 ]; then
        dump_storage
    fi

    # v164：每轮重读自定义拦截规则（App 改完关键词约 3 秒内生效）
    adblock_load_keys

    # v155：广告拦截开关 + 统计（App 只写一个 0/1 文件，规则由 root 这边落）
    _aw=0
    grep -q "^1" "$ADBF" 2>/dev/null && _aw=1
    if [ "$_aw" != "$adbon" ]; then
        if [ "$_aw" = "1" ]; then
            adblock_build
        else
            adblock_off
        fi
        adbon=$_aw
        adblock_stat
    elif [ $((tick % 3)) -eq 1 ]; then
        adblock_stat
    fi

    want=0
    grep -q "^1" "$MSCF" 2>/dev/null && want=1

    if [ "$want" = "1" ] && [ "$msc" = "0" ]; then
        if [ "$(cat "$MODE" 2>/dev/null)" != "peripheral" ]; then
            set_mode peripheral
        fi
        if gadget_msc; then
            msc=1
        else
            log "msc: failed, revert"
            set_msc_flag 0
        fi
    elif [ "$want" = "0" ] && [ "$msc" = "1" ]; then
        gadget_msc_off
        msc=0
    fi

    # U 盘模式下不参与 host/peripheral 自动切换（端口必须保持在从机）
    if [ "$msc" = "1" ]; then
        idle=0
        sleep 1
        continue
    fi

    # ---- v154：双 VBUS 自愈（优先级最高）----
    # 症状：mode=peripheral 但 charger 的 OTG 升压还开着（usb_otg=1）。
    # 后果：主机 VBUS 上有两个 5V 源 → 限流开关触发 → 端口关断，
    #       表现为"设备压根不出现"（不是未知设备，是枚举都不发生）。
    # 陷阱：此时 online 仍读成 1，所以老的 online 判据永远发现不了，
    #       必须直接看 usb_otg 这个节点。
    _mode=$(cat "$MODE" 2>/dev/null)
    _otg=$(cat "$USB/usb_otg" 2>/dev/null)
    if [ "$_otg" = "1" ] && [ "$_mode" = "peripheral" ]; then
        log "heal: dual-VBUS (peripheral + otg=1) -> fix"
        echo 0 > "$USB/usb_otg" 2>/dev/null
        echo none > "$MODE"
        sleep 1
        echo peripheral > "$MODE"
        sleep 1
        [ "$(cat "$USB/usb_otg" 2>/dev/null)" = "1" ] && echo 0 > "$USB/usb_otg" 2>/dev/null
        log "heal: done mode=$(cat "$MODE" 2>/dev/null) otg=$(cat "$USB/usb_otg" 2>/dev/null)"
        idle=0
        sleep 1
        continue
    fi

    cfg=$(cat "$CFG" 2>/dev/null)
    cur=$(cat "$MODE" 2>/dev/null)
    on=$(cat "$USB/online" 2>/dev/null)

    case "$cfg" in
        host)
            if [ "$cur" != "host" ]; then
                set_mode host
                log "forced -> host"
            fi
            idle=0
            ;;
        peripheral)
            if [ "$cur" != "peripheral" ]; then
                set_mode peripheral
                log "forced -> peripheral"
            fi
            idle=0
            ;;
        *)
            # auto：外部 5V 来了 -> 从机；没了 -> 回主机（稳定 3 秒，避免抖）
            if [ "$on" = "1" ] && [ "$cur" = "host" ]; then
                set_mode peripheral
                log "auto: VBUS in  -> peripheral"
                idle=0
            elif [ "$on" = "0" ] && [ "$cur" != "host" ]; then
                idle=$((idle + 1))
                # v154：3 秒太短。gadget 重配（切 sys.usb.config）会让 online
                # 瞬间掉 0，3 秒后就被误判成"拔线"切 host，升压随之打开，
                # 紧接着的切回就留下双 VBUS。放宽到 5 秒。
                if [ "$idle" -ge 5 ]; then
                    set_mode host
                    log "auto: VBUS out -> host (was $cur)"
                    idle=0
                fi
            else
                idle=0
            fi
            ;;
    esac

    sleep 1
done
