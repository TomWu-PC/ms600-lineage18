#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""读 MP4/MOV 的 tkhd 矩阵，算出 MediaRecorder.setOrientationHint 写入的旋转角。
用法: python mp4_rot.py a.mp4 [...]
输出: 每个 trak 的 width/height + rotation(0/90/180/270)
"""
import struct
import sys


def boxes(buf, start, end):
    p = start
    while p + 8 <= end:
        size = struct.unpack(">I", buf[p:p + 4])[0]
        typ = buf[p + 4:p + 8].decode("latin1")
        if size == 1:
            size = struct.unpack(">Q", buf[p + 8:p + 16])[0]
            hdr = 16
        elif size == 0:
            size = end - p
            hdr = 8
        else:
            hdr = 8
        if size < hdr or p + size > end:
            break
        yield typ, p + hdr, p + size
        p += size


def find(buf, start, end, path):
    for typ, b, e in boxes(buf, start, end):
        if typ == path[0]:
            if len(path) == 1:
                return b, e
            r = find(buf, b, e, path[1:])
            if r:
                return r
    return None


def traks(buf):
    moov = find(buf, 0, len(buf), ["moov"])
    if not moov:
        return []
    out = []
    for typ, b, e in boxes(buf, moov[0], moov[1]):
        if typ == "trak":
            out.append((b, e))
    return out


def main():
    for fn in sys.argv[1:]:
        data = open(fn, "rb").read()
        print("==", fn, len(data), "bytes")
        for i, (b, e) in enumerate(traks(data)):
            t = find(data, b, e, ["tkhd"])
            if not t:
                continue
            tb = t[0]
            ver = data[tb]
            # tkhd: ver+flags(4) times/id/res/dur, then reserved(8)+layer..(8), then matrix(36)
            # v0: 4 + 4+4+4+4+4 = 24 ; + reserved(8) = 32 ; + layer/alt/vol/res(8) = 40
            # v1: 4 + 8+8+4+4+8 = 36 ; + reserved(8) = 44 ; + layer/alt/vol/res(8) = 52
            m = tb + (52 if ver == 1 else 40)
            mat = struct.unpack(">9i", data[m:m + 36])
            w = struct.unpack(">I", data[m + 36:m + 40])[0] >> 16
            h = struct.unpack(">I", data[m + 40:m + 44])[0] >> 16
            a, bb, u, c, d, v = mat[0], mat[1], mat[2], mat[3], mat[4], mat[5]
            rot = None
            if a > 32768 and d > 32768:
                rot = 0
            elif a < -32768 and d < -32768:
                rot = 180
            elif b > 32768 and c < -32768:
                rot = 90
            elif b < -32768 and c > 32768:
                rot = 270
            print("   trak%d  %dx%d  matrix=%s  rotation=%s" % (i, w, h, list(mat), rot))


main()
