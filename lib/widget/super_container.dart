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
  final double? opacity;
  final Color? color;
  final Color? foregroundColor;
  final Color borderColor;
  final double borderWidth;
  final double shadow;
  final double shadowRadius;
  final Color shadowColor;
  final BoxFit bgImgFit;
  final String? bgImgName;
  final BoxConstraints? constraints;
  final AlignmentGeometry? align;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Gradient? gradient;

  const SuperContainer(
      {super.key,
        this.child,
        this.onTap,
        this.onLongPress,
        this.radius = 0,
        this.padding,
        this.disabled = false,
        this.opacity,
        this.width,
        this.margin,
        this.height,
        this.color,
        this.align,
        this.shadow = 0,
        this.shadowColor = const Color(0x10000000),
        this.shadowRadius = 0,
        this.borderColor = Colors.transparent,
        this.borderWidth = 0.0,
        this.bgImgFit = BoxFit.contain,
        this.bgImgName,
        this.borderRadius,
        this.border,
        this.constraints,
        this.gradient,
        this.foregroundColor});

  @override
  Widget build(BuildContext context) {
    return OnClick(
        Opacity(
          opacity: opacity ?? (disabled ? 0.5 : 1),
          child: _buildChild(),
        ),
        onTap: disabled ? null : onTap,
        onLongPress: onLongPress);
  }

  Widget _buildChild() {
    return Container(
      alignment: align,
      padding: padding,
      constraints: constraints,
      width: width,
      height: height,
      margin: margin,
      clipBehavior: Clip.antiAlias,
      decoration: _buildBoxDecoration(),
      foregroundDecoration: BoxDecoration(
        color: foregroundColor,
        border: border ?? Border.all(color: borderColor, width: borderWidth),
        borderRadius: borderRadius ?? BorderRadius.circular(radius),
      ),
      child: child,
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: color,
      gradient: gradient,
      // border: border ?? Border.all(color: borderColor, width: borderWidth),
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
            blurRadius: shadowRadius,
            spreadRadius: shadow,
            color: shadowColor,
          )
      ],
    );
  }
}