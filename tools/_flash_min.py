# -*- coding: utf-8 -*-
"""_flash_min.py — 只做「校验 md5 -> 进 bootloader -> 刷 system -> 重启」，不做后续验证。

用法: python _flash_min.py <img绝对路径> <期望md5>
（把验证拆出去，避免刷完后卡在 adb 阶段；刷写本身仍强制校验 8/8 OKAY）
"""
import hashlib
import subprocess
import sys
import time

ADB = r'<path>/AppData/Local/Android/Sdk/platform-tools/adb.exe'
FB = r'<path>/AppData/Local/Android/Sdk/platform-tools/fastboot.exe'


def run(c, t=600):
    try:
        p = subprocess.run(c, shell=True, capture_output=True, timeout=t)
        return ((p.stdout or b'') + (p.stderr or b'')).decode('utf-8', 'ignore').strip()
    except Exception as e:
        return 'ERR:%s' % e


def sh(c, t=30):
    return run('"%s" shell "%s"' % (ADB, c), t)


IMG, WANT = sys.argv[1], sys.argv[2]

h = hashlib.md5()
with open(IMG, 'rb') as f:
    for c in iter(lambda: f.read(1 << 20), b''):
        h.update(c)
got = h.hexdigest()
print('md5 %s %s' % (got, 'OK' if got == WANT else 'MISMATCH'), flush=True)
if got != WANT:
    sys.exit(1)

# 设备已在 fastboot？
in_fb = 'fastboot' in run('"%s" devices' % FB, 20)
if not in_fb:
    print('下发 reboot,bootloader', flush=True)
    sh('setprop sys.powerctl reboot,bootloader', 20)
    for i in range(45):
        time.sleep(2)
        if 'fastboot' in run('"%s" devices' % FB, 20):
            in_fb = True
            break
if not in_fb:
    print('!! 未进入 fastboot')
    sys.exit(2)
print('fastboot 就绪', flush=True)

out = run('"%s" flash system "%s"' % (FB, IMG), 1800)
print(out[-300:], flush=True)
oka = out.upper().count('OKAY')
if 'FAILED' in out.upper() or oka < 8:
    print('!! FAILED 或 OKAY=%d，重刷' % oka, flush=True)
    o2 = run('"%s" flash system "%s"' % (FB, IMG), 1800)
    print(o2[-300:], flush=True)
    if o2.upper().count('OKAY') < 8 or 'FAILED' in o2.upper():
        print('!! 重刷仍失败，不要重启')
        sys.exit(4)
print('OKAY=%d (期望8)' % oka, flush=True)
print(run('"%s" reboot' % FB, 60), flush=True)
print('DONE', flush=True)
