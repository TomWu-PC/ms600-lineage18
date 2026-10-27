package com.iflytek.ms600.cast.ui

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.ActivityInfo
import android.content.res.Configuration
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.SystemClock
import android.view.KeyEvent
import android.view.MotionEvent
import android.view.PixelCopy
import android.view.WindowManager
import android.view.View
import android.widget.Button
import android.widget.ImageButton
import android.widget.ImageView
import android.widget.ProgressBar
import android.widget.TextView
import android.widget.Toast
import android.view.Surface
import android.view.SurfaceHolder
import android.view.SurfaceView
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import androidx.lifecycle.lifecycleScope
import androidx.media3.common.Format
import androidx.media3.common.MediaItem
import androidx.media3.common.MimeTypes
import androidx.media3.common.PlaybackException
import androidx.media3.common.Player
import androidx.media3.exoplayer.DefaultLoadControl
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.exoplayer.analytics.AnalyticsListener
import androidx.media3.exoplayer.trackselection.DefaultTrackSelector
import androidx.media3.ui.AspectRatioFrameLayout
import androidx.media3.ui.PlayerView
import com.iflytek.ms600.cast.R
import com.iflytek.ms600.cast.airplay.StreamStats
import com.iflytek.ms600.cast.miracast.RtpReceiver
import com.iflytek.ms600.cast.util.AppSettings
import kotlin.coroutines.resume
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.withContext
import timber.log.Timber
import java.net.URL

/**
 * 投屏播放页面
 */
class PlayerActivity : AppCompatActivity() {

    companion object {
        const val EXTRA_MEDIA_URI = "media_uri"
        const val EXTRA_MEDIA_TITLE = "media_title"
        const val EXTRA_MEDIA_URIS = "media_uris"
        const val EXTRA_MEDIA_TITLES = "media_titles"
        const val EXTRA_START_INDEX = "start_index"
        const val EXTRA_IS_AIRPLAY_MIRROR = "is_airplay_mirror"

        // Miracast 额外参数
        const val EXTRA_SOURCE_TYPE = "SOURCE_TYPE"
        const val EXTRA_RTP_PORT = "RTP_PORT"
        const val EXTRA_SESSION_ID = "SESSION_ID"

        // 广播 Action
        const val ACTION_PLAY = "com.iflytek.ms600.cast.ACTION_PLAY"
        const val ACTION_PAUSE = "com.iflytek.ms600.cast.ACTION_PAUSE"
        const val ACTION_STOP = "com.iflytek.ms600.cast.ACTION_STOP"
        const val ACTION_SEEK = "com.iflytek.ms600.cast.ACTION_SEEK"
        const val ACTION_SET_VOLUME = "com.iflytek.ms600.cast.ACTION_SET_VOLUME"
        const val ACTION_SET_PLAYLIST = "com.iflytek.ms600.cast.ACTION_SET_PLAYLIST"
        const val ACTION_SET_SPEED = "com.iflytek.ms600.cast.ACTION_SET_SPEED"
        const val ACTION_SET_QUALITY_URL = "com.iflytek.ms600.cast.ACTION_SET_QUALITY_URL"

        const val EXTRA_SEEK_POSITION = "seek_position"
        const val EXTRA_VOLUME = "volume"
        const val EXTRA_SPEED = "speed"
        const val EXTRA_QUALITY_URI = "quality_uri"

        @Volatile
        var mirrorSurface: Surface? = null
            private set

        private const val IMAGE_SLIDE_INTERVAL_MS = 5_000L
        private const val QUALITY_AUTO = -1

        // Kodi 风格连续快进快退：短时间内连续按键会加大跳转步长
        private const val SEEK_ACCEL_WINDOW_MS = 1_500L
        private const val SEEK_COMMIT_DELAY_MS = 500L
        private val SEEK_STEP_TABLE_MS = longArrayOf(10_000L, 30_000L, 60_000L, 120_000L, 300_000L)

        private const val ACTION_PLAYBACK_STOPPED = "com.iflytek.ms600.cast.ACTION_PLAYBACK_STOPPED"

        // MS600: 镜像画面的缩放模式
        private const val SCALE_FIT = 0      // 适应：等比缩放并留边（配合下面的裁切挡位）
        private const val SCALE_FILL = 1     // 铺满：等比放大铺满屏幕并裁切溢出
        private const val SCALE_16_9 = 2     // 16:9：按 16:9 框等比缩放

        /** 超级按钮无操作后自动淡出的时间。 */
        private const val SUPER_HIDE_DELAY_MS = 4_000L

    }

    private lateinit var playerView: PlayerView
    private lateinit var mirrorSurfaceView: SurfaceView
    private lateinit var imageView: ImageView
    private lateinit var tvStatus: TextView
    private lateinit var tvTitle: TextView
    private lateinit var progressBar: ProgressBar
    private lateinit var tvError: TextView
    private lateinit var tvStreamInfo: TextView
    /** v1.2.33：手势提示（亮度/音量/暂停）。 */
    private lateinit var tvGestureHint: TextView
    private lateinit var bufferingIndicator: ProgressBar

    // MS600: 镜像投屏时的超级按钮与投屏菜单（左侧菜单 + 右侧信息）
    private lateinit var panelCast: View
    private lateinit var castInfoPanel: View
    private lateinit var castMenuRows: android.widget.LinearLayout
    private lateinit var castInfoRows: android.widget.LinearLayout

    private var player: ExoPlayer? = null
    private var trackSelector: DefaultTrackSelector? = null
    private var mediaUri: String? = null
    private var mediaTitle: String? = null
    private var playlist: List<String> = emptyList()
    private var playlistTitles: List<String> = emptyList()
    private var currentIndex: Int = 0
    private var slideJob: Job? = null
    private var progressUpdateJob: Job? = null
    private var isMiracastSession = false
    private var isAirPlayMirrorSession = false
    private var mirrorAspectJob: Job? = null
    private var contentDetectJob: Job? = null
    private var currentSpeed = 1f

    // ─── v1.2.35：流内黑边自动识别 ─────────────────────────────────────────
    // 投屏源经常把画面缩到 80%~90% 再在四周补黑边（实测 B 站投上来的 1920x1080 流，
    // 真实内容只有 1537x866，四周各一圈黑边）。这类黑边是**编码进流里**的，
    // 光改 Surface 尺寸永远消不掉 —— 必须量出真实内容边界，再按内容去放大。
    // 四个值都是相对整幅画面的归一化坐标，默认 (0,0)-(1,1) 表示"没有黑边"。
    private var contentL = 0f
    private var contentT = 0f
    private var contentR = 1f
    private var contentB = 1f
    private var contentProbed = false
    /** 探测轮次，只用于日志 */
    private var attemptNo = 0
    /** 黑边探测用的缩略图尺寸（越小越省，128×96 足够分辨 1% 级别的边） */
    private val PROBE_W = 128
    private val PROBE_H = 96
    /** 亮度阈值：黑边是编码器补的纯黑（0~3），给点余量 */
    private val BLACK_TH = 10
    /** 一行里亮像素超过 6% 就不算黑边行 —— 宁可少裁，不可误裁 */
    private val BLACK_RATIO = 0.06f

    // 视频流信息面板
    private val streamInfoTracker = StreamInfoTracker()
    private var streamInfoJob: Job? = null
    private var isStreamInfoVisible = false
    private var bandwidthEstimateBps = 0L

    // Kodi 风格连续快进快退状态
    private var pendingSeekDeltaMs = 0L
    private var seekAccelerationStep = 0
    private var lastSeekWasForward = true
    private var lastSeekPressAt = 0L
    private var seekCommitJob: Job? = null
    private var isControllerVisible = false
    private var isDialogShowing = false

    // ─── MS600: 镜像投屏的显示控制（缩放 / 沉浸 / 超级按钮）──────────────────
    private val uiHandler = Handler(Looper.getMainLooper())
    private var scaleMode = SCALE_FIT

    /** 左右裁切挡位（索引指向 [AppSettings.CUT_W_STEPS]）。 */

    /** 上下裁切挡位（索引指向 [AppSettings.CUT_H_STEPS]）。 */
    private var castInfoJob: Job? = null
    private var lastParentW = 0
    private var lastParentH = 0

    /** 投屏参数面板专用采样器（与「视频信息」面板分开，避免互相干扰导致码率跳变）。 */
    private val castInfoTracker = StreamInfoTracker()

    // 裁切：由「左右 / 上下」两个挡位直接给出（每边裁掉的比例），不再做任何画面分析。
    // 不用第二个解码器、不抓屏、不定时轮询像素 —— 这是保证投屏流畅的关键。

    private val controlReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            when (intent?.action) {
                ACTION_PLAY -> if (isCurrentImage()) startImageSlideShow() else player?.play()
                ACTION_PAUSE -> if (isCurrentImage()) stopImageSlideShow() else player?.pause()
                ACTION_STOP -> {
                    stopPlayback()
                    finish()
                }
                ACTION_SEEK -> {
                    val position = intent.getLongExtra(EXTRA_SEEK_POSITION, 0L)
                    player?.seekTo(position)
                    reportPlaybackPosition()
                }
                ACTION_SET_VOLUME -> {
                    val volume = intent.getIntExtra(EXTRA_VOLUME, 50)
                    player?.volume = volume / 100f
                }
                ACTION_SET_PLAYLIST -> handleIntent(intent)
                ACTION_SET_SPEED -> {
                    val speed = intent.getFloatExtra(EXTRA_SPEED, 1f).coerceIn(0.25f, 4f)
                    player?.setPlaybackSpeed(speed)
                    currentSpeed = speed
                    tvStatus.text = "播放速度：${speed}x"
                    reportPlaybackPosition()
                }
                ACTION_SET_QUALITY_URL -> {
                    val uri = intent.getStringExtra(EXTRA_QUALITY_URI)
                    if (!uri.isNullOrBlank()) {
                        playMedia(uri)
                    }
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_player)

        initViews()
        initPlayer()
        handleIntent(intent)
        registerControlReceiver()

        Timber.i("PlayerActivity created")
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        handleIntent(intent)
    }

