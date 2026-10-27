package com.iflytek.ms600.cast.airplay

/**
 * StreamStats — AirPlay 镜像的实时计数器。
 *
 * 镜像视频服务 ([com.iflytek.ms600.cast.airplay.handshake.MirrorStreamServer]) 和音频服务
 * ([com.iflytek.ms600.cast.airplay.handshake.AudioStreamServer]) 在运行时写入这些 volatile 字段；
 * [com.iflytek.ms600.cast.ui.PlayerActivity] 按比例适配 Surface，并在视频信息面板打开时每秒轮询一次，
 * 把累计计数换算成瞬时帧率/码率。纯 volatile 字段保证热路径无锁、无分配。
 */
object StreamStats {
    /** 预留开关：为 true 时才绘制调试 HUD（当前 UI 未使用）。 */
    @Volatile var overlayEnabled = false

    // ─── Video (MirrorStreamServer) ──────────────────────────────────────────
    @Volatile var videoRes = ""        // e.g. "1920x1080"
    @Volatile var videoFps = 0         // frames/sec over the last sample window
    @Volatile var videoQueue = 0       // current decode-queue depth
    @Volatile var videoDropPct = 0     // cumulative % of frames dropped under load

    @Volatile var videoCodec = ""      // 解码器实际使用的 MIME，如 "video/avc"

    // MS600: 解码器实例名与软/硬解判定（投屏信息面板要显示"编码 / 硬解"）。
    // 由 VideoDecoder 在 createDecoderByType 之后写入；名字形如 OMX.qcom.video.decoder.avc。
    @Volatile var videoCodecName = ""
    @Volatile var videoSwDecode = false

    // Actual decoded video dimensions (from the SPS, so portrait phone streams are portrait here).
    // StreamingScreen reads these to aspect-fit the Surface instead of stretching to 16:9.
    @Volatile var videoWidth = 0
    @Volatile var videoHeight = 0

    // 单调累加的原始计数，供 UI 做差分算出瞬时码率/帧率（见 StreamInfoTracker）。
    @Volatile var videoBytesTotal = 0L
    @Volatile var videoFramesTotal = 0L

    // MS600: 解码器送显帧计数 —— Miracast 不经过 ExoPlayer，帧率只能由解码器统计。
    // 单独一个计数器，避免与 MirrorStreamServer 写入的 videoFramesTotal 互相污染。
    @Volatile var decodedFramesTotal = 0L

    // MS600: 解码延迟估算（毫秒）：输入入队时间 → 送显时间的差值。
    @Volatile var decodeLatencyMs = 0L

    // MS600: Miracast P2P 组的工作频率（MHz），由 WifiDirectManager 建组后写入，
    // 供投屏参数面板显示"投屏链路用哪个频段/信道"。
    @Volatile var p2pFrequencyMhz = 0

    // ─── Audio (AudioStreamServer) ───────────────────────────────────────────
    @Volatile var audioActive = false  // true while an audio stream is running
    @Volatile var audioQueue = 0       // current playback-queue depth
    @Volatile var audioDupPct = 0      // % of RTP packets that were redundant duplicates
    @Volatile var audioBytesTotal = 0L // 累计收到的音频 RTP 字节数

    /** Clears per-stream counters (call when a mirror session ends). Keeps [overlayEnabled]. */
    fun resetStreams() {
        videoRes = ""; videoFps = 0; videoQueue = 0; videoDropPct = 0; videoCodec = ""
        videoCodecName = ""; videoSwDecode = false
        videoWidth = 0; videoHeight = 0
        videoBytesTotal = 0L; videoFramesTotal = 0L
        decodedFramesTotal = 0L; decodeLatencyMs = 0L
        audioActive = false; audioQueue = 0; audioDupPct = 0
        audioBytesTotal = 0L
    }

    /** Human-readable multi-line HUD text. */
    fun summary(): String =
        "PhairPlay · debug\n" +
        "VIDEO  ${videoRes.ifEmpty { "—" }}   ${videoFps} fps   q ${videoQueue}   drop ${videoDropPct}%\n" +
        "AUDIO  " + (if (audioActive) "on   q ${audioQueue}   dup ${audioDupPct}%" else "off")
}

