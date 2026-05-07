package com.callshield.app

import android.telecom.CallScreeningService
import android.telecom.Call.Details

class CallShieldService : CallScreeningService() {

    private val engine = SmartBlockEngine()

    override fun onScreenCall(call: Details) {
        val number = call.handle.schemeSpecificPart ?: return

        val shouldBlock = engine.shouldBlock(number)

        val response = CallResponse.Builder()
            .setDisallowCall(shouldBlock)
            .setRejectCall(shouldBlock)
            .setSkipCallLog(shouldBlock)
            .setSkipNotification(shouldBlock)
            .build()

        respondToCall(call, response)
    }
}
