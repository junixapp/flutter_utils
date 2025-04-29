
import 'package:flutter/material.dart';
import 'package:fuck_utils/fuck_utils.dart';
import 'package:get/get.dart';

class MainController extends CountDownController{
  final tabs = ["Widget"];

  var data = "".obx;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async{
    data.setLoading();
    await Future.delayed(Duration(seconds: 2));
    data.setSuccess();
  }
}