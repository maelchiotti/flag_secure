# flag_secure

![Pub Version](https://img.shields.io/pub/v/flag_secure)

A Flutter plugin to manage Android's FLAG_SECURE at runtime.

## Installing

See the [installing instructions](https://pub.dev/packages/flag_secure/install).

## Usage

- Get whether `FLAG_SECURE` is set:

  ```dart
  try {
    final bool? isSet = await FlagSecure.isSet;
  } on PlatformException {
    // Handle exception
  }
  ```

- Set `FLAG_SECURE`:

  ```dart
  try {
    await FlagSecure.set();
  } on PlatformException {
    // Handle exception
  }
  ```

- Unset `FLAG_SECURE`:

  ```dart
  try {
    await FlagSecure.unset();
  } on PlatformException {
    // Handle exception
  }
  ```

## Example

See the [example app](https://pub.dev/packages/flag_secure/example).