    private fun initViews() {
        playerView = findViewById(R.id.player_view)
        mirrorSurfaceView = findViewById(R.id.airplay_mirror_surface)
        imageView = findViewById(R.id.image_view)
        tvStatus = findViewById(R.id.tv_status)
        tvTitle = findViewById(R.id.tv_title)
        progressBar = findViewById(R.id.progress_bar)
        tvError = findViewById(R.id.tv_error)
        tvStreamInfo = findViewById(R.id.tv_stream_info)
        tvGestureHint = findViewById(R.id.tv_gesture_hint)
        bufferingIndicator = findViewById(R.id.buffering_indicator)

        // MS600: 超级按钮 / 投屏菜单
        panelCast = findViewById(R.id.panel_cast)
        castInfoPanel = findViewById(R.id.cast_info_panel)
        castMenuRows = findViewById(R.id.cast_menu_rows)
        castInfoRows = findViewById(R.id.cast_info_rows)
        // v1.2.32：只保留画面模式；裁切挡位与反控的初始化已移除。
        // 旧版本存过 3（拉伸），现在最多三档（0/1/2），越界值回退到「适应」。
        scaleMode = AppSettings.getMirrorScaleMode(this).coerceIn(SCALE_FIT, SCALE_16_9)
        buildCastMenu()

    }

    /** 是否处于「镜像」投屏（Miracast / AirPlay 屏幕镜像），只有这种情形才需要显示控制条。 */
    private fun isMirrorSession(): Boolean = isMiracastSession || isAirPlayMirrorSession

    /**
     * @param lowLatency 实时投屏（Miracast）用。默认的缓冲策略是为点播设计的
     *   （起播要缓冲 2.5 秒、重缓冲后要 5 秒），而实时流的数据严格按实时速率到达，
     *   永远攒不出那么多缓冲，会陷入「解几帧 → 缓冲耗尽 → 转圈」的循环。
     */
    private fun initPlayer(lowLatency: Boolean = false) {
        player?.release()

        // 默认不限制分辨率（对应画质菜单的「自动」）。原先默认 setMaxVideoSizeSd() 会把所有
        // 播放压到标清，Miracast 的 1080p 视频轨会被直接排除，导致选不出轨道、
        // loader 停止加载，最终报 "stuck buffering and not loading"。
        trackSelector = DefaultTrackSelector(this).apply {
            setParameters(buildUponParameters().clearVideoSizeConstraints())
        }

        val loadControl = DefaultLoadControl.Builder()
            .apply {
                if (lowLatency) {
                    // maxBufferMs 不能压太小：到达上限后 ExoPlayer 会停止读取数据源，
                    // 而 RTP 仍按实时速率灌进管道，管道溢出丢数据就会把 TS 流打出空洞，
                    // 解码器拿不到完整 PES 直接黑屏。留出足够余量让它持续排空管道。
                    setBufferDurationsMs(
                        /* minBufferMs = */ 1_000,
                        /* maxBufferMs = */ 8_000,
                        /* bufferForPlaybackMs = */ 500,
                        /* bufferForPlaybackAfterRebufferMs = */ 1_000
                    )
                    setPrioritizeTimeOverSizeThresholds(true)
                }
            }
            .build()

        player = ExoPlayer.Builder(this)
            .setTrackSelector(trackSelector!!)
            .setLoadControl(loadControl)
            .build()
            .apply {
                addListener(object : Player.Listener {
                    override fun onPlaybackStateChanged(playbackState: Int) {
                        updateBufferingState(playbackState == Player.STATE_BUFFERING)
                        when (playbackState) {
                            Player.STATE_IDLE -> Timber.d("Player state: IDLE")
                            Player.STATE_BUFFERING -> {
                                Timber.d("Player state: BUFFERING")
                                tvStatus.text = "正在缓冲..."
                            }
                            Player.STATE_READY -> {
                                Timber.d("Player state: READY")
                                tvError.visibility = View.GONE
                                tvStatus.text = getString(R.string.playing)
                                adaptOrientationToVideo()
                                startProgressUpdates()
                            }
                            Player.STATE_ENDED -> {
                                Timber.d("Player state: ENDED")
                                tvStatus.text = "播放完成"
                                reportPlaybackPosition()
                                playNextOrFinish()
                            }
                        }
                    }

                    override fun onIsPlayingChanged(isPlaying: Boolean) {
                        // 缓冲中 isPlaying 也是 false，此时别把 onPlaybackStateChanged
                        // 刚写好的「正在缓冲...」覆盖成「已暂停」，那会让人以为是暂停了
                        tvStatus.text = when {
                            isPlaying -> getString(R.string.playing)
                            playbackState == Player.STATE_READY -> "已暂停"
                            else -> return
                        }
                    }

                    override fun onPlayerError(error: PlaybackException) {
                        Timber.e(error, "Player error")
                        updateBufferingState(false)
                        tvStatus.text = "播放错误"
                        tvError.text = "播放错误: ${error.message ?: "未知错误"}"
                        tvError.visibility = View.VISIBLE
                    }
                })
                // 视频信息面板的「网速」取自带宽估计（ExoPlayer 默认的 DefaultBandwidthMeter 采样）
                addAnalyticsListener(object : AnalyticsListener {
                    override fun onBandwidthEstimate(
                        eventTime: AnalyticsListener.EventTime,
                        totalLoadTimeMs: Int,
                        totalBytesLoaded: Long,
                        bitrateEstimate: Long
                    ) {
                        bandwidthEstimateBps = bitrateEstimate
                    }

                    /** MS600: 记录 DLNA 会话实际用的解码器，投屏信息面板要显示「硬解 / 软解」。 */
                    override fun onVideoDecoderInitialized(
                        eventTime: AnalyticsListener.EventTime,
                        decoderName: String,
                        initializedTimestampMs: Long,
                        initializationDurationMs: Long
                    ) {
                        dlnaDecoderName = decoderName
                        dlnaSwDecode = decoderName.startsWith("OMX.google.") ||
                            decoderName.startsWith("c2.android.")
                    }
                })
            }

        playerView.player = player
        playerView.setControllerVisibilityListener(PlayerView.ControllerVisibilityListener { visibility ->
            findViewById<View?>(R.id.status_bar)?.visibility = visibility
            isControllerVisible = visibility == View.VISIBLE
            // 点播（DLNA）：播放控制条自己收起来时（比如用户点了进度条、或超时），
            // 投屏菜单跟着收 —— 不让两者状态错位。反方向不联动：菜单是我们主动开的。
            if (!isMirrorSession() && visibility != View.VISIBLE && isCastPanelVisible()) {
                closeCastPanel()
            }
        })
        playerView.setShowNextButton(true)
        playerView.setShowPreviousButton(true)
        setupControllerActions()
        // v1.2.32：点播（DLNA / 本地）也用「画面模式」控制缩放
        applyPlayerResizeMode()
    }

    private fun setupControllerActions() {
        // v1.2.32：控制条上的「更多」按钮已去掉 —— 里面的画质/屏幕方向/视频信息都已随菜单精简移除，
        //   播放速度在投屏菜单里（点画面唤出）。
        playerView.findViewById<View?>(R.id.exo_ffwd)?.setOnClickListener { handleSeekPress(forward = true) }
        playerView.findViewById<View?>(R.id.exo_rew)?.setOnClickListener { handleSeekPress(forward = false) }
    }


    private fun formatSpeedLabel(speed: Float): String =
        if (speed == 1f) "1.0x" else "${speed}x"

    /**
     * 参考 Kodi 的连续快进快退：短时间内连续按键会累加跳转步长并放大跨度，
     * 松开按键一段时间后再统一提交一次 seek，避免频繁 seek 造成反复缓冲。
     */
    private fun handleSeekPress(forward: Boolean) {
        if (isCurrentImage() || player == null) return
        val now = SystemClock.elapsedRealtime()
        val withinAccelWindow = now - lastSeekPressAt <= SEEK_ACCEL_WINDOW_MS
        seekAccelerationStep = if (withinAccelWindow && forward == lastSeekWasForward) {
            (seekAccelerationStep + 1).coerceAtMost(SEEK_STEP_TABLE_MS.lastIndex)
        } else {
            pendingSeekDeltaMs = 0L
            0
        }
        lastSeekWasForward = forward
        lastSeekPressAt = now

        val step = SEEK_STEP_TABLE_MS[seekAccelerationStep]
        pendingSeekDeltaMs += if (forward) step else -step

        previewPendingSeek()

        seekCommitJob?.cancel()
        seekCommitJob = lifecycleScope.launch {
            delay(SEEK_COMMIT_DELAY_MS)
            commitPendingSeek()
        }
    }

    private fun previewPendingSeek() {
        val currentPlayer = player ?: return
        val duration = currentPlayer.duration.takeIf { it > 0 } ?: Long.MAX_VALUE
        val target = (currentPlayer.currentPosition + pendingSeekDeltaMs).coerceIn(0L, duration)
        val sign = if (pendingSeekDeltaMs >= 0) "+" else "-"
        val deltaSeconds = kotlin.math.abs(pendingSeekDeltaMs) / 1000
        tvStatus.text = "${sign}${deltaSeconds}s  ${formatTimeMs(target)}"
        playerView.showController()
    }

    private fun commitPendingSeek() {
        val currentPlayer = player ?: return
        if (pendingSeekDeltaMs == 0L) return
        val duration = currentPlayer.duration.takeIf { it > 0 } ?: Long.MAX_VALUE
        val target = (currentPlayer.currentPosition + pendingSeekDeltaMs).coerceIn(0L, duration)
        currentPlayer.seekTo(target)
        pendingSeekDeltaMs = 0L
        seekAccelerationStep = 0
        reportPlaybackPosition()
    }

    private fun formatTimeMs(ms: Long): String {
        val totalSeconds = ms / 1000
        val hours = totalSeconds / 3600
        val minutes = (totalSeconds % 3600) / 60
        val seconds = totalSeconds % 60
        return if (hours > 0) {
            String.format("%d:%02d:%02d", hours, minutes, seconds)
        } else {
            String.format("%d:%02d", minutes, seconds)
        }
    }

    override fun dispatchKeyEvent(event: KeyEvent): Boolean {
        if (event.action == KeyEvent.ACTION_DOWN && !isDialogShowing) {
            // 镜像/Miracast 没有控制条，INFO / MENU 键是信息面板的唯一入口
            if (event.keyCode == KeyEvent.KEYCODE_INFO || event.keyCode == KeyEvent.KEYCODE_MENU) {
                toggleStreamInfo()
                return true
            }
            // 面板打开时返回键先关面板，不要直接结束播放
            if (event.keyCode == KeyEvent.KEYCODE_BACK && isStreamInfoVisible) {
                hideStreamInfo()
                return true
            }
        }
        if (event.action == KeyEvent.ACTION_DOWN && !isCurrentImage() && !isDialogShowing) {
            val isForwardKey = event.keyCode == KeyEvent.KEYCODE_DPAD_RIGHT ||
                event.keyCode == KeyEvent.KEYCODE_MEDIA_FAST_FORWARD
            val isRewindKey = event.keyCode == KeyEvent.KEYCODE_DPAD_LEFT ||
                event.keyCode == KeyEvent.KEYCODE_MEDIA_REWIND
            if (isForwardKey || isRewindKey) {
                val isHardwareSeekKey = event.keyCode == KeyEvent.KEYCODE_MEDIA_REWIND ||
                    event.keyCode == KeyEvent.KEYCODE_MEDIA_FAST_FORWARD
                val inSeekMode = SystemClock.elapsedRealtime() - lastSeekPressAt <= SEEK_ACCEL_WINDOW_MS
                // 方向键仅在 OSD 未显示或正处于连续快进快退中时才拦截用于 seek，
                // 否则放行给控制条做按钮焦点导航（与 Kodi 行为一致）。
                if (isHardwareSeekKey || inSeekMode || !isControllerVisible) {
                    handleSeekPress(forward = isForwardKey)
                    return true
                }
            }
        }
        return super.dispatchKeyEvent(event)
    }

