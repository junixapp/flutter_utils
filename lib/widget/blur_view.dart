
import 'dart:ui';
import 'package:flutter/material.dart';

class BlurView extends StatelessWidget {
  final Widget child;
  final Color? color;
  const BlurView(this.child, {this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: color ?? Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
