import 'package:flutter/services.dart';

class AppServices {
  static const MethodChannel _channel = MethodChannel('samples.flutter.dev/');

  static Future<bool> checkConnectivity() async {
    final bool isOnline = await _channel.invokeMethod('checkConnectivity');
    return isOnline;
  }
}