    private fun handleIntent(intent: Intent?) {
        if (intent?.getStringExtra(EXTRA_SOURCE_TYPE) == "MIRACAST") {
            startMiracastPlayback(intent.getIntExtra(EXTRA_RTP_PORT, 0), intent.getStringExtra(EXTRA_SESSION_ID))
            return
        }

        if (intent?.getBooleanExtra(EXTRA_IS_AIRPLAY_MIRROR, false) == true) {
            startAirPlayMirrorPlayback()
            return
        }

        val list = intent?.getStringArrayListExtra(EXTRA_MEDIA_URIS)
            ?: intent?.getStringExtra(EXTRA_MEDIA_URI)?.let { arrayListOf(it) }
            ?: arrayListOf()
        val titles = intent?.getStringArrayListExtra(EXTRA_MEDIA_TITLES)
            ?: intent?.getStringExtra(EXTRA_MEDIA_TITLE)?.let { arrayListOf(it) }
            ?: arrayListOf()

        playlist = list.filter { it.isNotBlank() }
        playlistTitles = titles
        currentIndex = intent?.getIntExtra(EXTRA_START_INDEX, 0)?.coerceIn(0, (playlist.size - 1).coerceAtLeast(0)) ?: 0

        if (playlist.isNotEmpty()) {
            playCurrent()
        }
    }

    private fun playCurrent() {
        mediaUri = playlist.getOrNull(currentIndex)
        mediaTitle = playlistTitles.getOrNull(currentIndex) ?: "DLNA 投屏 ${currentIndex + 1}/${playlist.size}"
        tvTitle.text = mediaTitle
        val uri = mediaUri ?: return
        if (isImageUri(uri)) {
            showImage(uri)
        } else {
            playMedia(uri)
        }
    }

    private fun startAirPlayMirrorPlayback() {
        Timber.i("Starting AirPlay mirror playback")
        isAirPlayMirrorSession = true
        isMiracastSession = false
        streamInfoTracker.reset()
        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        stopImageSlideShow()
        player?.clearVideoSurface()
        player?.pause()
        playerView.player = null
        playerView.visibility = View.GONE
        mirrorSurfaceView.visibility = View.VISIBLE
        imageView.visibility = View.GONE
        tvTitle.text = "iPhone 屏幕镜像"
        tvStatus.text = "正在接收 iPhone 屏幕..."
        tvError.visibility = View.GONE
        updateBufferingState(false)
        requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_SENSOR_LANDSCAPE

        publishMirrorSurface()
        onMirrorSessionStart()
    }

    /**
     * 把镜像 SurfaceView 的 Surface 发布给解码器。AirPlay 镜像和 Miracast 共用这一块
     * Surface —— 两者都是「解码器直接送显」的实时镜像，不经过 ExoPlayer。
     *
     * 用 SurfaceView（而不是 TextureView）直通解码器：少一层 GPU 合成、帧缓冲不和别人抢，
     * 低端 SoC 上帧率更稳。画面缩放/裁切只改这一层的**布局尺寸 + 平移**，不碰解码链路，
     * 所以调挡位时不会影响帧率和延迟。
     *
     * 应用切后台时 SurfaceView 会销毁 Surface、回前台再造一个新的，所以必须持续跟踪
     * 变化并置空，否则解码器会往失效的 Surface 上写，画面一直黑。
     */
    private fun publishMirrorSurface() {
        val waitingText = if (isMiracastSession) "等待 Windows 画面..." else "等待 AirPlay 显示画面..."
        val activeText = if (isMiracastSession) "正在接收 Windows 屏幕..." else "正在接收 iPhone 屏幕..."

        fun publish(holder: SurfaceHolder) {
            mirrorSurface = holder.surface.takeIf { it.isValid }
            Timber.i("Mirror surface ${if (mirrorSurface == null) "not ready" else "ready"}")
            tvStatus.text = if (mirrorSurface == null) waitingText else activeText
        }

        mirrorSurfaceView.holder.addCallback(object : SurfaceHolder.Callback {
            override fun surfaceCreated(holder: SurfaceHolder) = publish(holder)
            override fun surfaceChanged(holder: SurfaceHolder, format: Int, width: Int, height: Int) = publish(holder)
            override fun surfaceDestroyed(holder: SurfaceHolder) {
                Timber.i("Mirror surface destroyed")
                mirrorSurface = null
            }
        })
        mirrorSurfaceView.post { publish(mirrorSurfaceView.holder) }
        startMirrorAspectFitUpdates()
    }

    /**
     * 持续跟踪视频尺寸与父容器尺寸，任一变化就按当前缩放模式重算镜像 Surface 的大小。
     *
     * 之前只在视频尺寸变化时算一次，若那一刻父容器还没测量好（宽高为 0）就再也不会重算，
     * 画面会一直保持初始尺寸 —— 竖屏投屏被挤压就是这个原因。现在把父容器尺寸也纳入判断。
     */
    private fun startMirrorAspectFitUpdates() {
        mirrorAspectJob?.cancel()
        lastParentW = 0
        lastParentH = 0
        mirrorAspectJob = lifecycleScope.launch {
            var lastW = 0
            var lastH = 0
            while (isActive) {
                val parent = mirrorSurfaceView.parent as? View
                val parentW = parent?.width ?: 0
                val parentH = parent?.height ?: 0
                val videoW = StreamStats.videoWidth
                val videoH = StreamStats.videoHeight
                val changed = videoW != lastW || videoH != lastH ||
                    parentW != lastParentW || parentH != lastParentH
                if (changed && parentW > 0 && parentH > 0 && videoW > 0 && videoH > 0) {
                    val newVideo = videoW != lastW || videoH != lastH
                    lastW = videoW
                    lastH = videoH
                    lastParentW = parentW
                    lastParentH = parentH
                    // v1.2.35：黑边只在进「16:9」模式时量一次（持续量会卡投屏）。
                    // 新一路流（尺寸变化）后旧的比例作废；若当前正是 16:9 就顺手补量一次。
                    if (newVideo) contentProbed = false
                    if (scaleMode == SCALE_16_9 && !contentProbed) {
                        probeContentBorders("size ${videoW}x$videoH")
                    } else {
                        applyMirrorScale(videoW, videoH, parentW, parentH)
                    }
                }
                delay(300)
            }
        }
    }

    /** 等比缩放到刚好放进父容器的尺寸（"适应"框）。 */
    private fun fitBox(videoAspect: Float, parentW: Int, parentH: Int): Pair<Int, Int> =
        if (videoAspect > parentW.toFloat() / parentH.toFloat()) {
            parentW to (parentW / videoAspect).toInt()
        } else {
            (parentH * videoAspect).toInt() to parentH
        }

    /**
     * 按当前画面模式计算镜像 Surface 的显示尺寸。
     *
     * v1.2.35 起，三种模式都**先扣掉流里烘进去的黑边**，再按「有效内容」去铺：
     * - **适应**：有效内容等比缩放进屏幕，能不裁就不裁；
     * - **铺满**：有效内容等比放大到铺满整屏，超出部分被父容器裁掉；
     * - **16:9**：有效内容等比放大到「屏幕内最大的 16:9 框」（本机 1920×1080），
     *   于是上下各留 60px 黑边、左右贴满 —— 16:9 的片子用 16:9 的框显示，本该如此。
     *
     * 为什么要扣黑边：投屏源常把画面缩到 80%~90% 再在四周补黑边（实测 B 站投上来的
     * 1920×1080 流，真实内容只有 1537×866）。这种黑边是**编码进流里**的，
     * 只改 Surface 尺寸永远消不掉 —— 必须量出真实内容边界，再按内容放大。
     *
     * @param forceFit 测量黑边前的过渡摆放：整幅画面（含黑边）必须都在屏内才量得到边。
     */
    private fun applyMirrorScale(
        videoW: Int,
        videoH: Int,
        parentW: Int,
        parentH: Int,
        forceFit: Boolean = false
    ) {
        val mode = if (forceFit) SCALE_FIT else scaleMode
        // v1.2.36：**只有 16:9 模式**才按「有效内容」铺。
        //   之前三个模式都用扣完黑边的内容算，结果「适应」缩放到内容宽度、「16:9」也缩到
        //   内容宽度 —— 两者算出同一个尺寸，切模式看起来完全没反应（用户实测反馈）。
        //   现在 16:9 走内容、适应/铺满仍按整幅画面，三档区别明显。
        val useContent = mode == SCALE_16_9
        val fx = if (useContent) (contentR - contentL).coerceIn(0.25f, 1f) else 1f
        val fy = if (useContent) (contentB - contentT).coerceIn(0.25f, 1f) else 1f
        val effW = (videoW * fx).coerceAtLeast(1f)
        val effH = (videoH * fy).coerceAtLeast(1f)

        // 屏幕真实尺寸（displayMetrics 会少掉状态栏那条，实测 1920×1178）
        val realSize = android.graphics.Point()
        @Suppress("DEPRECATION")
        windowManager.defaultDisplay.getRealSize(realSize)
        val sw = maxOf(realSize.x, realSize.y).toFloat()
        val sh = minOf(realSize.x, realSize.y).toFloat()

        // k = 整幅画面的缩放倍数（Surface 尺寸 = 视频尺寸 × k）
        val k = when (mode) {
            SCALE_FILL -> maxOf(parentW / effW, parentH / effH)
            SCALE_16_9 -> {
                val boxAspect = 16f / 9f
                val boxW: Float
                val boxH: Float
                if (boxAspect > sw / sh) {
                    boxW = sw
                    boxH = sw / boxAspect
                } else {
                    boxH = sh
                    boxW = sh * boxAspect
                }
                maxOf(boxW / effW, boxH / effH)
            }
            else -> minOf(parentW / effW, parentH / effH)
        }
        val targetW = (videoW * k).toInt().coerceAtLeast(1)
        val targetH = (videoH * k).toInt().coerceAtLeast(1)

        mirrorSurfaceView.layoutParams = mirrorSurfaceView.layoutParams.apply {
            width = targetW
            height = targetH
        }
        // 有效内容的中心若不在画面正中，用平移补回来（实测都是对称黑边，通常为 0）
        if (useContent) {
            mirrorSurfaceView.translationX = targetW / 2f - (contentL + contentR) / 2f * targetW
            mirrorSurfaceView.translationY = targetH / 2f - (contentT + contentB) / 2f * targetH
        } else {
            mirrorSurfaceView.translationX = 0f
            mirrorSurfaceView.translationY = 0f
        }

        android.util.Log.i(
            "MS600Scale",
            "mode=$mode${if (forceFit) "(probe)" else ""} video=${videoW}x$videoH " +
                "content=${(fx * 100).toInt()}%x${(fy * 100).toInt()} -> view=${targetW}x$targetH " +
                "parent=${parentW}x$parentH k=%.4f".format(k)
        )
    }

