
import 'package:flutter/widgets.dart';

class StringUtl{
  StringUtl._();

  ///给字符增加0宽字符，让文字自然换行，不跟随单词换行
  static String fixTextWrap(String text) {
    return Characters(text).join("\u{200B}");
  }
}