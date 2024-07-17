import 'dart:async';
import 'dart:developer';

import 'package:flag_secure/flag_secure.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? _isFlagSecureEnabled;

  String get _flagSecureLabel {
    if (_isFlagSecureEnabled == null) {
      return 'unknown';
    }

    return _isFlagSecureEnabled! ? 'enabled' : 'disabled';
  }

  @override
  void initState() {
    super.initState();

    _updateIsFlagSecureEnabled();
  }

  Future<void> _updateIsFlagSecureEnabled() async {
    bool? enabled;
    try {
      enabled = await FlagSecure.isFlagSecureEnabled;
    } on PlatformException catch (e) {
      log(e.toString());

      enabled = null;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _isFlagSecureEnabled = enabled;
    });
  }

  Future<void> _enableFlagSecure() async {
    try {
      await FlagSecure.enableFlagSecure();
    } on PlatformException catch (e) {
      log(e.toString());
    }

    await _updateIsFlagSecureEnabled();
  }

  Future<void> _disableFlagSecure() async {
    try {
      await FlagSecure.disableFlagSecure();
    } on PlatformException catch (e) {
      log(e.toString());
    }

    await _updateIsFlagSecureEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flag_secure example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('FLAG_SECURE: $_flagSecureLabel'),
              const Padding(padding: EdgeInsets.symmetric(vertical: 16.0)),
              FilledButton(
                onPressed: _enableFlagSecure,
                child: const Text('Enable'),
              ),
              FilledButton(
                onPressed: _disableFlagSecure,
                child: const Text('Disable'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
