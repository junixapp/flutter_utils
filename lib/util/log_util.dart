import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogUtil {
  LogUtil._();
  static var logger = Logger(
    printer: PrettyPrinter(printEmojis: false, colors: true),
  );

  static void i(dynamic msg) {
    if (msg == null || kReleaseMode) return;
    logger.i(msg, time: DateTime.now());
  }

  static void e(dynamic msg) {
    if (msg == null || kReleaseMode) return;
    logger.e(msg, time: DateTime.now());
  }

}