    /**
     * 量黑边：先摆成「适应」（保证整幅画面都在屏内），抓一帧缩略图找四周纯黑的行列，
     * 最后按当前模式重排。视频尺寸一变（新一路投屏）就重新量。
     */
    private fun probeContentBorders(reason: String) {
        contentDetectJob?.cancel()
        contentDetectJob = lifecycleScope.launch {
            val parent = mirrorSurfaceView.parent as? View ?: return@launch
            var attempt = 0
            var vw = 0
            var vh = 0
            // 只在用户切到「16:9」时量一次（不做持续跟踪：PixelCopy 是 GPU 回读，
            // 每轮都做会把投屏拖卡）。画面还是黑的就短间隔重试几次，最多约 3 秒。
            while (isActive && attempt < 6) {
                vw = StreamStats.videoWidth
                vh = StreamStats.videoHeight
                if (vw <= 0 || vh <= 0 || parent.width <= 0 || parent.height <= 0) {
                    delay(300)
                    attempt++
                    continue
                }
                // 量之前先摆成「适应」：整幅画面（含黑边）都在屏内才量得到边
                applyMirrorScale(vw, vh, parent.width, parent.height, forceFit = true)
                delay(380)
                val r = probeContentBordersOnce(verbose = attempt == 0)
                if (r != null && !borderImplausible(r)) {
                    contentL = r[0]
                    contentT = r[1]
                    contentR = r[2]
                    contentB = r[3]
                    contentProbed = true
                    android.util.Log.i(
                        "MS600Scale",
                        "content($reason) l=%.3f t=%.3f r=%.3f b=%.3f".format(
                            contentL, contentT, contentR, contentB
                        )
                    )
                    break
                }
                attempt++
                delay(300)
            }
            if (vw > 0 && vh > 0) {
                applyMirrorScale(vw, vh, parent.width, parent.height)
            }
        }
    }

    private fun nearRect(a: FloatArray, b: FloatArray, tol: Float): Boolean {
        for (k in 0 until 4) if (kotlin.math.abs(a[k] - b[k]) > tol) return false
        return true
    }

    /** 单边裁超过 22% 不合常理（实测量到的投屏黑边最多约 11%），按暗场误判处理。 */
    private fun borderImplausible(r: FloatArray): Boolean =
        r[0] > 0.22f || r[1] > 0.22f || (1f - r[2]) > 0.22f || (1f - r[3]) > 0.22f

