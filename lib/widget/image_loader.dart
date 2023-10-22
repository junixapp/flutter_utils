import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fuck_utils/widget/super_container.dart';

/// 图片加载
class ImageLoader extends StatelessWidget {
  final String uri;
  final double? width;
  final double? height;
  final double radius;
  final BorderRadius? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final bool circle;
  final Color? bgColor;
  final Color? foregroundColor;
  final BoxFit fit;
  final VoidCallback? onTap;
  final Widget? placeholder;
  final EdgeInsets? padding;
  final bool blur;
  final bool animated;

  const ImageLoader(
    this.uri, {
    super.key,
    this.width,
    this.height,
    this.radius = 0,
    this.circle = false,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.bgColor,
    this.foregroundColor,
    this.borderWidth,
    this.borderColor,
    this.onTap,
    this.placeholder,
    this.padding,
    this.blur = false,
    this.animated = false,
  });

  @override
  Widget build(BuildContext context) {
    return SuperContainer(
        width: width,
        height: height,
        borderRadius: borderRadius ??
            BorderRadius.circular(circle ? (width ?? 0) / 2 : radius),
        borderWidth: borderWidth ?? 0,
        borderColor: borderColor ?? Colors.transparent,
        color: bgColor ?? Colors.transparent,
        onTap: onTap,
        padding: padding,
        foregroundColor: foregroundColor,
        child: Stack(
          children: [
            Center(child: placeholder),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: buildImage(),
            )
          ],
        ));
  }

  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(circle ? (width ?? 0) / 2 : radius),
      child: uri.isEmpty
          ? const SizedBox()
          : ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              enabled: blur,
              child: uri.startsWith("http")
                  ? CachedNetworkImage(
                      width: width,
                      height: height,
                      imageUrl: uri,
                      fit: fit,
                      fadeOutDuration:
                          Duration(milliseconds: animated ? 300 : 0),
                      fadeInDuration:
                          Duration(milliseconds: animated ? 300 : 0),
                      placeholder: (context, url) => Container(
                        color: bgColor,
                        alignment: Alignment.center,
                        child: placeholder,
                      ),
                      errorWidget: (context, url, _) => Container(
                        color: bgColor,
                        alignment: Alignment.center,
                        child: placeholder,
                      ),
                    )
                  : Image.asset(uri, fit: fit,),
            ),
    );
  }
}
