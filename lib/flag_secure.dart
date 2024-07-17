// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flag_secure/flag_secure_platform_interface.dart';

/// A Flutter plugin to manage Android's `FLAG_SECURE` at runtime.
class FlagSecure {
  /// Returns whether `FLAG_SECURE` is enabled.
  ///
  /// The result can be null.
  ///
  /// This can throw a `PlatformException` and should be surrounded with a `try/catch`.
  ///
  /// Example:
  /// ```dart
  /// try {
  ///   final bool? enabled = await FlagSecure.isFlagSecureEnabled;
  /// } on PlatformException {
  ///   // Handle exception
  /// }
  /// ```
  static Future<bool?> get isFlagSecureEnabled {
    return FlagSecurePlatform.instance.isFlagSecureEnabled();
  }

  /// Enables `FLAG_SECURE`.
  ///
  /// This can throw a `PlatformException` and should be surrounded with a `try/catch`.
  ///
  /// Example:
  /// ```dart
  /// try {
  ///   await FlagSecure.enableFlagSecure();
  /// } on PlatformException {
  ///   // Handle exception
  /// }
  /// ```
  static Future<void> enableFlagSecure() {
    return FlagSecurePlatform.instance.enableFlagSecure();
  }

  /// Disables `FLAG_SECURE`.
  ///
  /// This can throw a `PlatformException` and should be surrounded with a `try/catch`.
  ///
  /// Example:
  /// ```dart
  /// try {
  ///   await FlagSecure.disableFlagSecure();
  /// } on PlatformException {
  ///   // Handle exception
  /// }
  /// ```
  static Future<void> disableFlagSecure() {
    return FlagSecurePlatform.instance.disableFlagSecure();
  }
}
