
import 'dart:convert';

import 'package:flutter/widgets.dart';

class StringUtil{
  StringUtil._();

  ///给字符增加0宽字符，让文字自然换行，不跟随单词换行
  static String fixTextWrap(String text) {
    return Characters(text).join("\u{200B}");
  }

  static bool equalIgnoreCase(String s1, String s2) {
    return s1.toLowerCase() == s2.toLowerCase();
  }

  static bool isEmpty(String? s) {
    return s == null || s.isEmpty;
  }

  static bool isJson(String? s) {
    if(s==null || s.isEmpty) return false;
    try{
      jsonDecode(s);
      return true;
    } catch(e) {
      return false;
    }
  }
}