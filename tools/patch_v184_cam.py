#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
v184: 相机两处修复
  1) JPEG/录像方向：OrientationManagerImpl 无传感器分支改为 (360 - 屏幕角度)
     AOSP 公式是 (sensorOrientation + deviceOrientation) % 360（加法），
     本机 sensorOrientation=90（MountAngle=90），要得 0 必须 deviceOrientation=270。
  2) 第三方相机兼容：补 android.hardware.camera.back feature
     原厂 blob 只声明 android.hardware.camera.front，导致第三方相机
     hasSystemFeature(FEATURE_CAMERA_BACK)==false ⇒ 直接报"访问相机出错"。
"""
import io, os, re, sys

ROOT = os.path.expanduser("~/lineage")
OMI = os.path.join(ROOT, "packages/apps/Camera2/src/com/android/camera/app/OrientationManagerImpl.java")
DEVMK = os.path.join(ROOT, "device/iflytek/MS600/device.mk")
FEATXML = os.path.join(ROOT, "device/iflytek/MS600/ms600-camera-features.xml")

MARK = "MS600 v184"

def read(p):
    with io.open(p, "r", encoding="utf-8") as f:
        return f.read()

def write(p, s):
    with io.open(p, "w", encoding="utf-8", newline="\n") as f:
        f.write(s)

ok = True

# ---------------- 1) OrientationManagerImpl ----------------
s = read(OMI)
if MARK in s:
    print("[SKIP] OrientationManagerImpl 已打过 v184 补丁")
else:
    old = """            final int displayDeg = CameraUtil.getDisplayRotation();
            final DeviceOrientation fromDisplay = DeviceOrientation.from(displayDeg);"""
    new = """            final int displayDeg = CameraUtil.getDisplayRotation();
            // MS600 v184: 修正换算方向。CameraUtil.getImageRotation 是
            //   (sensorOrientation + deviceOrientation) % 360（加法，不是减法）。
            //   本机 MountAngle=90 ⇒ sensorOrientation=90；屏幕恒 ROTATION_90 时
            //   设备朝向与屏幕角度方向相反 ⇒ deviceOrientation 必须是 270，
            //   才能得 (90 + 270) % 360 = 0（不旋转）。若直接取 90 则算出 180（照片上下颠倒）。
            final DeviceOrientation fromDisplay =
                    DeviceOrientation.from((360 - displayDeg) % 360);"""
    if old not in s:
        print("[FAIL] OrientationManagerImpl 找不到目标片段")
        ok = False
    else:
        s = s.replace(old, new)
        # 顺带修正上面那句写错的注释
        s = s.replace(
            "            //   屏幕 ROTATION_90 ⇒ 设备朝向 90°，代进后置公式 (sensorOrientation - 90) 才得 0。",
            "            //   屏幕 ROTATION_90 ⇒ 设备朝向 270°（二者方向相反），代进公式才得 0。 [MS600 v184]")
        write(OMI, s)
        print("[OK] OrientationManagerImpl 已更新")

# ---------------- 2) camera.back feature ----------------
xml = """<?xml version="1.0" encoding="utf-8"?>
<!-- MS600 v184: 本机唯一 sensor OV13855 已由 HAL 声明为 LENS_FACING_BACK
     （vendor-blobs/etc/camera/camera_config.xml 的 <Position>BACK</Position>），
     但原厂只提供了 android.hardware.camera.front.xml，
     PackageManager 里缺 android.hardware.camera.back ⇒ 第三方相机
     （Simple Camera / Open Camera / CameraX 系）hasSystemFeature 判定失败，
     打开就报"访问相机出错"、预览全黑。这里补上后置相机 feature。 -->
<permissions>
    <feature name="android.hardware.camera.back" />
</permissions>
"""
if os.path.exists(FEATXML) and "camera.back" in read(FEATXML):
    print("[SKIP] feature xml 已存在")
else:
    write(FEATXML, xml)
    print("[OK] 已写入 ms600-camera-features.xml")

s = read(DEVMK)
if "ms600-camera-features.xml" in s:
    print("[SKIP] device.mk 已引用")
else:
    line = ("\n# MS600 v184: 补 android.hardware.camera.back feature（第三方相机兼容）\n"
            "PRODUCT_COPY_FILES += device/iflytek/MS600/ms600-camera-features.xml:"
            "$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/ms600-camera-features.xml\n")
    write(DEVMK, s + line)
    print("[OK] device.mk 已追加 COPY 规则")

sys.exit(0 if ok else 1)