    /** 抓一帧缩略图量内容边界，失败返回 null（API<24 或表面还没出图）。 */
    private suspend fun probeContentBordersOnce(verbose: Boolean = false): FloatArray? =
        suspendCancellableCoroutine { cont ->
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.N) {
                cont.resume(null)
                return@suspendCancellableCoroutine
            }
            val bmp = try {
                Bitmap.createBitmap(PROBE_W, PROBE_H, Bitmap.Config.ARGB_8888)
            } catch (t: Throwable) {
                cont.resume(null)
                return@suspendCancellableCoroutine
            }
            try {
                PixelCopy.request(
                    mirrorSurfaceView,
                    bmp,
                    { result ->
                        if (result != PixelCopy.SUCCESS) {
                            android.util.Log.w("MS600Scale", "PixelCopy failed result=$result")
                            bmp.recycle()
                            cont.resume(null)
                        } else {
                        val out = analyzeBlackBorders(bmp)
                        if (verbose) {
                            // 第一轮探测多打点信息：全黑（流还没出图）和"测不出边"要能区分开
                            val px = IntArray(bmp.width * bmp.height)
                            bmp.getPixels(px, 0, bmp.width, 0, 0, bmp.width, bmp.height)
                            var sum = 0L
                            var mx = 0
                            for (c in px) {
                                val l = ((c shr 16 and 0xFF) * 30 +
                                    (c shr 8 and 0xFF) * 59 + (c and 0xFF) * 11) / 100
                                sum += l
                                if (l > mx) mx = l
                            }
                            android.util.Log.i(
                                "MS600Scale",
                                "probe#${attemptNo} mean=${sum / px.size} max=$mx " +
                                    "rect=${out?.joinToString(",") { "%.3f".format(it) } ?: "null"}"
                            )
                        }
                        bmp.recycle()
                        cont.resume(out)
                        }
                    },
                    Handler(Looper.getMainLooper())
                )
            } catch (t: Throwable) {
                android.util.Log.w("MS600Scale", "PixelCopy 异常: ${t.message}")
                bmp.recycle()
                cont.resume(null)
            }
        }

    /** 从缩略图里找出四周整片纯黑的行列，返回归一化 (l, t, r, b)；全黑或不可信返回 null。 */
    private fun analyzeBlackBorders(bmp: Bitmap): FloatArray? {
        val w = bmp.width
        val h = bmp.height
        if (w <= 0 || h <= 0) return null
        val px = IntArray(w * h)
        bmp.getPixels(px, 0, w, 0, 0, w, h)

        fun lum(i: Int): Int {
            val c = px[i]
            return ((c shr 16 and 0xFF) * 30 + (c shr 8 and 0xFF) * 59 + (c and 0xFF) * 11) / 100
        }

        // 黑边是编码器补的纯黑（0~3），阈值给点余量；一行里 94% 以上是黑的才算黑边行
        fun rowIsBlack(y: Int): Boolean {
            var bright = 0
            for (x in 0 until w) {
                if (lum(y * w + x) > BLACK_TH) {
                    bright++
                    if (bright > w * BLACK_RATIO) return false
                }
            }
            return true
        }

        fun colIsBlack(x: Int): Boolean {
            var bright = 0
            for (y in 0 until h) {
                if (lum(y * w + x) > BLACK_TH) {
                    bright++
                    if (bright > h * BLACK_RATIO) return false
                }
            }
            return true
        }

        var top = 0
        while (top < h && rowIsBlack(top)) top++
        if (top >= h) return null                    // 整幅全黑：还没出画面
        var bottom = h - 1
        while (bottom > top && rowIsBlack(bottom)) bottom--
        var left = 0
        while (left < w && colIsBlack(left)) left++
        if (left >= w) return null
        var right = w - 1
        while (right > left && colIsBlack(right)) right--

        val l = left / w.toFloat()
        val t = top / h.toFloat()
        val r = (right + 1) / w.toFloat()
        val b = (bottom + 1) / h.toFloat()
        // 内容太小说明这帧是暗场/黑屏，测量不可信
        if (r - l < 0.10f || b - t < 0.10f) return null
        return floatArrayOf(l, t, r, b)
    }

    /**
     * Miracast 显示。RTP 接收、TS 解复用和解码都由
     * [com.iflytek.ms600.cast.miracast.WfdServer] 那条链路完成，这里只负责把镜像
     * Surface 交出去 —— 和 AirPlay 镜像完全同一套机制。
     *
     * 刻意不经过 ExoPlayer：播放器的缓冲和时钟同步会引入秒级延迟（实测超过 10 秒），
     * 而第二屏幕这种用途要的是「收到即解码、解完即送显」。
     */
    private fun startMiracastPlayback(rtpPort: Int, sessionId: String?) {
        Timber.i("Starting Miracast display: rtpPort=$rtpPort session=$sessionId")
        isMiracastSession = true
        isAirPlayMirrorSession = false
        streamInfoTracker.reset()
        // 画面不经过 ExoPlayer，PlayerView 的自动常亮不生效，必须手动保持，否则电视会进屏保
        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        stopImageSlideShow()

        player?.clearVideoSurface()
        player?.pause()
        playerView.player = null
        playerView.visibility = View.GONE
        imageView.visibility = View.GONE
        mirrorSurfaceView.visibility = View.VISIBLE
        tvTitle.text = "Windows 无线显示器"
        tvStatus.text = "正在接收 Windows 屏幕..."
        tvError.visibility = View.GONE
        updateBufferingState(false)
        requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_SENSOR_LANDSCAPE

        publishMirrorSurface()
        onMirrorSessionStart()
    }

    private fun playMedia(uri: String) {
        Timber.i("Playing media: $uri")
        isMiracastSession = false
        isAirPlayMirrorSession = false
        streamInfoTracker.reset()
        stopImageSlideShow()
        imageView.visibility = View.GONE
        playerView.visibility = View.VISIBLE
        requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_SENSOR_LANDSCAPE

        try {
            tvError.visibility = View.GONE
            updateBufferingState(true)

            // 根据 URI 判断媒体类型
            val mediaItem = createMediaItem(uri)

            val items = playlist.mapIndexedNotNull { index, itemUri ->
                if (!isImageUri(itemUri)) {
                    createMediaItem(itemUri).also { if (index == currentIndex) mediaUri = itemUri }
                } else null
            }
            if (playlist.size > 1 && items.isNotEmpty()) {
                val videoIndex = playlist.take(currentIndex + 1).count { !isImageUri(it) } - 1
                player?.setMediaItems(items, videoIndex.coerceAtLeast(0), 0L)
            } else {
                player?.setMediaItem(mediaItem)
            }
            player?.prepare()
            player?.play()
        } catch (e: Exception) {
            Timber.e(e, "Error playing media")
            tvStatus.text = "播放错误"
            tvError.text = "播放错误: ${e.message ?: "未知错误"}"
            tvError.visibility = View.VISIBLE
            updateBufferingState(false)
        }
    }

    private fun createMediaItem(uri: String): MediaItem {
        // 检测 HLS 流
        val isHls = uri.contains(".m3u8") || uri.contains("/playlist/m3u8")

        return if (isHls) {
            // HLS 流：明确指定 MIME 类型
            MediaItem.Builder()
                .setUri(uri)
                .setMimeType(MimeTypes.APPLICATION_M3U8)
                .build()
        } else {
            // 其他格式：让 ExoPlayer 自动检测
            MediaItem.fromUri(uri)
        }
    }

    private fun showImage(uri: String) {
        Timber.i("Showing image: $uri")
        player?.pause()
        playerView.visibility = View.GONE
        imageView.visibility = View.VISIBLE
        tvError.visibility = View.GONE
        tvStatus.text = "正在显示图片"
        updateBufferingState(true)
        requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_SENSOR

        lifecycleScope.launch {
            try {
                val bitmap = withContext(Dispatchers.IO) {
                    if (uri.startsWith("http://") || uri.startsWith("https://")) {
                        URL(uri).openStream().use { BitmapFactory.decodeStream(it) }
                    } else {
                        contentResolver.openInputStream(Uri.parse(uri))?.use { BitmapFactory.decodeStream(it) }
                    }
                }
                updateBufferingState(false)
                if (bitmap != null) {
                    imageView.setImageBitmap(bitmap)
                    adaptOrientationToImage(bitmap.width, bitmap.height)
                    startImageSlideShow()
                } else {
                    throw IllegalArgumentException("无法加载图片")
                }
            } catch (e: Exception) {
                Timber.e(e, "Error showing image")
                updateBufferingState(false)
                tvStatus.text = "图片加载错误"
                tvError.text = "图片加载错误: ${e.message ?: "未知错误"}"
                tvError.visibility = View.VISIBLE
            }
        }
    }

    private fun startImageSlideShow() {
        if (playlist.count { isImageUri(it) } <= 1) return
        slideJob?.cancel()
        slideJob = lifecycleScope.launch {
            while (isActive && isCurrentImage()) {
                delay(IMAGE_SLIDE_INTERVAL_MS)
                playNextOrFinish(loopImages = true)
            }
        }
    }

    private fun stopImageSlideShow() {
        slideJob?.cancel()
        slideJob = null
        if (isCurrentImage()) tvStatus.text = "图片轮播已暂停"
    }

    private fun playNextOrFinish(loopImages: Boolean = false) {
        if (playlist.isEmpty()) return
        if (currentIndex < playlist.lastIndex) {
            currentIndex++
            playCurrent()
        } else if (loopImages) {
            currentIndex = 0
            playCurrent()
        } else {
            updateBufferingState(false)
            reportPlaybackStopped()
        }
    }

    private fun isCurrentImage(): Boolean = mediaUri?.let { isImageUri(it) } == true

    private fun isImageUri(uri: String): Boolean {
        val clean = uri.substringBefore('?').lowercase()
        return clean.endsWith(".jpg") || clean.endsWith(".jpeg") || clean.endsWith(".png") ||
            clean.endsWith(".gif") || clean.endsWith(".webp") || clean.endsWith(".bmp") ||
            clean.startsWith("content://") && clean.contains("image")
    }

    private fun updateBufferingState(isBuffering: Boolean) {
        progressBar.visibility = if (isBuffering) View.VISIBLE else View.GONE
        bufferingIndicator.visibility = if (isBuffering) View.VISIBLE else View.GONE
    }

    // ─── 视频流信息面板 ────────────────────────────────────────────────────
    /** 切换信息面板。镜像/Miracast 没有控制条，只能靠遥控 INFO / MENU 键触发。 */
    private fun toggleStreamInfo() {
        if (isStreamInfoVisible) hideStreamInfo() else showStreamInfo()
    }

    private fun showStreamInfo() {
        isStreamInfoVisible = true
        streamInfoTracker.reset()
        tvStreamInfo.text = buildStreamInfoText()
        tvStreamInfo.visibility = View.VISIBLE
        streamInfoJob?.cancel()
        streamInfoJob = lifecycleScope.launch {
            while (isActive) {
                delay(1000)
                tvStreamInfo.text = buildStreamInfoText()
            }
        }
    }

    private fun hideStreamInfo() {
        isStreamInfoVisible = false
        streamInfoJob?.cancel()
        streamInfoJob = null
        tvStreamInfo.visibility = View.GONE
    }

    private fun buildStreamInfoText(): String = when {
        isAirPlayMirrorSession -> buildAirPlayStreamInfo()
        isMiracastSession -> buildMiracastStreamInfo()
        else -> buildExoPlayerStreamInfo()
    }

    /** DLNA / 普通网络播放：分辨率、帧率、码率取自当前视频轨，网速取带宽估计。 */
    private fun buildExoPlayerStreamInfo(): String {
        val currentPlayer = player
        val format = currentPlayer?.videoFormat
        val videoSize = currentPlayer?.videoSize
        val bitrateBps = listOfNotNull(format?.bitrate, format?.averageBitrate, format?.peakBitrate)
            .firstOrNull { it != Format.NO_VALUE }?.toLong() ?: 0L
        return streamInfoLines(
            resolution = StreamInfoTracker.formatResolution(videoSize?.width ?: 0, videoSize?.height ?: 0),
            codec = StreamInfoTracker.formatCodec(format?.sampleMimeType),
            fps = StreamInfoTracker.formatFps(format?.frameRate ?: 0f),
            bitrate = StreamInfoTracker.formatBitrate(bitrateBps),
            speed = StreamInfoTracker.formatSpeed(bandwidthEstimateBps / 8)
        )
    }

    /** AirPlay 镜像：码率只算视频流，网速把音频流字节也算进去。 */
    private fun buildAirPlayStreamInfo(): String {
        val videoBytes = StreamStats.videoBytesTotal
        val totalBytes = videoBytes + StreamStats.audioBytesTotal
        val sample = streamInfoTracker.sample(totalBytes, StreamStats.videoFramesTotal)
        // 视频码率 = 总码率中扣掉音频部分，按本次采样的视频/总字节比例折算
        val videoShare = if (totalBytes > 0) videoBytes.toDouble() / totalBytes else 1.0
        return streamInfoLines(
            resolution = StreamInfoTracker.formatResolution(StreamStats.videoWidth, StreamStats.videoHeight),
            codec = StreamInfoTracker.formatCodec(StreamStats.videoCodec),
            fps = StreamInfoTracker.formatFps(sample.fps.toFloat()),
            bitrate = StreamInfoTracker.formatBitrate((sample.bitrateBps * videoShare).toLong()),
            speed = StreamInfoTracker.formatSpeed(sample.bytesPerSec)
        )
    }

    /**
     * Miracast：不经过 ExoPlayer，所以分辨率取解码器上报的值（[StreamStats]，由
     * VideoDecoder 写入），码率和网速取 [RtpReceiver] 的累计字节数。
     * 帧率暂不统计 —— 解码路径上没有帧计数器。
     */
    private fun buildMiracastStreamInfo(): String {
        val sample = streamInfoTracker.sample(RtpReceiver.active?.bytesReceived ?: 0L, 0L)
        return streamInfoLines(
            resolution = StreamInfoTracker.formatResolution(StreamStats.videoWidth, StreamStats.videoHeight),
            codec = StreamInfoTracker.formatCodec("video/avc"),
            fps = StreamInfoTracker.formatFps(0f),
            bitrate = StreamInfoTracker.formatBitrate(sample.bitrateBps),
            speed = StreamInfoTracker.formatSpeed(sample.bytesPerSec)
        )
    }

    private fun streamInfoLines(
        resolution: String,
        codec: String,
        fps: String,
        bitrate: String,
        speed: String
    ): String {
        val (displayW, displayH) = currentDisplaySize()
        val rows = listOf(
            "源分辨率" to resolution,
            "显示分辨率" to StreamInfoTracker.formatResolution(displayW, displayH),
            "视频编码" to codec,
            "帧率" to fps,
            "码率" to bitrate,
            "网速" to speed
        )
        return rows.joinToString("\n", prefix = "视频信息\n") { (label, value) ->
            StreamInfoTracker.padLabel(label) + value
        }
    }

    /**
     * 画面实际渲染到屏幕上的像素尺寸。
     * PlayerView 会按比例把内容框缩到片源宽高比，所以这里拿到的是去掉黑边后的真实显示尺寸；
     * 镜像模式则读 [fitMirrorSurface] 调整过的镜像 Surface。视图还没测量时退回屏幕分辨率。
     */
    /**
     * 本机面板的物理分辨率（「屏幕分辨率」这一行用它）。
     *
     * v1.2.32：原来取的是渲染视图尺寸 —— 在「铺满」模式下那个 View 会被等比放大到超出屏幕，
     * 实测报出 2827x1178 这种离谱值。改成读物理屏幕。
     */
    private fun currentDisplaySize(): Pair<Int, Int> {
        val dm = android.util.DisplayMetrics()
        @Suppress("DEPRECATION")
        (getSystemService(Context.WINDOW_SERVICE) as android.view.WindowManager)
            .defaultDisplay.getRealMetrics(dm)
        if (dm.widthPixels > 0 && dm.heightPixels > 0) {
            return dm.widthPixels to dm.heightPixels
        }
        val metrics = resources.displayMetrics
        return metrics.widthPixels to metrics.heightPixels
    }



    private fun showSpeedDialog() {
        val labels = arrayOf("0.5x", "0.75x", "1.0x", "1.25x", "1.5x", "2.0x")
        val speeds = floatArrayOf(0.5f, 0.75f, 1f, 1.25f, 1.5f, 2f)
        isDialogShowing = true
        AlertDialog.Builder(this)
            .setTitle("播放速度")
            .setItems(labels) { _, which ->
                player?.setPlaybackSpeed(speeds[which])
                currentSpeed = speeds[which]
                tvStatus.text = "播放速度：${labels[which]}"
            }
            .setOnDismissListener { isDialogShowing = false }
            .show()
    }

    private fun adaptOrientationToVideo() {
        // TV 端固定横屏显示，竖屏视频由播放器按比例居中渲染。
        // 不再根据视频宽高切换 Activity 方向，避免 Surface 重建导致竖屏投屏反复缓冲/黑屏。
        requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_SENSOR_LANDSCAPE
    }

    private fun adaptOrientationToImage(width: Int, height: Int) {
        requestedOrientation = if (width >= height) {
            ActivityInfo.SCREEN_ORIENTATION_SENSOR_LANDSCAPE
        } else {
            ActivityInfo.SCREEN_ORIENTATION_SENSOR_PORTRAIT
        }
    }


    private fun registerControlReceiver() {
        val filter = IntentFilter().apply {
            addAction(ACTION_PLAY)
            addAction(ACTION_PAUSE)
            addAction(ACTION_STOP)
            addAction(ACTION_SEEK)
            addAction(ACTION_SET_VOLUME)
            addAction(ACTION_SET_PLAYLIST)
            addAction(ACTION_SET_SPEED)
            addAction(ACTION_SET_QUALITY_URL)
        }
        // 同上：带 flags 的 registerReceiver 是 API 26 起才有的重载
        ContextCompat.registerReceiver(
            this, controlReceiver, filter, ContextCompat.RECEIVER_NOT_EXPORTED
        )
    }

    override fun onStart() {
        super.onStart()
        if (isCurrentImage()) startImageSlideShow() else {
            player?.play()
            startProgressUpdates()
        }
        if (isStreamInfoVisible) showStreamInfo()
    }

    override fun onStop() {
        super.onStop()
        if (isCurrentImage()) stopImageSlideShow() else player?.pause()
        stopProgressUpdates()
        // 保留 isStreamInfoVisible，回到前台时自动恢复刷新
        streamInfoJob?.cancel()
        streamInfoJob = null
        reportPlaybackPosition()
    }

    private fun stopPlayback() {
        stopImageSlideShow()
        stopProgressUpdates()
        mirrorAspectJob?.cancel()
        mirrorAspectJob = null
        onMirrorSessionEnd()
        window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        player?.stop()
        reportPlaybackStopped()
    }

    private fun startProgressUpdates() {
        stopProgressUpdates()
        progressUpdateJob = lifecycleScope.launch {
            while (isActive) {
                delay(1000)
                reportPlaybackPosition()
            }
        }
    }

    private fun stopProgressUpdates() {
        progressUpdateJob?.cancel()
        progressUpdateJob = null
    }

    private fun reportPlaybackPosition() {
        val currentPlayer = player ?: return
        val position = currentPlayer.currentPosition
        val duration = currentPlayer.duration.takeIf { it > 0 } ?: 0L

        // 发送广播以更新 DLNA renderer 状态
        val intent = Intent("com.iflytek.ms600.cast.ACTION_UPDATE_POSITION").apply {
            putExtra("position", position)
            putExtra("duration", duration)
            putExtra("is_playing", currentPlayer.isPlaying)
            setPackage(packageName)
        }
        sendBroadcast(intent)
    }

    /**
     * TV 端本地退出/播放结束时通知 DLNA 渲染器状态归零，
     * 否则 Emby 会一直认为该设备处于播放中，无法取消投屏或切换到新文件。
     */
    private fun reportPlaybackStopped() {
        val intent = Intent(ACTION_PLAYBACK_STOPPED).apply {
            setPackage(packageName)
        }
        sendBroadcast(intent)
    }

    // ─── MS600: 镜像投屏的显示控制（沉浸 / 超级按钮 / 参数面板）───────────────

    /** 进入镜像投屏：隐藏导航栏（小白条），显示超级按钮并启动参数刷新。 */
    /** 进入镜像投屏：进入沉浸模式（隐藏导航栏）并重建菜单。
     *  v1.2.32：悬浮球、裁切挡位、导航栏开关都已移除，导航栏恒定隐藏。 */
    private fun onMirrorSessionStart() {
        applySystemBars()
        buildCastMenu()
    }

    /** 退出镜像投屏：收起信息面板和菜单。 */
    private fun onMirrorSessionEnd() {
        stopCastInfoUpdates()
        hideCastPanel()
        // 本次会话量到的黑边比例不再适用于下一路流，清掉重新量
        contentDetectJob?.cancel()
        contentProbed = false
        contentL = 0f
        contentT = 0f
        contentR = 1f
        contentB = 1f
    }

    // ─── MS600: 裁切挡位（替代自动探测）────────────────────────────────────








    /** 投屏页恒定沉浸式：隐藏系统栏，从屏幕边缘上滑可临时唤出。
     *  v1.2.32：导航栏开关已移除，投屏期间始终隐藏（退出投屏页后系统栏自动恢复）。 */
    private fun applySystemBars() {
        val controller = WindowCompat.getInsetsController(window, window.decorView)
        // 内容铺到栏下，让画面真正占满整屏
        WindowCompat.setDecorFitsSystemWindows(window, false)
        controller.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
    }


    /**
     * 切换画面模式。
     *  · 镜像：适应 → 铺满 → 16:9 → 适应（多一档 16:9，因为手机竖屏流塞进 16:9 时需要固定框）
     *  · 点播：适应 → 铺满 → 适应（ExoPlayer 只有 FIT / ZOOM 两种，视频自带宽高比）
     */
    private fun cycleScaleMode() {
        scaleMode = (scaleMode + 1) % (if (isMirrorSession()) 3 else 2)
        AppSettings.setMirrorScaleMode(this, scaleMode)
        updateScaleButtonLabel()
        if (isMirrorSession()) {
            // 每次切到「16:9」都重新量一次黑边 —— 内容变了（比如从应用界面切到全屏视频）
            // 只有重测才知道。其它模式沿用上次量到的结果。
            if (scaleMode == SCALE_16_9) probeContentBorders("切换到16:9")
            // 立即重算（父容器尺寸没变时轮询不会触发）
            reapplyMirrorScale()
            // 改 layoutParams 后父容器要重新布局，Surface 的尺寸更新是异步的。
            // 只算一次有可能拿到中间态的高度（实测出现过内容上下黑边偏大），稍后再算一遍。
            uiHandler.postDelayed({ reapplyMirrorScale() }, 120)
            uiHandler.postDelayed({ reapplyMirrorScale() }, 350)
        } else {
            applyPlayerResizeMode()
        }
    }

    /** 按当前视频尺寸和父容器尺寸重算镜像 Surface 大小。 */
    private fun reapplyMirrorScale() {
        val parent = mirrorSurfaceView.parent as? View ?: return
        val vw = StreamStats.videoWidth
        val vh = StreamStats.videoHeight
        if (parent.width > 0 && parent.height > 0 && vw > 0 && vh > 0) {
            applyMirrorScale(vw, vh, parent.width, parent.height)
        }
    }

    /** 当前画面模式的显示名。 */
    private fun scaleLabel(): String = getString(
        when (scaleMode) {
            SCALE_FILL -> R.string.scale_fill
            SCALE_16_9 -> R.string.scale_16_9
            else -> R.string.scale_fit
        }
    )

    /** 点播（DLNA / 本地）的画面模式：映射到 ExoPlayer 的缩放方式。 */
    private fun applyPlayerResizeMode() {
        // 「拉伸」已按要求去掉，这里只有适应（FIT）和铺满（ZOOM，等比放大后裁掉溢出）
        playerView.resizeMode = if (scaleMode == SCALE_FILL) {
            AspectRatioFrameLayout.RESIZE_MODE_ZOOM
        } else {
            AspectRatioFrameLayout.RESIZE_MODE_FIT
        }
    }

    /** 缩放模式变了：菜单里的当前值要跟着变。 */
    private fun updateScaleButtonLabel() {
        if (::castMenuRows.isInitialized) buildCastMenu()
    }




    /** 投屏菜单（左侧菜单 + 右侧信息）是否展开。 */
    private fun isCastPanelVisible() = panelCast.visibility == View.VISIBLE

    private fun toggleCastPanel() {
        if (isCastPanelVisible()) hideCastPanel() else showCastPanel()
    }

    private fun showCastPanel() {
        openCastPanel()
        // 点播（DLNA）：把播放控制条一起叫出来，并把自动隐藏时间放宽，
        // 免得信息还没看完菜单就跟着消失了。
        if (!isMirrorSession()) runCatching {
            playerView.controllerShowTimeoutMs = 15_000
            playerView.showController()
        }
    }

    private fun hideCastPanel() {
        closeCastPanel()
        if (!isMirrorSession()) runCatching {
            playerView.controllerShowTimeoutMs = 5_000
            playerView.hideController()
        }
    }

    /** 真正把菜单显示出来（不碰播放控制条，避免互相触发）。 */
    private fun openCastPanel() {
        if (isCastPanelVisible()) return
        // 采样器与「视频信息」面板分开，并在打开时复位，避免短间隔差分把码率算爆
        castInfoTracker.reset()
        buildCastMenu()
        refreshCastInfo()
        applyCastPanelLayout()
        panelCast.visibility = View.VISIBLE
        startCastInfoUpdates()
    }

    /** 真正把菜单收起来（不碰播放控制条）。 */
    private fun closeCastPanel() {
        if (!isCastPanelVisible()) return
        panelCast.visibility = View.GONE
        stopCastInfoUpdates()
    }

    private fun dp(v: Int): Int = (v * resources.displayMetrics.density).toInt()

    /**
     * 菜单的上下留白。
     *
     * 镜像投屏没有底部控制条，两侧栏可以贴到屏幕边缘；DLNA / 点播有播放控制条（进度条 + 按钮，
     * 约 110dp 高）和顶部状态条，侧栏必须让开它们，否则正好盖住播放/暂停 —— 这是明确要求过的。
     */
    private fun applyCastPanelLayout() {
        val mirror = isMirrorSession()
        val barReserve = if (mirror) 0 else dp(116)
        val topReserve = if (mirror) dp(20) else dp(64)
        listOf(castInfoPanel).forEach { v ->
            val lp = v.layoutParams
            if (lp is android.view.ViewGroup.MarginLayoutParams) {
                lp.bottomMargin = dp(16) + barReserve
                lp.topMargin = topReserve
                v.layoutParams = lp
            }
        }
    }

    private fun startCastInfoUpdates() {
        castInfoJob?.cancel()
        castInfoJob = lifecycleScope.launch {
            while (isActive) {
                delay(1_000)
                if (isCastPanelVisible()) refreshCastInfo()
            }
        }
    }

    private fun stopCastInfoUpdates() {
        castInfoJob?.cancel()
        castInfoJob = null
    }

    // ─── 左侧：投屏菜单 ──────────────────────────────────────────────────────

    /** 重建菜单行。每次操作后整块重建 —— 只有几行，比逐个刷新状态安全。 */
    private fun buildCastMenu() {
        if (!::castMenuRows.isInitialized) return
        castMenuRows.removeAllViews()
        // v1.2.32：两类投屏的菜单统一 —— 都保留「画面模式」，语义一致（画面怎么填满屏幕），
        //   镜像走 Surface 布局、点播走 ExoPlayer 的 resizeMode。
        //   已移除：反向控制 + 反控格式、左右/上下裁切、系统导航栏、关闭菜单（点屏幕即可关）、
        //   画质（只是选轨，单码率片源无效）、屏幕方向（固定横屏，切了会黑屏）、视频信息开关。
        addMenuRow("画面模式", scaleLabel()) { cycleScaleMode() }
        if (!isMirrorSession()) {
            addMenuRow("播放速度", "${trimSpeed(currentSpeed)}x") { showSpeedDialog() }
        }
    }

    private fun addMenuRow(title: String, value: String, onClick: () -> Unit) {
        val row = layoutInflater.inflate(R.layout.item_cast_menu_row, castMenuRows, false)
        row.findViewById<TextView>(R.id.tv_menu_title).text = title
        row.findViewById<TextView>(R.id.tv_menu_value).text = value
        row.setOnClickListener {
            onClick()
            buildCastMenu()
            refreshCastInfo()
        }
        castMenuRows.addView(row)
    }

    private fun trimSpeed(v: Float): String =
        if (v == v.toInt().toFloat()) v.toInt().toString() else v.toString()




    // ─── 右侧：投屏信息 ──────────────────────────────────────────────────────

    private fun refreshCastInfo() {
        if (!::castInfoRows.isInitialized) return
        val pairs = if (isMirrorSession()) buildMirrorInfoPairs() else buildMediaInfoPairs()
        // 行数不变时只改文字，避免每秒整块重建导致的闪烁
        if (castInfoRows.childCount == pairs.size) {
            pairs.forEachIndexed { i, (label, value) ->
                bindInfoRow(castInfoRows.getChildAt(i), label, value)
            }
        } else {
            castInfoRows.removeAllViews()
            pairs.forEach { (label, value) ->
                val row = layoutInflater.inflate(R.layout.item_cast_info_row, castInfoRows, false)
                bindInfoRow(row, label, value)
                castInfoRows.addView(row)
            }
        }
    }

    /**
     * 绑定一行投屏信息。
     * 「源地址」单独处理：链接很长，放宽到 4 行、中间省略，并且**长按整行复制**到剪贴板。
     */
    private fun bindInfoRow(row: View, label: String, value: String) {
        val tvLabel = row.findViewById<TextView>(R.id.tv_info_label)
        tvLabel.text = label
        val tv = row.findViewById<TextView>(R.id.tv_info_value)
        tv.text = value
        if (label != "源地址") return
        // 链接很长，wrap_content 会把左侧标签挤成 0 宽 —— 改成按权重分配宽度，
        // 地址占大头并允许换行（中间省略），长按整行复制。
        (tvLabel.layoutParams as android.widget.LinearLayout.LayoutParams).let {
            it.width = 0
            it.weight = 0.34f
            tvLabel.layoutParams = it
        }
        (tv.layoutParams as android.widget.LinearLayout.LayoutParams).let {
            it.width = 0
            it.weight = 0.66f
            tv.layoutParams = it
        }
        tv.gravity = android.view.Gravity.END
        tv.maxLines = 4
        tv.ellipsize = android.text.TextUtils.TruncateAt.MIDDLE
        val onCopy = View.OnLongClickListener {
            try {
                val cm = getSystemService(Context.CLIPBOARD_SERVICE)
                    as android.content.ClipboardManager
                cm.setPrimaryClip(android.content.ClipData.newPlainText("视频源地址", value))
                Toast.makeText(this, "已复制源地址", Toast.LENGTH_SHORT).show()
            } catch (e: Throwable) {
                Timber.w(e, "copy source url failed")
            }
            true
        }
        row.setOnLongClickListener(onCopy)
        tv.setOnLongClickListener(onCopy)
    }

    /** 链路信息：频段 / 信道 / 协商速率（镜像用 P2P 频率，点播用 STA 频率）。 */
    private fun linkInfo(): Triple<Int, Int, String> {
        var staFreq = 0
        var linkMbps = 0
        try {
            val wm = applicationContext.getSystemService(Context.WIFI_SERVICE)
                as? android.net.wifi.WifiManager
            val info = wm?.connectionInfo
            staFreq = info?.frequency ?: 0
            linkMbps = info?.linkSpeed ?: 0
        } catch (e: Exception) {
            Timber.w(e, "read wifi link info failed")
        }
        val freq = if (isMiracastSession && StreamStats.p2pFrequencyMhz > 0) {
            StreamStats.p2pFrequencyMhz
        } else staFreq
        val band = when {
            freq in 4900..5900 -> "5G"
            freq in 2400..2500 -> "2.4G"
            else -> "—"
        }
        val ch = freqToChannel(freq)
        val text = if (freq > 0) {
            "$band ${freq}MHz" + (if (ch > 0) " ch$ch" else "")
        } else "—"
        return Triple(freq, linkMbps, text)
    }

    /** 镜像（Miracast / AirPlay）的投屏信息。 */
    private fun buildMirrorInfoPairs(): List<Pair<String, String>> {
        val type = getString(
            if (isMiracastSession) R.string.cast_type_miracast else R.string.cast_type_airplay
        )
        val hasVideo = StreamStats.videoWidth > 0 && StreamStats.videoHeight > 0
        val sample = if (isMiracastSession) {
            castInfoTracker.sample(
                RtpReceiver.active?.bytesReceived ?: 0L, StreamStats.decodedFramesTotal
            )
        } else {
            castInfoTracker.sample(StreamStats.videoBytesTotal, StreamStats.videoFramesTotal)
        }
        val lossText = RtpReceiver.active?.let {
            val total = it.packetsReceived + it.packetsLost
            if (total <= 0) "0" else String.format("%.2f%%", it.packetsLost * 100.0 / total)
        } ?: "—"
        val latencyText =
            if (StreamStats.decodeLatencyMs > 0) "${StreamStats.decodeLatencyMs} ms" else "—"
        val (_, linkMbps, channelText) = linkInfo()

        val codecText = decodeCodecText(StreamStats.videoCodecName, StreamStats.videoSwDecode)
        val displaySize = currentDisplaySize()

        return listOf(
            "类型" to type,
            "编码" to "H.264 / AVC",
            "解码" to codecText,
            // 「视频分辨率」= 手机/电脑编码出来的原始画面尺寸；
            // 「屏幕分辨率」= 本机面板分辨率。原来还有「内容区」（裁切后的有效区域）和
            // 「裁切」两行，随裁切功能一起移除。
            "视频分辨率" to StreamInfoTracker.formatResolution(
                StreamStats.videoWidth, StreamStats.videoHeight
            ),
            "屏幕分辨率" to StreamInfoTracker.formatResolution(displaySize.first, displaySize.second),
            "帧率" to StreamInfoTracker.formatFps(if (hasVideo) sample.fps.toFloat() else 0f),
            // 原来「码率」和「实际吞吐」是同一份数据（bitrateBps = bytesPerSec × 8），
            // 只是单位不同，已合并成一项。
            "码率" to StreamInfoTracker.formatBitrate(sample.bitrateBps),
            "延迟" to latencyText,
            "丢包" to lossText,
            "Wi-Fi" to channelText,
            "链路速率" to if (linkMbps > 0) "$linkMbps Mbps" else "—"
        )
    }

    /** 「编码 / 解码」两行里的解码值：硬解 + 解码器名。 */
    private fun decodeCodecText(name: String, sw: Boolean): String = when {
        name.isEmpty() -> "—"
        sw -> "软解（CPU）"
        else -> "硬解 · ${name.substringAfterLast('.')}"
    }

    /** DLNA / 普通点播的投屏信息（走 ExoPlayer，信息从 Format + 解码器名拿）。 */
    private fun buildMediaInfoPairs(): List<Pair<String, String>> {
        val format = player?.videoFormat
        val size = player?.videoSize
        val bitrate = listOfNotNull(format?.bitrate, format?.averageBitrate, format?.peakBitrate)
            .firstOrNull { it > 0 }
        val mime = format?.sampleMimeType ?: "—"
        val codecLabel = when {
            mime.contains("avc") || mime.contains("h264") -> "H.264 / AVC"
            mime.contains("hevc") || mime.contains("265") -> "H.265 / HEVC"
            mime.contains("av01") -> "AV1"
            mime.contains("vp9") -> "VP9"
            mime.contains("vp8") -> "VP8"
            mime.contains("mpeg4") -> "MPEG-4"
            else -> mime
        }
        val (_, linkMbps, channelText) = linkInfo()
        val bufferedText = runCatching {
            player?.let { p -> "${(p.bufferedPosition - p.currentPosition) / 1000}s" }
        }.getOrNull() ?: "—"
        val displaySize = currentDisplaySize()

        return listOf(
            "类型" to (if (mediaUri?.startsWith("http") == true) "DLNA 推送" else "本地播放"),
            "编码" to codecLabel,
            "解码" to decodeCodecText(dlnaDecoderName, dlnaSwDecode),
            // 与镜像页统一：都叫「视频分辨率」+「屏幕分辨率」
            "视频分辨率" to StreamInfoTracker.formatResolution(size?.width ?: 0, size?.height ?: 0),
            "屏幕分辨率" to StreamInfoTracker.formatResolution(displaySize.first, displaySize.second),
            // 片源常常不写码率元数据，这时用实测带宽兜底，免得永远显示「—」；
            // 原来的「网速」行与之重复，已合并。
            "码率" to StreamInfoTracker.formatBitrate(bitrate?.toLong() ?: bandwidthEstimateBps),
            "帧率" to (format?.frameRate?.takeIf { it > 0 }?.let { "${it.toInt()} fps" } ?: "—"),
            "预缓冲" to bufferedText,
            "Wi-Fi" to channelText,
            "链路速率" to if (linkMbps > 0) "$linkMbps Mbps" else "—",
            // v1.2.32：本行可长按复制到剪贴板（DLNA 的链接常常要贴到浏览器/下载工具里）
            "源地址" to (mediaUri ?: "—")
        )
    }

    /** DLNA 会话里的解码器名（由 AnalyticsListener 记录）。 */
    private var dlnaDecoderName = ""
    private var dlnaSwDecode = false

    /** 频率 → Wi-Fi 信道号（2.4G / 5G / 6G）。 */
    private fun freqToChannel(freqMhz: Int): Int = when (freqMhz) {
        2484 -> 14
        in 2412..2472 -> (freqMhz - 2407) / 5
        in 5000..5895 -> (freqMhz - 5000) / 5
        in 5955..7115 -> (freqMhz - 5950) / 5
        else -> 0
    }

    /** 反向控制：本次手势里累计的移动事件数（抬起时打印，用来确认滑动是否真的发出去了）。 */

    /** 反向控制是否真的在工作（协商过 + 用户没关）。 */
    /** 这次触摸是不是落在投屏菜单/信息面板上（是的话不能再回传给手机）。 */
    private fun isTouchInsideCastPanel(ev: MotionEvent): Boolean {
        if (!isCastPanelVisible()) return false
        val loc = IntArray(2)
        for (v in arrayOf(castInfoPanel)) {
            v.getLocationOnScreen(loc)
            if (ev.rawX >= loc[0] && ev.rawX < loc[0] + v.width &&
                ev.rawY >= loc[1] && ev.rawY < loc[1] + v.height
            ) return true
        }
        return false
    }

    private var tapDownX = 0f
    private var tapDownY = 0f
    private var tapDownAt = 0L
    private val tapSlop by lazy { android.view.ViewConfiguration.get(this).scaledTouchSlop }

    // ─── v1.2.33 手势：左半屏上下滑 = 亮度，右半屏上下滑 = 音量，双击 = 暂停（仅点播） ───
    /** 0 = 还没判定方向，1 = 正在调亮度，2 = 正在调音量 */
    private var gestureMode = 0
    private var gestureStartY = 0f
    private var gestureStartBrightness = 1f
    private var gestureStartVolume = 0
    private var gestureMaxVolume = 0

    /**
     * 点播页的单击 / 双击识别。
     *
     * 没有用系统 GestureDetector：它的双击窗口固定 300ms，而 adb 的 `input tap`
     * 两次命令之间的实际间隔经常到 300ms 以上，双击会退化成一单一点击（还顺手把菜单点开）。
     * 这里自己按 450ms 判定 —— 人手双击通常在 250ms 内，完全够用；
     * 代价是单击后菜单要等 450ms 才出来（双击不会误开菜单）。
     */
    private var lastTapAt = 0L
    private val menuTapRunnable = Runnable { toggleCastPanel() }
    private val hintHideRunnable = Runnable {
        if (::tvGestureHint.isInitialized) tvGestureHint.visibility = View.GONE
    }

    /** 画面被点了一下（已排除面板/控制条、位移、长按）。 */
    private fun handleTap() {
        val gap = if (lastTapAt > 0) SystemClock.elapsedRealtime() - lastTapAt else -1L
        android.util.Log.i("MS600Gesture", "handleTap gap=$gap mirror=${isMirrorSession()} " +
            "panel=${isCastPanelVisible()}")
        // 镜像页单击立即开关菜单
        if (isMirrorSession()) {
            toggleCastPanel()
            return
        }
        // 菜单开着时点一下就是关，不用等
        if (isCastPanelVisible()) {
            lastTapAt = 0L
            uiHandler.removeCallbacks(menuTapRunnable)
            hideCastPanel()
            return
        }
        val now = SystemClock.elapsedRealtime()
        if (lastTapAt > 0 && now - lastTapAt <= doubleTapWindowMs()) {
            lastTapAt = 0L
            uiHandler.removeCallbacks(menuTapRunnable)
            android.util.Log.i("MS600Gesture", "double tap detected")
            togglePlayPause()
        } else {
            lastTapAt = now
            uiHandler.removeCallbacks(menuTapRunnable)
            uiHandler.postDelayed(menuTapRunnable, doubleTapWindowMs())
        }
    }

    /**
     * 双击判定窗口。默认 450ms（人手双击通常 250ms 内）。
     *
     * adb 的 `input tap` 每条命令要 ~600ms，程序化注入永远凑不出真实双击，
     * 所以留了个调试口子：`settings put global ms600_doubletap_ms 2000` 可以临时放宽来验证逻辑，
     * `settings delete global ms600_doubletap_ms` 恢复默认。
     */
    private fun doubleTapWindowMs(): Long = try {
        android.provider.Settings.Global.getInt(
            contentResolver, "ms600_doubletap_ms", 450
        ).coerceIn(150, 3000).toLong()
    } catch (e: Throwable) {
        450L
    }

    /** 本次手势是否由我们自己接管（点播页里画面区域的点击）。 */
    private var swallowGesture = false

    /** 点播页底部播放控制条的高度，用来区分"点画面"和"点按钮"。 */
    private val controlBarHeightPx by lazy { dp(132) }


    /**
     * 触摸分发。
     *
     * · 镜像投屏：PlayerView 是 GONE，没有别的处理者，直接判定单击；
     * · 点播 / DLNA：画面区域的点击**由这里接管**（否则会和我们自己的显隐逻辑各切一次，
     *   出现"点一下画面，控制条关了菜单还开着"的错位）；落在底部播放控制条上的触摸原样放行，
     *   进度条拖拽、播放/暂停按钮都不受影响。
     */
    override fun dispatchTouchEvent(ev: MotionEvent): Boolean {
        // 落在投屏面板 / 播放控制条上的触摸不参与手势
        val onUi = isTouchInsideCastPanel(ev) || isInControlBar(ev)
        val screenW = window.decorView.width.takeIf { it > 0 }
            ?: resources.displayMetrics.widthPixels
        val screenH = window.decorView.height.takeIf { it > 0 }
            ?: resources.displayMetrics.heightPixels

        when (ev.actionMasked) {
            MotionEvent.ACTION_DOWN -> {
                tapDownX = ev.x
                tapDownY = ev.y
                tapDownAt = SystemClock.elapsedRealtime()
                gestureMode = 0
                gestureStartY = ev.y
                gestureStartBrightness = currentBrightness()
                gestureStartVolume = currentVolume()
                gestureMaxVolume = maxVolume()
                // 点播页：画面区域的触摸由这里接管（否则会和 PlayerView 的显隐各切一次）
                swallowGesture = !isMirrorSession() && !onUi
                if (swallowGesture) return true
            }
            MotionEvent.ACTION_MOVE -> {
                // v1.2.33 手势：左半屏上下滑 = 亮度，右半屏上下滑 = 音量
                if (!onUi && gestureMaxVolume > 0) {
                    val dy = gestureStartY - ev.y          // 上滑为正
                    if (gestureMode == 0 && kotlin.math.abs(dy) > dp(20)) {
                        gestureMode = if (ev.x < screenW / 2f) 1 else 2
                    }
                    when (gestureMode) {
                        1 -> {
                            val v = (gestureStartBrightness + dy / screenH.toFloat())
                                .coerceIn(0.05f, 1f)
                            applyBrightness(v)
                            showGestureHint("亮度 ${(v * 100).toInt()}%")
                            return true
                        }
                        2 -> {
                            val v = (gestureStartVolume +
                                dy / screenH.toFloat() * gestureMaxVolume)
                                .toInt().coerceIn(0, gestureMaxVolume)
                            applyVolume(v)
                            showGestureHint("音量 $v / $gestureMaxVolume")
                            return true
                        }
                    }
                }
            }
            MotionEvent.ACTION_UP, MotionEvent.ACTION_CANCEL -> {
                val wasSwallowed = swallowGesture
                swallowGesture = false
                if (gestureMode != 0) {
                    gestureMode = 0
                    uiHandler.removeCallbacks(hintHideRunnable)
                    uiHandler.postDelayed(hintHideRunnable, 500)
                    return true
                }
                if (ev.actionMasked == MotionEvent.ACTION_UP && !onUi) {
                    val moved = kotlin.math.abs(ev.x - tapDownX) > tapSlop ||
                        kotlin.math.abs(ev.y - tapDownY) > tapSlop
                    val quick = SystemClock.elapsedRealtime() - tapDownAt < 400
                    if (!moved && quick) handleTap()
                }
                if (wasSwallowed) return true
            }
        }
        // v1.2.32：反向控制（UIBC）已整体移除，触摸不再回传给 Source
        return super.dispatchTouchEvent(ev)
    }


    // ─── 手势：亮度 / 音量 / 双击暂停 ─────────────────────────────────────────

    /** 当前屏幕亮度（0~1）。窗口没设过（跟随系统）时读一次系统值做基准。 */
    private fun currentBrightness(): Float {
        val b = window.attributes.screenBrightness
        if (b >= 0f) return b
        return try {
            android.provider.Settings.System.getInt(
                contentResolver, android.provider.Settings.System.SCREEN_BRIGHTNESS
            ) / 255f
        } catch (e: Throwable) {
            0.6f
        }
    }

    private fun applyBrightness(v: Float) {
        val lp = window.attributes
        lp.screenBrightness = v.coerceIn(0.05f, 1f)
        window.attributes = lp
    }

    private fun audioMgr(): android.media.AudioManager? =
        getSystemService(Context.AUDIO_SERVICE) as? android.media.AudioManager

    private fun currentVolume(): Int = audioMgr()
        ?.getStreamVolume(android.media.AudioManager.STREAM_MUSIC) ?: 0

    private fun maxVolume(): Int = audioMgr()
        ?.getStreamMaxVolume(android.media.AudioManager.STREAM_MUSIC) ?: 0

    private fun applyVolume(v: Int) {
        audioMgr()?.setStreamVolume(
            android.media.AudioManager.STREAM_MUSIC, v.coerceIn(0, maxVolume()), 0
        )
    }

    /** 手势提示：居中短暂显示，1.2 秒后自动消失。 */
    private fun showGestureHint(text: String) {
        if (!::tvGestureHint.isInitialized) return
        tvGestureHint.text = text
        tvGestureHint.visibility = View.VISIBLE
        uiHandler.removeCallbacks(hintHideRunnable)
        uiHandler.postDelayed(hintHideRunnable, 1200)
    }

    /** 双击暂停 / 继续。镜像流是实时的、没有暂停概念，所以只对点播生效。 */
    private fun togglePlayPause() {
        val p = player ?: run {
            android.util.Log.w("MS600Gesture", "togglePlayPause but player is null")
            return
        }
        if (isCurrentImage()) return
        android.util.Log.i(
            "MS600Gesture",
            "togglePlayPause isPlaying=${p.isPlaying} state=${p.playbackState} " +
                "pos=${p.currentPosition}/${p.duration}"
        )
        if (p.isPlaying) {
            p.pause()
            showGestureHint("暂停")
        } else {
            p.play()
            showGestureHint("继续")
        }
    }

    /**
     * 触摸点是否落在底部播放控制条上（只有这条区域要交给 PlayerView 自己处理）。
     *
     * 只在控制条**当前可见**时才这么判定 —— 控制条收起时那条区域只是画面，
     * 点它应该照常唤出菜单。
     */
    private fun isInControlBar(ev: MotionEvent): Boolean {
        if (isMirrorSession() || !isControllerVisible) return false
        return ev.rawY >= (window.decorView.height - controlBarHeightPx)
    }



    override fun onDestroy() {
        super.onDestroy()
        try {
            unregisterReceiver(controlReceiver)
        } catch (e: Exception) {
            Timber.e(e, "Error unregistering receiver")
        }
        stopImageSlideShow()
        stopCastInfoUpdates()
        uiHandler.removeCallbacksAndMessages(null)
        mirrorAspectJob?.cancel()
        mirrorAspectJob = null
        streamInfoJob?.cancel()
        streamInfoJob = null
        window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        // RTP 接收器归 WfdServer 所有（会话结束时由它停止），这里不要碰
        mirrorSurface = null
        onMirrorSessionEnd()
        player?.release()
        player = null
        reportPlaybackStopped()
        Timber.i("PlayerActivity destroyed")
    }

    @Deprecated("Deprecated in Java")
    override fun onBackPressed() {
        stopPlayback()
        super.onBackPressed()
    }
}
