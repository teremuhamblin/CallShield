package com.callshield.app

class SmartBlockEngine {

    private val blacklist = listOf(
        "+33970000000",
        "+33800000000"
    )

    fun shouldBlock(number: String): Boolean {
        if (number in blacklist) return true
        if (number.startsWith("+338")) return true
        return false
    }
}
