package com.maelchiotti.flag_secure.flag_secure

import android.app.Activity
import android.view.WindowManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/**
 * A Flutter plugin to manage Android's `FLAG_SECURE` at runtime.
 */
class FlagSecurePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel

    private var activity: Activity? = null

    /**
     * Whether `FLAG_SECURE` was last set (`true`) or unset (`false`) through this plugin, or `null` if neither was
     * called yet.
     *
     * Used to apply the same state to the window of a new activity attached to the engine.
     */
    private var flagSecureRequested: Boolean? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flag_secure")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "isSet" -> isFlagSecureSet(result)

            "set" -> setFlagSecure(result)
            "unset" -> unsetFlagSecure(result)

            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    /**
     * Returns whether `FLAG_SECURE` is set.
     *
     * @return `true` if `FLAG_SECURE` is set, `false` otherwise.
     */
    private fun isFlagSecureSet(result: Result) {
        val window = activity?.window

        if (window == null) {
            result.error("not-found-activity", "Not found 'activity'.", null)
            return
        }

        var flags = window.attributes.flags
        var isFlagSecureSet = (flags and WindowManager.LayoutParams.FLAG_SECURE) != 0

        result.success(isFlagSecureSet)
    }

    /**
     * Sets `FLAG_SECURE`.
     */
    private fun setFlagSecure(result: Result) {
        val window = activity?.window

        if (window == null) {
            result.error("not-found-activity", "Not found 'activity'.", null)
            return
        }

        window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
        flagSecureRequested = true

        result.success(true)
    }

    /**
     * Unsets `FLAG_SECURE`.
     */
    private fun unsetFlagSecure(result: Result) {
        val window = activity?.window

        if (window == null) {
            result.error("not-found-activity", "Not found 'activity'.", null)
            return
        }

        window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
        flagSecureRequested = false

        result.success(true)
    }

    /**
     * Applies the last state requested through this plugin to the window of the current activity, if any.
     *
     * The flag belongs to the window, so a new activity doesn't have it. Does nothing if neither [setFlagSecure] nor
     * [unsetFlagSecure] was called yet, to keep the flags the application set itself.
     */
    private fun applyRequestedFlagSecure() {
        val window = activity?.window ?: return

        when (flagSecureRequested) {
            true -> window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
            false -> window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
            null -> {}
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        applyRequestedFlagSecure()
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        applyRequestedFlagSecure()
    }

    override fun onDetachedFromActivity() {
        activity = null
    }
}
