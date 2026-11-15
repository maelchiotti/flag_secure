# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 2.1.0 - 2026-11-15

### Changed

- Migrated to [Built-in Kotlin](https://docs.flutter.dev/release/breaking-changes/migrate-to-built-in-kotlin/for-plugin-authors): the plugin no longer applies the Kotlin Gradle Plugin.
- Raised the minimum versions to Flutter 3.44 and Dart 3.12.
- Renamed the Android package from `com.maelchiotti.flag_secure.flag_secure` to `com.maelchiotti.flag_secure`.

### Fixed

- Apply `FLAG_SECURE` again to a new activity attached to the engine (for example after a configuration change), as set or unset last.

## 2.0.2 - 2024-12-15

### Changed

- Swapped [dart:io](https://dart.dev/libraries/dart-io) with [universal_io](https://pub.dev/packages/universal_io).

## 2.0.1 - 2024-10-13

### Changed

- Loosen SDK requirement.

## Fixed

- Missing scroll view in the example.

## 2.0.0 - 2024-07-17

### BREAKING CHANGES

- Rename all methods to simplify them:
    - `isFlagSecureEnabled` → `isSet`
    - `enableFlagSecure()` → `set()`
    - `disableFlagSecure()` → `unset()`

## 1.0.2 - 2024-07-17

### Fixed

- Fix some documentation issues.

## 1.0.1 - 2024-07-17

### Fixed

- Fix some documentation issues.

## 1.0.0 - 2024-07-17

Initial release.
