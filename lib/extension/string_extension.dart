import 'package:flutter/widgets.dart';

extension FixAutoLines on String {
  ///给字符增加0宽字符，让文字自然换行，不跟随单词换行
  String fixAutoLines() {
    return Characters(this).join("\u{200B}");
  }
}