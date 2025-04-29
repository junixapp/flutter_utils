import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuck_utils/extension/color_extension.dart';

class ToastUtil {
  ToastUtil._();

  static var _dark = false; ///是否是暗色调
  static var _darkBgColor = Colors.black87; ///暗色调背景色
  static var _lightBgColor = Colors.white; ///亮色调背景色
  static var _darkTextColor = Colors.white; ///暗色调文字颜色
  static var _lightTextColor = Colors.black; ///亮色调文字颜色
  static var _textSize = 14.0;

  static void config({bool dark = false, Color? darkBgColor, Color? lightBgColor,
    Color? darkTextColor, Color? lightTextColor, double? textSize}){
    _dark = dark;
    if(darkBgColor!=null) _darkBgColor = darkBgColor;
    if(lightBgColor!=null) _lightBgColor = lightBgColor;
    if(darkTextColor!=null) _darkTextColor = darkTextColor;
    if(lightTextColor!=null) _lightTextColor = lightTextColor;
    if(textSize!=null) _textSize = textSize;
  }

  static void toast(String? msg, {bool long = false}) {
    if (msg == null || msg.isEmpty) return;
    if(!kIsWeb)Fluttertoast.cancel();
    var bgColor = _dark ? _darkBgColor : _lightBgColor;
    var textColor = _dark ? _darkTextColor : _lightTextColor;
    Fluttertoast.showToast(
        msg: msg,
        toastLength: long ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: textColor,
        webBgColor: bgColor.rgbaString(),
        webPosition: "center",
        fontSize: _textSize);
  }
}
