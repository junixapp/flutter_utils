
import 'dart:ui';

extension FuckColorExtension on Color {
  ///给字符增加0宽字符，让文字自然换行，不跟随单词换行
  String rgbaString({bool withAlpha = true}) =>
      withAlpha ? '#${value.toRadixString(16).padLeft(8, '0')}'
      : '#${value.toRadixString(16).substring(2).padLeft(6, '0')}';
}