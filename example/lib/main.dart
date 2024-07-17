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
  bool? _isFlagSecureSet;

  String get _flagSecureLabel {
    if (_isFlagSecureSet == null) {
      return 'unknown';
    }

    return _isFlagSecureSet! ? 'set' : 'not set';
  }

  @override
  void initState() {
    super.initState();

    _updateIsFlagSecureSet();
  }

  Future<void> _updateIsFlagSecureSet() async {
    bool? isSet;
    try {
      isSet = await FlagSecure.isSet;
    } on PlatformException catch (e) {
      log(e.toString());

      isSet = null;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _isFlagSecureSet = isSet;
    });
  }

  Future<void> _setFlagSecure() async {
    try {
      await FlagSecure.set();
    } on PlatformException catch (e) {
      log(e.toString());
    }

    await _updateIsFlagSecureSet();
  }

  Future<void> _unsetFlagSecure() async {
    try {
      await FlagSecure.unset();
    } on PlatformException catch (e) {
      log(e.toString());
    }

    await _updateIsFlagSecureSet();
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
                onPressed: _setFlagSecure,
                child: const Text('Set'),
              ),
              FilledButton(
                onPressed: _unsetFlagSecure,
                child: const Text('Unset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
