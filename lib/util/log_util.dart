import 'package:logger/logger.dart';

class LogUtil {
  LogUtil._();

  static var _enable = true;

  static void init(bool enable){
    _enable = enable;
  }

  static var logger = Logger(
    printer: PrettyPrinter(printEmojis: true, colors: true,
    printTime: false),
  );

  static void i(dynamic msg) {
    if (msg == null || !_enable) return;
    logger.i(msg, time: DateTime.now());
  }

  static void e(dynamic msg, {StackTrace? stackTrace}) {
    if (msg == null || !_enable) return;
    logger.e(msg, time: DateTime.now(), stackTrace: stackTrace);
  }

}
