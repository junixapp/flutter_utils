
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuck_utils/fuck_utils.dart';

class CommonController extends GetxController{
  late SharedPreferences sp;
  @override
  void onInit() async{
    super.onInit();
    ///固定垂直方向
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
    ///状态栏背景透明
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    ///初始化sp
    sp = await SharedPreferences.getInstance();
  }
}