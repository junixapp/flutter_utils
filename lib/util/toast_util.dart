import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuck_utils/extension/color_extension.dart';
import 'package:get/get.dart';

class ToastUtil {
  ToastUtil._();
  static void toast(String? msg, {BuildContext? context}) {
    if (msg == null || msg.isEmpty) return;
    if(!kIsWeb)Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context ?? Get.context!).primaryColor,
        textColor: Theme.of(context ?? Get.context!).colorScheme.onPrimary,
        webBgColor: Theme.of(context ?? Get.context!).primaryColor.rgbaString(withAlpha: false),
        webPosition: "center",
        fontSize: 14);
  }
}
