import 'dart:async';

import 'package:flutter/services.dart';

class Txqr {
  static const MethodChannel _channel = const MethodChannel('txqr');

  static Future<Null> newDecoder() async {
    await _channel.invokeMethod('newDecoder');
  }

  static Future<bool> isCompleted() async {
    return await _channel.invokeMethod('isCompleted');
    ;
  }

  static Future<String> data() async {
    return await _channel.invokeMethod('data');
  }

  static Future<ByteData> dataBytes() async {
    return await _channel.invokeMethod('dataBytes');
  }

  static Future<Null> decode(String data) async {
    _channel.invokeMethod('decode', {"data": data});
  }

  static Future<int> incRefnum() async {
    return await _channel.invokeMethod('incRefnum');
  }

  static Future<int> progress() async {
    return await _channel.invokeMethod('progress');
  }

  static Future<int> length() async {
    return await _channel.invokeMethod('length');
  }

  static Future<String> totalSize() async {
    return await _channel.invokeMethod('totalSize');
  }

  static Future<String> speed() async {
    return await _channel.invokeMethod('speed');
  }

  static Future<String> totalTime() async {
    return await _channel.invokeMethod('totalTime');
  }

  static Future<int> totalTimeMs() async {
    return await _channel.invokeMethod('totalTimeMs');
  }

  static Future<String> read() async {
    return await _channel.invokeMethod('read');
  }

  static Future<int> readInterval() async {
    return await _channel.invokeMethod('readInterval');
  }

  static Future<Null> reset() async {
    await _channel.invokeMethod('reset');
  }
}
