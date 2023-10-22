import 'package:flutter/material.dart';

/// 点击封装
class OnClick extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const OnClick(this.child, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: child,
    );
  }
}
