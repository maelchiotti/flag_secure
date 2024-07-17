import 'package:flag_secure/flag_secure_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class FlagSecurePlatform extends PlatformInterface {
  /// Constructs a FlagSecurePlatform.
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

  /// Returns whether `FLAG_SECURE` is enabled.
  Future<bool?> isFlagSecureEnabled() async {
    throw UnimplementedError('isFlagSecureEnabled() has not been implemented.');
  }

  /// Enables `FLAG_SECURE`.
  Future<void> enableFlagSecure() async {
    throw UnimplementedError('enableFlagSecure() has not been implemented.');
  }

  /// Disables `FLAG_SECURE`.
  Future<void> disableFlagSecure() async {
    throw UnimplementedError('disableFlagSecure() has not been implemented.');
  }
}
