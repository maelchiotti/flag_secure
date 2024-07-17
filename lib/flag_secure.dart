// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flag_secure/flag_secure_platform_interface.dart';

/// A Flutter plugin to manage Android's `FLAG_SECURE` at runtime.
class FlagSecure {
  /// Returns whether `FLAG_SECURE` is set.
  ///
  /// The result can be null.
  ///
  /// This can throw a `PlatformException` and should be surrounded with a `try/catch`.
  ///
  /// Example:
  /// ```dart
  /// try {
  ///   final bool? isSet = await FlagSecure.isSet;
  /// } on PlatformException {
  ///   // Handle exception
  /// }
  /// ```
  static Future<bool?> get isSet {
    return FlagSecurePlatform.instance.isSet();
  }

  /// Sets `FLAG_SECURE`.
  ///
  /// This can throw a `PlatformException` and should be surrounded with a `try/catch`.
  ///
  /// Example:
  /// ```dart
  /// try {
  ///   await FlagSecure.set();
  /// } on PlatformException {
  ///   // Handle exception
  /// }
  /// ```
  static Future<void> set() {
    return FlagSecurePlatform.instance.set();
  }

  /// Unsets `FLAG_SECURE`.
  ///
  /// This can throw a `PlatformException` and should be surrounded with a `try/catch`.
  ///
  /// Example:
  /// ```dart
  /// try {
  ///   await FlagSecure.unset();
  /// } on PlatformException {
  ///   // Handle exception
  /// }
  /// ```
  static Future<void> unset() {
    return FlagSecurePlatform.instance.unset();
  }
}
