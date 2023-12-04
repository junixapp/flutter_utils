import 'package:flutter/material.dart';
import 'package:fuck_utils/fuck_utils.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

/// 常用Scaffold，点击键盘外部的未消费事件区域，则让软键盘消失
class CommonScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final Color? bgColor;
  final bool safeArea;
  final bool paddingStatusBar;
  final Widget? titleBar;
  ///下面是titlebar的属性
  final VoidCallback? onLeftClick;
  final VoidCallback? onRightClick;
  final bool leftTitle;
  final bool boldTitle;
  final bool hasDivider;
  final String? rightImage;
  final String title;
  final double? titleSize;
  final Color? titleColor;
  final Color? titleBarBg;
  final Widget? titleWidget;
  final double? titleBarHeight;
  final Widget? rightWidget;
  final Widget? leftWidget;

  const CommonScaffold({
    super.key,
    required this.body,
    this.resizeToAvoidBottomInset = false,
    this.bgColor,
    this.bottomNavigationBar,
    this.safeArea = true,
    this.titleBar,
    this.onLeftClick,
    this.onRightClick,
    this.paddingStatusBar = false,
    this.leftTitle = false,
    this.boldTitle = false,
    this.hasDivider = true,
    this.title = "",
    this.titleSize,
    this.titleColor,
    this.titleBarBg,
    this.titleWidget,
    this.titleBarHeight,
    this.rightImage,
    this.leftWidget,
    this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: safeArea ? SafeArea(top: !paddingStatusBar, child: _buildBody()) : _buildBody(),
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: bgColor,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }

  Widget _buildBody(){
    return Column(children: [
      const SizedBox(width: double.infinity,),
      titleBar ?? TitleBar(onLeftClick: onLeftClick, onRightClick: onRightClick,
        title: title, titleWidget: titleWidget, hasDivider: hasDivider,
        rightImage: rightImage, height: titleBarHeight, leftTitle: leftTitle,
          titleSize: titleSize, titleColor: titleColor, leftWidget: leftWidget,
          rightWidget: rightWidget, bgColor: titleBarBg, boldTitle: boldTitle),
      Expanded(child: body)
    ],);
  }
}
