import 'dart:async';

import 'package:flutter/services.dart';

class BluetoothPlugin {
  static const MethodChannel _channel = MethodChannel('bluetooth_plugin');

  static Future<List?> scan() async {
    final scanResult = await _channel.invokeMethod("scan", []);
    return scanResult;
  }
}
