import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuck_utils/util/widget_util.dart';

class DemoBottomDialog extends StatefulWidget {
  const DemoBottomDialog({super.key});

  @override
  State<DemoBottomDialog> createState() => _DemoBottomDialogState();
}

class _DemoBottomDialogState extends State<DemoBottomDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.zero, child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(height: 100, color: Colors.amber,),
      WidgetUtil.textField(context, TextEditingController(), "请输入搜索内容", padding: EdgeInsets.symmetric(
        horizontal: 15.w, vertical: 8.w,), borderWidth: 1.w,
          radius: 30.w, margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w)),
      Container(height: 100, color: Colors.white,),
    ],),);
  }
}
