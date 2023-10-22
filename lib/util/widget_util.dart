import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetUtil {
  WidgetUtil._();
  ///快捷创建输入框
  static Widget textField(
    BuildContext context,
    TextEditingController controller,
    String hint, {
    Color? hintColor,
    double? fontSize,
    TextInputType? inputType,
    int maxLength = 50,
    TextAlign? textAlign,
    FocusNode? focusNode,
    bool? obscureText,
    bool? disabled,
    List<TextInputFormatter>? inputFormatters,
    Key? key,
    TextStyle? hintStyle,
    TextStyle? style,
    int maxLines = 1,
  }) {
    return TextField(
      key: key, controller: controller, maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: inputType ?? TextInputType.text,
      enabled: !(disabled ?? false),
      textInputAction: TextInputAction.done,
      textAlignVertical: TextAlignVertical.center,
      textAlign: textAlign ?? TextAlign.left,
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        isCollapsed: true,
        counterText: "",
        hintText: hint,
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintStyle: hintStyle ??
            TextStyle(
              color: hintColor ?? Theme.of(context).hintColor,
              fontSize: fontSize ?? 14.w,
            ),
      ),
      style: style ??
          TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: fontSize ?? 14.w,
          ),
    );
  }

  static Widget popup<T>(
    BuildContext context,
    List<T> items,
    PopupMenuItemSelected<T> onSelect,
    Widget child, {
    double? offsetY,
    Widget? item,
    double? itemWidth,
  }) {
    return PopupMenuButton<T>(
      position: PopupMenuPosition.under,
      padding: EdgeInsets.zero,
      offset: Offset(0, offsetY ?? 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.w),
      ),
      color: Theme.of(context).canvasColor,
      onSelected: onSelect,
      constraints: BoxConstraints(
        minWidth: itemWidth ?? 100.w,
        maxWidth: itemWidth ?? 100.w,
      ),
      itemBuilder: (builder) => items
          .map(
            (e) => PopupMenuItem<T>(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              height: 36.w,
              value: e!,
              child: item ??
                  Container(
                    width: itemWidth ?? 100.w,
                    alignment: Alignment.center,
                    child: Text(
                      e.toString(),
                      style: TextStyle(fontSize: 13.w),
                    ),
                  ),
            ),
          )
          .toList(),
      child: child,
    );
  }

  static Widget customPopup<T>(
    BuildContext context,
    List<T> items,
    PopupMenuItemSelected<T> onSelect,
    Widget child,
    IndexedWidgetBuilder itemBuilder, {
    double? offsetY,
    double? height,
    double? itemWidth,
    EdgeInsets? padding,
  }) {
    return PopupMenuButton<T>(
      position: PopupMenuPosition.under,
      constraints: BoxConstraints(
        minWidth: itemWidth ?? 100.w,
        maxWidth: itemWidth ?? 100.w,
      ),
      padding: EdgeInsets.zero,
      offset: Offset(0, offsetY ?? 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.w),
      ),
      color: Theme.of(context).canvasColor,
      onSelected: onSelect,
      itemBuilder: (builder) => items
          .map(
            (e) => PopupMenuItem<T>(
              padding: const EdgeInsets.symmetric(vertical: 0),
              height: height ?? 36.w,
              value: e!,
              child: itemBuilder(context, items.indexOf(e)),
            ),
          )
          .toList(),
      child: child,
    );
  }

  static Text text(String text,{double? size, Color? color, bool bold = false, TextOverflow? overflow,
    TextAlign? align, int? maxLines, bool underline = false, bool lineThrough = false}) {
    return Text(text, style: TextStyle(color: color ?? Colors.black,
      fontSize: size ?? 14.w,
      fontWeight: bold ?FontWeight.w600: FontWeight.normal,
      decoration: underline ? TextDecoration.underline : (lineThrough? TextDecoration.lineThrough: TextDecoration.none),
    ), overflow: overflow, textAlign: align??TextAlign.left, maxLines: maxLines,);
  }

  static BorderRadius radius(double tl, double tr, double br, double bl) {
    return BorderRadius.only(
      topLeft: Radius.circular(tl),
      topRight: Radius.circular(tr),
      bottomLeft: Radius.circular(bl),
      bottomRight: Radius.circular(br),
    );
  }
}
