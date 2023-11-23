import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuck_utils/fuck_utils.dart';

/// 标题栏
class TitleBar extends StatelessWidget {
  final VoidCallback? onBackClick;
  final VoidCallback? onRightClick;
  final bool hasDivider;
  final String? rightIcon;
  final String title;
  final Widget? titleWidget;
  final double? height;

  const TitleBar({
    super.key,
    this.onBackClick,
    this.onRightClick,
    this.hasDivider = true,
    this.title = "",
    this.titleWidget,
    this.rightIcon = "",
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
      height: height ?? 46.w,
      decoration: hasDivider ? BoxDecoration(border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor,
        width: 1.w),)) : null,
      child: Stack(children: [
          OnClick(Container(alignment: Alignment.center,
            width: 42.w, height: 42.w,
            margin: EdgeInsets.only(left: 5.w),
            child: Icon(Icons.arrow_back, size: 16.w,),
          ), onTap: () {
              if (onBackClick != null) {
                onBackClick!();
              } else {
                Navigator.pop(context);
              }
            },
          ),
          Center(child: titleWidget ?? Container(width: 200.w, alignment: Alignment.center,
              margin: EdgeInsets.only(right: 5.w),
              child: Text(title, style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16.w,
                  fontWeight: FontWeight.w600),
                maxLines: 1, overflow: TextOverflow.ellipsis,)),),
         if(rightIcon!=null) OnClick(Container(alignment: Alignment.center,
                margin: EdgeInsets.only(right: 5.w), width: 42.w, height: 42.w,
                child: Image.asset(rightIcon!),), onTap: onRightClick,)
        ],
      ),
    ));
  }
}
