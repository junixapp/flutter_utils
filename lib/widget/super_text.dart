import 'package:flutter/material.dart';

enum ChildPosition { left, top, right, bottom }

/// 可携带一个child的Text组件
class SuperText extends StatelessWidget {
  final ChildPosition childPosition;
  final Widget? child;
  final double childSpace;
  final String text;
  final TextStyle? style;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? bgColor;
  final AlignmentGeometry alignment;
  final BorderRadiusGeometry? borderRadius;
  final double? radius;
  final Gradient? gradient;
  final BoxBorder? border;
  final VoidCallback? onTap;
  final BoxConstraints? constraints;
  final bool hasInkWell;
  final bool spaceBetween;
  final double shadow;
  final Color borderColor;
  final double borderWidth;
  final bool disabled;
  final bool expand;

  const SuperText(this.text,
      {super.key,
      this.childPosition = ChildPosition.left,
      this.child,
      this.childSpace = 0,
      this.style,
      this.width,
      this.height,
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.all(0),
      this.bgColor,
      this.alignment = Alignment.center,
      this.borderRadius,
      this.gradient,
      this.border,
      this.onTap,
      this.hasInkWell = false,
      this.spaceBetween = false,
      this.shadow = 0,
      this.radius,
      this.constraints,
      this.borderColor = Colors.transparent,
      this.borderWidth = 0.0,
      this.disabled = false,
      this.expand = false});

  @override
  Widget build(BuildContext context) {
    return onTap == null
        ? buildContainer(
            (/*this.image == null ? buildChild() :*/ buildDirection()))
        : (hasInkWell
            ? InkWell(
                onTap: disabled ? null : onTap,
                child: buildContainer(
                    /*this.image == null ? buildChild() :*/ buildDirection()))
            : GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: disabled ? null : onTap,
                child: buildContainer(
                  /*this.image == null ? buildChild() :*/ buildDirection(),
                )));
  }

  Widget buildContainer(Widget child) {
    return Opacity(
      opacity: disabled ? 0.4 : 1,
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          expand ? Expanded(child: buildInner(child)) : buildInner(child)
        ],
      ),
    );
  }

  Widget buildInner(Widget child) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius:
              radius == null ? borderRadius : BorderRadius.circular(radius!),
          gradient: gradient,
          border: border ?? Border.all(color: borderColor, width: borderWidth),
          boxShadow: [
            if (shadow > 0)
              BoxShadow(
                  blurRadius: shadow / 2,
                  spreadRadius: shadow,
                  color: const Color(0x10000000))
          ]),
      child: child,
    );
  }

  MainAxisAlignment _fixAlign() {
    if (spaceBetween) return MainAxisAlignment.spaceBetween;
    if (alignment == Alignment.centerLeft) return MainAxisAlignment.start;
    if (alignment == Alignment.centerRight) return MainAxisAlignment.end;
    return MainAxisAlignment.center;
  }

  Widget buildDirection() {
    if (childPosition == ChildPosition.left ||
        childPosition == ChildPosition.right) {
      return Row(
          mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: _fixAlign(),
          children: buildChildren());
    }
    return Column(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: _fixAlign(),
      children: buildChildren(),
    );
  }

  // Widget buildChild() {
  //   return Text(text, style: style, );
  // }

  List<Widget> buildChildren() {
    if (childPosition == ChildPosition.left || childPosition == ChildPosition.top) {
      return <Widget>[
        if (child != null) ...<Widget>[
          child ?? const SizedBox(),
          buildSizeBox()
        ],
        Text(
          text,
          style: style,
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ];
    } else {
      return <Widget>[
        Text(text,
            style: style,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        if (child != null) ...<Widget>[
          buildSizeBox(),
          child ?? const SizedBox()
        ]
      ];
    }
  }

  Widget buildSizeBox() {
    if (childPosition == ChildPosition.left ||
        childPosition == ChildPosition.right) {
      return SizedBox(
        width: childSpace,
      );
    } else {
      return SizedBox(
        height: childSpace,
      );
    }
  }
}
