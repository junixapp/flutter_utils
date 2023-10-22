import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 标题栏
class TitleBar extends StatelessWidget {
  final VoidCallback? onBackClick;
  final VoidCallback? onRightClick;
  final bool hasLeft;
  final String? leftTitle;
  final String? rightIcon;
  final Widget? rightWidget;
  final String title;
  final Widget? titleWidget;
  final double? width;
  final double? height;

  const TitleBar({
    super.key,
    this.onBackClick,
    this.onRightClick,
    this.hasLeft = true,
    this.leftTitle,
    this.title = "",
    this.titleWidget,
    this.rightIcon = "",
    this.rightWidget,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: height ?? 44.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: hasLeft
                ? Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 42.w,
                        height: 42.w,
                        margin: EdgeInsets.only(left: 5.w),
                        child: Icon(Icons.arrow_back_ios, size: 16.w,),
                      ),
                      if (leftTitle != null)
                        Text(
                          leftTitle!,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 14.w,
                              fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                    ],
                  )
                : SizedBox(
                    width: 42.w,
                  ),
            onTap: () {
              if (!hasLeft) return;
              if (onBackClick != null) {
                onBackClick!();
              } else {
                Navigator.pop(context);
              }
            },
          ),
          titleWidget ??
              Container(
                  width: 200.w,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 5.w),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
          if (leftTitle != null)
            Text(leftTitle!,
                style: TextStyle(
                  color: Colors.transparent,
                  fontSize: 14.w,
                )),
          (rightWidget != null || (rightIcon != null && rightIcon!.isNotEmpty))
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onRightClick,
                  child: rightWidget ??
                      Container(
                        alignment: Alignment.center,
                        width: 42.w,
                        height: 42.w,
                        child: Image.asset(rightIcon!),
                      ),
                )
              : SizedBox(
                  width: 42.w,
                )
        ],
      ),
    );
  }
}
