package com.iflytek.ms600.cast.security

import com.iflytek.ms600.cast.utils.NetworkUtils

/**
 * PIN 码管理器
 */
class PinCodeManager {

    private var currentPinCode: String = NetworkUtils.generateConnectionCode()

    fun getCurrentPinCode(): String = currentPinCode

    fun regeneratePinCode(): String {
        currentPinCode = NetworkUtils.generateConnectionCode()
        return currentPinCode
    }

    fun validatePinCode(pinCode: String): Boolean {
        return pinCode.equals(currentPinCode, ignoreCase = true)
    }
}
