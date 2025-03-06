
import 'package:example/controllers/main_controller.dart';
import 'package:example/pages/widgets_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuck_utils/widget/common_scaffold.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{

  MainController mainController = Get.find();
  late TabController tabController ;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: mainController.tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(title: "Title",
      leftTitle: true,
      leftWidget: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).colorScheme.onPrimary, size: 18.w,),
      onLeftClick: (){

      }, titleBarBg: Colors.green, paddingStatusBar: true,
      body: Column(children: [
      TabBar(tabs: mainController.tabs.map((e) => Text(e)).toList(), controller: tabController,
        labelPadding: EdgeInsets.only(bottom: 6.w),
        padding: EdgeInsets.only(top: 10.w),
        labelStyle: TextStyle(fontSize: 16.w),
        labelColor: Colors.black,
        isScrollable: true,
      ),
      Divider(height: 1.w,),
      Expanded(child: TabBarView(children: [
        WidgetsPage(),
      ], controller: tabController,))
    ],),);
  }
}


