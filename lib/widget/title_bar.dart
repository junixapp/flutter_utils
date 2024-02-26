import 'package:flutter/material.dart';
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
      height: height ?? (46 +  MediaQuery.of(context).padding.top ),
      decoration:BoxDecoration(border: Border(bottom: BorderSide(color:
        hasDivider ? (Theme.of(context).dividerTheme.color??Theme.of(context).dividerColor) : Colors.transparent,
        width:  hasDivider ? 1 : 0),),
        color: bgColor),
      child: Stack(children: [
          OnClick(Container(alignment: Alignment.center,
            width: 42, height: 42,
            child: leftWidget ?? const Icon(Icons.arrow_back, size: 28,),
          ), onTap: () {
              if (onLeftClick != null) {
                onLeftClick!();
              } else {
                Navigator.pop(context);
              }
            },
          ),
          Align(alignment: leftTitle ? Alignment.centerLeft : Alignment.center,
            child: titleWidget ?? Container(width: 200, height: 42,
                alignment: leftTitle ? Alignment.centerLeft : Alignment.center,
              margin: EdgeInsets.only(right: 5, left: leftTitle ? 50 : 0),
              child: Text(title, style: TextStyle(
                  color: titleColor ?? Theme.of(context).colorScheme.primary,
                  fontSize: titleSize ?? 16,
                  fontWeight: boldTitle ? FontWeight.w600 : FontWeight.normal),
                maxLines: 1, overflow: TextOverflow.ellipsis,)),),
          Align(alignment: Alignment.centerRight, child: rightWidget ?? OnClick(Container(alignment: Alignment.center,
             width: 42, height: 42,
             child: (rightImage!=null ? Image.asset(rightImage??"") : const SizedBox())), onTap: onRightClick,))
        ],
      ),);
  }
}
