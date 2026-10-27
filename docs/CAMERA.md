# 相机方向修复 v184 · 实测报告

> 2026-10-28 00:15｜system `_产物/18.1_v184_system.img` md5 `2a987539d8546fc4bf94d96fa88fbd52`

## 一、根因：公式是加法，不是减法

AOSP Camera2 算照片旋转用的是（`CameraUtil.java:1307`）：

```
imageRotation = (sensorOrientation + deviceOrientation) % 360
```

- `sensorOrientation` = HAL 的 `MountAngle` = **90**（v183 改的，让预览正立）
- `deviceOrientation` 由 `OrientationManager` 提供，本机**没有 g-sensor**，只能靠屏幕方向推

| 版本 | deviceOrientation | 算出来 | 照片 |
|---|---|---|---|
| v179 | 0（原厂默认） | (270+0)=270* | 逆时针躺 90° |
| v183 | 90（= 屏幕角度） | (90+90)=**180** | **上下颠倒** |
| **v184** | **270（= 360−屏幕角度）** | (90+270)=**0** | **正立** ✅ |

\* v179 时 MountAngle 还是原厂的 270

改动只有一行（`OrientationManagerImpl.resume()`）：

```java
final DeviceOrientation fromDisplay = DeviceOrientation.from((360 - displayDeg) % 360);
```

录像走同一个公式（`VideoModule` → `MediaRecorder.setOrientationHint`），一并修好。

## 二、顺手补的第三方兼容

原厂 vendor 只声明 `android.hardware.camera.front`，**没有 `camera.back`**，
导致第三方 App 的 `hasSystemFeature(FEATURE_CAMERA_BACK)` 返回 false。

新增 `device/iflytek/MS600/ms600-camera-features.xml`（声明 back）→ `system/etc/permissions/`，
`pm list features` 已能看到 `android.hardware.camera.back`。

## 三、实测结果（重启后复测，全部通过）

| 项 | 数据 |
|---|---|
| 拍照 | `CAM_JpegUtilNative: rotation = 0 * 90`、4160×3120、**5.92 MB**、DQT 均值 5.77（≈q95）、画面正立、无断层 |
| 录像 | 1920×1080、tkhd matrix rotation = **0**、播放画面正立（连测两段，含重启后） |
| 预览 | 正立，与成品照片方向一致 |

## 四、第三方相机

| App | 结果 | 原因 |
|---|---|---|
| Simple Camera（CameraX 1.0，2021） | ❌ 预览黑屏 | `CameraValidator` 报 `lensFacingInteger: null` 后放弃初始化 |
| SnapdragonCamera（Android 8 时代） | ❌ 崩溃 | 自身 `System.arraycopy` IllegalAccessError，与相机无关 |
| AOSP Camera2（内置） | ✅ 全部正常 | — |

**系统层已排除嫌疑**：用 `app_process` 写探针直接读 Camera2 API，返回

```
camera count = 1
id=0  LENS_FACING = 1 (BACK)   SENSOR_ORIENTATION = 90   HW_LEVEL = 3   74 keys
```

即 Camera2 接口完全正常，Simple Camera 的 null 是它自己 CameraX 老版本的行为。
另试过用 Magisk 覆盖 vendor 的 front feature（确实让报错消失，但预览仍黑），已回滚删除。

**建议**：装 2022 年以后的相机 App（CameraX ≥1.2 或 Camera1 API）即可；本机 F-Droid 不通，
需要的话可以走手机热点下载 APK 再测。

## 五、环境清理

- Magisk 测试模块 `ms600camfix` 已删除，重启后 `pm list features` 已恢复原厂 front 声明
- `adb root` / `svc power stayon` / `screen_off_timeout` 均已复位
- 设备端调试文件已清空
