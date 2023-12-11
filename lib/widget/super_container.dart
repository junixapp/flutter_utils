import 'package:flutter/material.dart';
import 'package:fuck_utils/widget/on_click.dart';


class SuperContainer extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool disabled;
  final double radius;
  final BorderRadius? borderRadius;
  final Border? border;
  final double? width;
  final double? height;
  final Color color;
  final Color? foregroundColor;
  final Color borderColor;
  final double borderWidth;
  final double shadow;
  final BoxFit bgImgFit;
  final String? bgImgName;
  final BoxConstraints? constraints;
  final AlignmentGeometry align;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const SuperContainer(
      {super.key,
      this.child,
      this.onTap,
      this.onLongPress,
      this.radius = 0,
      this.padding,
      this.disabled = false,
      this.width,
      this.margin,
      this.height,
      this.color = Colors.transparent,
      this.align = Alignment.center,
      this.shadow = 0,
      this.borderColor = Colors.transparent,
      this.borderWidth = 0.0,
      this.bgImgFit = BoxFit.contain,
      this.bgImgName,
      this.borderRadius,
      this.border,
      this.constraints,
      this.foregroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      constraints: constraints,
      child: OnClick(
          Opacity(
            opacity: disabled ? 0.5 : 1,
            child: Stack(
              children: [
                _buildBackground(),
                if (foregroundColor != null) _buildForeground(),
              ],
            ),
          ),
          onTap: disabled ? null : onTap,
          onLongPress: onLongPress),
    );
  }

  Widget _buildBackground() {
    return Container(
      alignment: align,
      padding: padding,
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: _buildBoxDecoration(),
      child: child,
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: color,
      border: border ?? Border.all(color: borderColor, width: borderWidth),
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      image: bgImgName != null && bgImgName!.isNotEmpty
          ? DecorationImage(
              fit: bgImgFit,
              image: AssetImage(bgImgName!),
            )
          : null,
      boxShadow: [
        if (shadow > 0)
          BoxShadow(
            blurRadius: radius,
            spreadRadius: shadow,
            color: const Color(0x10000000),
          )
      ],
    );
  }

  Widget _buildForeground() {
    return Container(
      constraints: constraints,
      width: width,
      height: height,
      decoration: foregroundColor != null
          ? BoxDecoration(
              color: foregroundColor,
              border: border ??
                  Border.all(
                    color: borderColor,
                    width: borderWidth,
                  ),
              borderRadius: borderRadius ?? BorderRadius.circular(radius),
            )
          : null,
    );
  }
}