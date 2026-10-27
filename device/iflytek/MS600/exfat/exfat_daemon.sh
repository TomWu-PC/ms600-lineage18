#!/system/bin/sh
# MS600 · exFAT OTG 自动挂载守护
#
# 背景：内核没有 CONFIG_EXFAT_FS，vold 因此拒绝挂载 exFAT 分区。
# 这里用 userspace 的 FUSE 实现（mount.exfat）接管，绕开内核限制。
#
# 行为：
#   插入 exFAT 分区 -> 自动挂到 /mnt/exfat/<卷标>
#   拔出           -> 自动卸载并清理挂载点
#
# 说明：挂载点位于 /mnt/exfat，root 文件管理器（MT管理器等）可直接访问。
#      Android 的 MediaProvider/SAF 不会把这个卷登记成 "USB 驱动器"，
#      因为那需要 vold 层面支持——见报告。

ROOT=/mnt/exfat
LOG=/data/local/tmp/exfat_daemon.log

pick_bin() {
    for b in /system/bin/mount.exfat \
             /data/adb/modules/exfat/system/bin/mount.exfat \
             /data/local/tmp/mount.exfat; do
        [ -x "$b" ] && { echo "$b"; return; }
    done
    echo ""
}

BIN=$(pick_bin)
if [ -z "$BIN" ]; then
    echo "mount.exfat not found" >> "$LOG"
    exit 1
fi

mkdir -p "$ROOT"
log() { echo "[$(date '+%m-%d %H:%M:%S')] $*" >> "$LOG"; }
log "daemon started, bin=$BIN"

while true; do
    # 1) 扫描所有块设备（sd* 真实 U 盘；loop* 供无 U 盘时自测）
    for dev in /dev/block/sd* /dev/block/loop*; do
        [ -b "$dev" ] || continue
        mount | grep -q "^$dev on " && continue
        fs=$(blkid -o value -s TYPE "$dev" 2>/dev/null)
        [ "$fs" = "exfat" ] || continue
        label=$(blkid -o value -s LABEL "$dev" 2>/dev/null)
        [ -n "$label" ] || label=$(basename "$dev")
        mp="$ROOT/$label"
        # 该挂载点已被占用（同卷标的另一分区 / 旧挂载残留）则跳过，避免叠加挂载
        mount | grep -q " on $mp type " && continue
        mkdir -p "$mp"
        if "$BIN" -o rw,noatime,uid=0,gid=0,nonempty "$dev" "$mp" 2>>"$LOG"; then
            log "mounted $dev -> $mp"
        else
            log "mount FAILED $dev -> $mp"
        fi
    done

    # 2) 设备已消失的挂载点，卸载并删除空目录
    for mp in "$ROOT"/*; do
        [ -d "$mp" ] || continue
        devs=$(mount | sed -n "s|^\(/dev/block/[^ ]*\) on ${mp} type .*|\1|p")
        for dev in $devs; do
            alive=1
            # 真实 U 盘拔出后节点直接消失
            [ -b "$dev" ] || alive=0
            # loop 设备解绑后节点仍在，用 losetup 判定
            case "$dev" in
                /dev/block/loop*) losetup "$dev" >/dev/null 2>&1 || alive=0 ;;
            esac
            if [ "$alive" -eq 0 ]; then
                umount "$mp" 2>/dev/null && log "unmounted stale $mp ($dev)"
            fi
        done
        mount | grep -q " on $mp type " || rmdir "$mp" 2>/dev/null
    done

    sleep 3
done
