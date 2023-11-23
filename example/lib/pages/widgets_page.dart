
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
        DialogUtil.showBottom(SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(height: 100, color: Colors.amber,),
          WidgetUtil.textField(context, TextEditingController(), "请输入搜索内容", padding: EdgeInsets.symmetric(
            horizontal: 15.w, vertical: 8.w,), borderWidth: 1.w, borderColor: Theme.of(context).dividerColor,
            radius: 30.w, margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w)),
          Container(height: 100, color: Colors.white,),
        ],),), radius: 8.w, bgColor: Colors.white);
      }),
    ],),);
  }

  Widget button(BuildContext context, String text, VoidCallback onTap){
    return SuperText(text, onTap: onTap, borderColor: Theme.of(context).primaryColor,
      borderWidth: 1.w, radius: 20.w, padding: EdgeInsets.symmetric(horizontal: 10.w,
      vertical: 4.w),margin: EdgeInsets.all(8.w),
    );
  }
}
