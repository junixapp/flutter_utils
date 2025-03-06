
import 'package:example/DemoBottomDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuck_utils/fuck_utils.dart';
import 'package:fuck_utils/util/dialog_util.dart';
import 'package:fuck_utils/util/log_util.dart';

class WidgetsPage extends StatelessWidget {
  const WidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Wrap(
      children: [
      button(context,"Loading", (){
        DialogUtil.showLoading();
      }),
      button(context,"confirm对话框", (){
        DialogUtil.showConfirm(title: "提示", content: "确定要删除东西吗？", bgColor: Colors.amber);
      }),
      button(context,"bottomList", (){
        DialogUtil.showBottomList(['选项1','选项2', '选项3'], (i){

        });
        LogUtil.i("msg");
      }),
      button(context,"bottom自定义弹窗", (){
        DialogUtil.showBottom( DemoBottomDialog(), radius: 18.w, enableDrag: true);
      }),
      WidgetUtil.textField(context, TextEditingController(), "hint文字", margin: EdgeInsets.all(15.w),
        borderWidth: 1.w, radius: 10.w, padding: EdgeInsets.all(10.w), borderColor: Colors.red,
      fontColor: Colors.blue),
      CommonTabBar(tabs: ["card模式","dd", "打湿水"], onTabChange: (i){

      }, tabPadding: EdgeInsets.symmetric(horizontal: 10.w), indicatorHeight: 3.w,
      tabStyle: TabStyle.card, selectBgColor: Colors.black, selectColor: Colors.white, unselectColor: Colors.grey,
      tabSpace: 10.w, unselectBgColor: Colors.grey.withAlpha(100),),
      CommonTabBar(tabs : ["line模式","dd", "打湿水"], onTabChange: (i){

      },  indicatorHeight: 3.w, tabEqual: true, padding: 15.w,
      tabStyle: TabStyle.line, selectBgColor: Colors.red,
      tabSpace: 10.w, unselectBgColor: Colors.grey,),
    ],),);
  }

  Widget button(BuildContext context, String text, VoidCallback onTap){
    return SuperText(text, onTap: onTap, borderColor: Theme.of(context).primaryColor,
      borderWidth: 1.w, radius: 20.w, padding: EdgeInsets.symmetric(horizontal: 10.w,
      vertical: 4.w),margin: EdgeInsets.all(8.w),
    );
  }
}
