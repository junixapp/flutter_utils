import 'dart:math';

import 'package:flutter/material.dart';

///资源帮助类
class AssetUtil {
  AssetUtil._();


  static String imageRoot = "asset/images/";

  static void init(String imagePath){
    imageRoot = imagePath.endsWith("/") ? imagePath : "$imagePath/";
  }

  ///拼接图片路径
  static String imagePath(String imageName) => imageRoot + imageName;

  static AssetImage raw(String imageName) => AssetImage(imagePath(imageName));

  ///传入图片名字获取图片Widget,注意不需要带路径
  static Widget image(String? imageName,
      {double? width,
      double? height,
      double? size,
      BoxFit fit = BoxFit.contain,
      bool excludeFromSemantics = false,
      bool gaplessPlayback = false,
      Color? imageColor,
      bool primary = false,
      BuildContext? context}) {
    if (imageName == null || imageName.isEmpty) {
      return SizedBox(width: width, height: height,);
    }
    try {
      var image = Image.asset(imagePath(imageName), width: width ?? size,
        height: height ?? size, fit: fit, excludeFromSemantics: excludeFromSemantics,
        gaplessPlayback: gaplessPlayback, errorBuilder: (context, object, trace) {
          return SizedBox(width: width, height: height,);
        },
      );
      return imageColor != null || (primary && context != null)
          ? ColorFiltered(colorFilter: ColorFilter.mode(
                  primary ? Theme.of(context!).colorScheme.primary : imageColor!, BlendMode.srcIn), child: image,
            ) : image;
    } catch (e) {
      return SizedBox(width: width, height: height,);
    }
  }
  //
  static Widget tapImage(String? imageName, VoidCallback onTap,
      {double? width, double? height, double? size, BoxFit fit = BoxFit.contain,
      bool excludeFromSemantics = false, double? paddingH = 0, double? paddingV = 0,
      bool gaplessPlayback = false, Color? imageColor, bool primary = false, BuildContext? context,
        bool disabled = false,}) {
    var maxValue = max(max(width ?? 0, height ?? 0), size ?? 0);
    if (imageName == null || imageName.isEmpty) {
      return SizedBox(width: maxValue, height: maxValue,);
    }
    var imageWidget = Container(
      padding: EdgeInsets.symmetric(
          horizontal: paddingH ?? 0, vertical: paddingV ?? 0),
      child: image(imageName, width: width ?? maxValue, height: height ?? maxValue,
        fit: fit, excludeFromSemantics: excludeFromSemantics, gaplessPlayback: gaplessPlayback,),
    );
    return GestureDetector(behavior: HitTestBehavior.translucent,
      onTap: disabled ? null : onTap, child: Opacity(opacity: disabled?0.5:1,
      child: imageColor != null || (primary && context != null)
          ? ColorFiltered(colorFilter: ColorFilter.mode(
          primary ? Theme.of(context!).colorScheme.primary : imageColor!, BlendMode.srcIn),
        child: imageWidget,) : imageWidget,),
    );
  }
}
