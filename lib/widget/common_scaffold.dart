import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

/// 点击封装，点击键盘外部的未消费事件区域，则让软键盘消失
class CommonScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final bool safeArea;

  const CommonScaffold({
    super.key,
    required this.body,
    this.resizeToAvoidBottomInset = false,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.safeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: safeArea ? SafeArea(child: body) : body,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: backgroundColor,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
