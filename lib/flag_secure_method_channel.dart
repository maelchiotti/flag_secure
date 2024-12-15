import 'package:flag_secure/flag_secure_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:universal_io/io.dart';

/// An implementation of [FlagSecurePlatform] that uses method channels.
class MethodChannelFlagSecure extends FlagSecurePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  static const methodChannel = MethodChannel('flag_secure');

  /// Returns whether `FLAG_SECURE` is set.
  @override
  Future<bool?> isSet() async {
    if (!Platform.isAndroid) {
      return Future.value();
    }

    return await methodChannel.invokeMethod("isSet");
  }

  /// Sets `FLAG_SECURE`.
  @override
  Future<void> set() async {
    if (!Platform.isAndroid) {
      return Future.value();
    }

    return await methodChannel.invokeMethod("set");
  }

  /// Unsets `FLAG_SECURE`.
  @override
  Future<void> unset() async {
    if (!Platform.isAndroid) {
      return Future.value();
    }

    return await methodChannel.invokeMethod("unset");
  }
}
