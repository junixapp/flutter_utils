import 'package:flutter/material.dart';

/// 点击封装
class OnClick extends StatelessWidget {
  final Widget child;
  final bool ripple;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  const OnClick(this.child, {super.key, this.onTap, this.ripple = false, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      // behavior: HitTestBehavior.opaque,
      onTap: onTap,
      canRequestFocus: onTap != null,
      mouseCursor: (onTap == null ? SystemMouseCursors.basic : SystemMouseCursors.click),
      onLongPress: onLongPress,
      splashColor: ripple ? null : Colors.transparent,
      highlightColor: ripple ? null : Colors.transparent,
      child: child,
    );
  }
}
