import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ToastUtil {
  ToastUtil._();
  static void toast(String? msg, {BuildContext? context}) {
    if (msg == null || msg.isEmpty) return;
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context ?? Get.context!).primaryColor,
        textColor: Theme.of(context ?? Get.context!).colorScheme.onPrimary,
        fontSize: 14.w);
  }
}
