import 'package:flag_secure/flag_secure_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// Platform to handle the `FLAG_SECURE`.
abstract class FlagSecurePlatform extends PlatformInterface {
  /// Constructs the platform.
  FlagSecurePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlagSecurePlatform _instance = MethodChannelFlagSecure();

  /// The default instance of [FlagSecurePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlagSecure].
  static FlagSecurePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlagSecurePlatform] when
  /// they register themselves.
  static set instance(FlagSecurePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Returns whether `FLAG_SECURE` is set.
  Future<bool?> isSet() async {
    throw UnimplementedError('isSet() has not been implemented.');
  }

  /// Sets `FLAG_SECURE`.
  Future<void> set() async {
    throw UnimplementedError('set() has not been implemented.');
  }

  /// Unsets `FLAG_SECURE`.
  Future<void> unset() async {
    throw UnimplementedError('unset() has not been implemented.');
  }
}
