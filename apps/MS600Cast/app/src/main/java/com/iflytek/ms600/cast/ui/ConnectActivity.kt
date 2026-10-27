package com.iflytek.ms600.cast.ui

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.iflytek.ms600.cast.R
import timber.log.Timber

/**
 * 连接确认页面
 */
class ConnectActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_connect)
        Timber.i("ConnectActivity created")
    }
}
