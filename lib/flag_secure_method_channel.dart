import 'dart:io';

import 'package:flag_secure/flag_secure_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// An implementation of [FlagSecurePlatform] that uses method channels.
class MethodChannelFlagSecure extends FlagSecurePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  static const methodChannel = MethodChannel('flag_secure');

  /// Returns whether `FLAG_SECURE` is enabled.
  @override
  Future<bool?> isFlagSecureEnabled() async {
    if (!Platform.isAndroid) {
      return Future.value();
    }

    return await methodChannel.invokeMethod("isFlagSecureEnabled");
  }

  /// Enables `FLAG_SECURE`.
  @override
  Future<void> enableFlagSecure() async {
    if (!Platform.isAndroid) {
      return Future.value();
    }

    return await methodChannel.invokeMethod("enableFlagSecure");
  }

  /// Disables `FLAG_SECURE`.
  @override
  Future<void> disableFlagSecure() async {
    if (!Platform.isAndroid) {
      return Future.value();
    }

    return await methodChannel.invokeMethod("disableFlagSecure");
  }
}
