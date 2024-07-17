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

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flag_secure")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "isFlagSecureEnabled" -> isFlagSecureEnabled(result)

      "enableFlagSecure" -> enableFlagSecure(result)
      "disableFlagSecure" -> disableFlagSecure(result)

      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  /**
   * Returns whether `FLAG_SECURE` is enabled.
   *
   * @return `true` if `FLAG_SECURE` is enabled, `false` otherwise.
   */
  private fun isFlagSecureEnabled(result: Result) {
    val window = activity?.window

    if (window == null) {
      result.error("not-found-activity", "Not found 'activity'.", null)
      return
    }

    var flags = window.attributes.flags
    var isFlagSecureEnabled = (flags and WindowManager.LayoutParams.FLAG_SECURE) != 0

    result.success(isFlagSecureEnabled)
  }

  /**
   * Enables `FLAG_SECURE`.
   */
  private fun enableFlagSecure(result: Result) {
    val window = activity?.window

    if (window == null) {
      result.error("not-found-activity", "Not found 'activity'.", null)
      return
    }

    window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)

    result.success(true)
  }

  /**
   * Disables `FLAG_SECURE`.
   */
  private fun disableFlagSecure(result: Result) {
    val window = activity?.window

    if (window == null) {
      result.error("not-found-activity", "Not found 'activity'.", null)
      return
    }

    window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)

    result.success(true)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }
}
