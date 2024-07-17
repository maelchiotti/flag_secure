# flag_secure

![Pub Version](https://img.shields.io/pub/v/flag_secure)

A Flutter plugin to manage Android's FLAG_SECURE at runtime.

## Installing

See the [installing instructions](https://pub.dev/packages/flag_secure/install).

## Usage

- Get whether `FLAG_SECURE` is set:

  ```dart
  try {
    final bool? enabled = await FlagSecure.isFlagSecureEnabled;
  } on PlatformException {
    // Handle exception
  }
  ```

- Enable `FLAG_SECURE`:

  ```dart
  try {
    await FlagSecure.enableFlagSecure();
  } on PlatformException {
    // Handle exception
  }
  ```

- Disable `FLAG_SECURE`:

  ```dart
  try {
    await FlagSecure.disableFlagSecure();
  } on PlatformException {
    // Handle exception
  }
  ```

## Example

See the [example app](https://pub.dev/packages/flag_secure/example).
