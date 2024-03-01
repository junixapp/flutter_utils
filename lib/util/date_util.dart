import 'package:intl/intl.dart';

/// Date Util.
class DateUtil {
  /// get Now Date Milliseconds.
  static int nowMs() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// get Now Date Str.(yyyy-MM-dd HH:mm:ss)
  static String nowFormat({String format = "yyyy-MM-dd HH:mm:ss"}) {
    return formatDate(DateTime.now(), format: format);
  }

  static String formatMs(int ms, {bool isUtc = false, String format = "yyyy-MM-dd HH:mm:ss"}){
    var date = DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc);
    return DateFormat(format).format(date);
  }

  static String formatDate(DateTime date, {String format = "yyyy-MM-dd HH:mm:ss"}){
    return DateFormat(format).format(date);
  }

  /// year is equal.
  /// 是否同年.
  static bool isSameYear(DateTime dateTime, DateTime locDateTime) {
    return dateTime.year == locDateTime.year;
  }

  /// year is equal.
  /// 是否同年.
  static bool isSameYearByMs(int ms, int locMs) {
    return isSameYear(DateTime.fromMillisecondsSinceEpoch(ms),
        DateTime.fromMillisecondsSinceEpoch(locMs));
  }

  /// Return whether it is leap year.
  /// 是否是闰年
  static bool isLeapYear(DateTime dateTime) {
    return isLeapYearByYear(dateTime.year);
  }

  /// Return whether it is leap year.
  /// 是否是闰年
  static bool isLeapYearByYear(int year) {
    return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
  }
}