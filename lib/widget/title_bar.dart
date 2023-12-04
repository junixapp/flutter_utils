import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuck_utils/fuck_utils.dart';

/// 标题栏
class TitleBar extends StatelessWidget {
  final VoidCallback? onLeftClick;
  final VoidCallback? onRightClick;
  final bool hasDivider;
  final bool leftTitle;
  final bool boldTitle;
  final String? rightImage;
  final Widget? rightWidget;
  final Widget? leftWidget;
  final String title;
  final double? titleSize;
  final Color? titleColor;
  final Color? bgColor;
  final Widget? titleWidget;
  final double? height;

  const TitleBar({
    super.key,
    this.onLeftClick,
    this.onRightClick,
    this.hasDivider = true,
    this.leftTitle = false,
    this.boldTitle = false,
    this.titleSize,
    this.titleColor,
    this.bgColor,
    this.title = "",
    this.titleWidget,
    this.leftWidget,
    this.rightWidget,
    this.rightImage,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: height ?? (46.w +  MediaQuery.of(context).padding.top ),
      decoration:BoxDecoration(border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor,
        width:  hasDivider ? 1.w : 0),),
        color: bgColor),
      child: Stack(children: [
          OnClick(Container(alignment: Alignment.center,
            width: 42.w, height: 42.w,
            child: leftWidget ?? Icon(Icons.arrow_back, size: 22.w,),
          ), onTap: () {
              if (onLeftClick != null) {
                onLeftClick!();
              } else {
                Navigator.pop(context);
              }
            },
          ),
          Align( alignment: leftTitle ? Alignment.centerLeft : Alignment.center,
            child: titleWidget ?? Container(width: 200.w, height: 42.w,
                alignment: leftTitle ? Alignment.centerLeft : Alignment.center,
              margin: EdgeInsets.only(right: 5.w, left: leftTitle ? 50.w : 0),
              child: Text(title, style: TextStyle(
                  color: titleColor ?? Theme.of(context).colorScheme.primary,
                  fontSize: titleSize ?? 16.w,
                  fontWeight: boldTitle ? FontWeight.w600 : FontWeight.normal),
                maxLines: 1, overflow: TextOverflow.ellipsis,)),),
          Align(alignment: Alignment.centerRight, child: rightWidget ?? OnClick( Container(alignment: Alignment.center,
             width: 42.w, height: 42.w,
            child: (rightImage!=null ? Image.asset(rightImage??"") : const SizedBox())), onTap: onRightClick,))
        ],
      ),);
  }
}
