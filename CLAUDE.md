# flag_secure

Flutter plugin published on pub.dev to set, unset and read Android's `FLAG_SECURE` at runtime (it hides the app from screenshots, screen recordings and the recent apps). Android only; on other platforms the methods do nothing and `isSet` returns `null`. BSD-3-Clause.

Its main user is Material Notes (`maelchiotti/LocalMaterialNotes`, `SystemUtils().setFlagSecureIfNeeded()`): treat any change of a public signature as breaking.

## Commands

- Install: `flutter pub get` (and in `example`).
- Format: `dart format <files>` (default width, 80).
- Analyze: `dart analyze --fatal-infos`.
- Example: `cd example && flutter run` on an Android device or emulator; the native code is only checked by building it (`cd example && flutter build apk --debug`, needs the Android SDK).
- Publish: `dart pub publish --dry-run` only; the maintainer publishes (`RELEASING.md`).

There are no tests. The `check` skill runs every check and the `release` skill prepares a version.

Running `flutter pub get` with a newer Flutter rewrites `example/pubspec.lock`: only commit it when the dependencies are meant to change.

## Structure

Federated-style plugin in one package:

- `lib/flag_secure.dart`: the public API, `FlagSecure.isSet`, `FlagSecure.set()`, `FlagSecure.unset()`, static and documented with a `try`/`on PlatformException` example.
- `lib/flag_secure_platform_interface.dart`: `FlagSecurePlatform` (`plugin_platform_interface`, with a token).
- `lib/flag_secure_method_channel.dart`: `MethodChannelFlagSecure`, on the `flag_secure` channel, with the methods `isSet`, `set` and `unset`. It returns early when `Platform.isAndroid` (`universal_io`) is false.
- `android/src/main/kotlin/com/maelchiotti/flag_secure/flag_secure/FlagSecurePlugin.kt`: the native side (`ActivityAware`), which adds or clears `WindowManager.LayoutParams.FLAG_SECURE` on the activity window and answers `not-found-activity` when there is no activity.

A new method goes through the four layers: the public API, the platform interface, the method channel (with the non-Android guard) and the Kotlin `onMethodCall`, with the same method name everywhere. Then show it in `example/lib/main.dart` and the README.

## Code style

- `flutter_lints` with `public_member_api_docs`, `always_put_control_body_on_new_line`, `curly_braces_in_flow_control_structures`.
- Package imports (`package:flag_secure/...`).
- Every public member has a `///` doc comment. Kotlin functions have a KDoc comment.

## Git

Commits on `main`, and a `vX.Y.Z` commit for each version. `CHANGELOG.md` follows Keep a Changelog.
