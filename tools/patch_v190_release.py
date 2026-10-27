#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""v190 正式版收尾：给 ROM 打上可识别的版本标识，便于日后区分正式版与调试版。"""
import io, os, sys

ROOT = os.path.expanduser("~/lineage")
DEVMK = os.path.join(ROOT, "device/iflytek/MS600/device.mk")
MARK = "ro.ms600.rom.version"

def read(p):
    with io.open(p, "r", encoding="utf-8") as f:
        return f.read()

def write(p, s):
    with io.open(p, "w", encoding="utf-8", newline="\n") as f:
        f.write(s)

s = read(DEVMK)
if MARK in s:
    print("[SKIP] 版本标识已存在")
else:
    block = """
# ---------------------------- ROM 版本标识 ----------------------------------
# MS600 v190 正式版。userdebug 构建的 ro.build.version.incremental 在增量编译时
# 不会刷新（缓存在 out/ 里），所以另起一组属性标识正式版，便于日后确认设备跑的
# 到底是哪一版：getprop ro.ms600.rom.version
PRODUCT_PROPERTY_OVERRIDES += \\
    ro.ms600.rom.version=1.0.0-release.20261028 \\
    ro.ms600.rom.channel=release \\
    ro.ms600.rom.note=LineageOS18.1-MS600-full-feature-set
"""
    # 插在 PRODUCT_LOCALES 之前，保持文件结构清晰
    anchor = "\n# 默认语言：简体中文"
    if anchor not in s:
        print("[FAIL] 找不到插入锚点")
        sys.exit(1)
    s = s.replace(anchor, block + anchor, 1)
    write(DEVMK, s)
    print("[OK] 已写入版本标识")

print("---- 校验 ----")
t = read(DEVMK)
for ln in t.split("\n"):
    if "ms600.rom" in ln:
        print(ln)
