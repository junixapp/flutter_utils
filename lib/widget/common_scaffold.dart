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
  final Widget? titleBar;
  ///下面是titlebar的属性
  final VoidCallback? onBackClick;
  final VoidCallback? onRightClick;
  final bool hasDivider;
  final String? rightIcon;
  final String title;
  final Widget? titleWidget;
  final double? titleBarHeight;

  const CommonScaffold({
    super.key,
    required this.body,
    this.resizeToAvoidBottomInset = false,
    this.bgColor,
    this.bottomNavigationBar,
    this.safeArea = true,
    this.titleBar,
    this.onBackClick,
    this.onRightClick,
    this.hasDivider = true,
    this.title = "",
    this.titleWidget,
    this.rightIcon = "",
    this.titleBarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: safeArea ? SafeArea(child: _buildBody()) : _buildBody(),
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: bgColor,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }

  Widget _buildBody(){
    return Column(children: [
      const SizedBox(width: double.infinity,),
      titleBar ?? TitleBar(onBackClick: onBackClick, onRightClick: onRightClick,
        title: title, titleWidget: titleWidget, hasDivider: hasDivider,
        rightIcon: rightIcon, height: titleBarHeight,),
      Expanded(child: body)
    ],);
  }
}
