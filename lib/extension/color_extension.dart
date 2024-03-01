
import 'dart:ui';

extension FuckColorExtension on Color {

  ///Color -> #00ffffff
  String rgbaString({bool withAlpha = true}) =>
      withAlpha ? '#${value.toRadixString(16).padLeft(8, '0')}'
      : '#${value.toRadixString(16).substring(2).padLeft(6, '0')}';
}