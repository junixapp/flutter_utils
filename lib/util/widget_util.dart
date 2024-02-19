import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WidgetUtil {
  WidgetUtil._();
  ///快捷创建输入框
  static Widget textField(BuildContext context, TextEditingController controller,
      String hint, { Color? fontColor, Color? hintColor, double? fontSize,double? hintFontSize, TextInputType? inputType,
        int maxLength = 100, TextAlign? textAlign, FocusNode? focusNode, bool? obscureText,
        bool? disabled, List<TextInputFormatter>? inputFormatters, Key? key,
        int? maxLines, String? errorText, Color? errorColor, double? errorFontSize,
        double? borderWidth, Color? borderColor, double? radius, EdgeInsets? padding,
        bool bold = false, EdgeInsets? margin,  ValueChanged<String>? onSubmit,
        TextInputAction? inputAction, Color? bgColor, Widget? prefix, Widget? suffix,
        bool autofocus = false
      }){
    return Padding(padding: margin??EdgeInsets.zero, child: TextField(key: key, controller: controller,
      maxLines: obscureText==true ?  1:  maxLines,
      maxLength: maxLength,
      keyboardType: (maxLines==null&&obscureText==false) ? TextInputType.multiline : (inputType ?? TextInputType.text),
      enabled: !(disabled ?? false),
      autofocus: autofocus,
      textInputAction: inputAction ?? TextInputAction.done,
      textAlignVertical: TextAlignVertical.center,
      textAlign: textAlign??TextAlign.left,
      focusNode: focusNode,
      obscureText: obscureText??false,
      onSubmitted: (v)=> onSubmit?.call(v),
      decoration: InputDecoration(
          prefixIcon: prefix,
          suffixIcon: suffix,
          isCollapsed: true,
          counterText: "",
          filled: bgColor!=null,
          fillColor: bgColor,
          focusedBorder: (borderWidth!=null || borderColor!=null|| radius!=null) ?
          OutlineInputBorder(borderSide: BorderSide(width: borderWidth??1, color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(radius??0)) : InputBorder.none,
          hintText: hint,
          errorText: errorText!=null && errorText.isNotEmpty ? errorText : null,
          errorStyle: TextStyle(color: errorColor, fontSize: errorFontSize),
          contentPadding: padding ?? EdgeInsets.zero,
          enabledBorder: (borderWidth!=null || borderColor!=null|| radius!=null) ?
            OutlineInputBorder(borderSide: BorderSide(width: borderWidth??1,
              color: borderColor ?? Theme.of(context).dividerColor) ,
                borderRadius: BorderRadius.circular(radius??0), gapPadding: 0) : InputBorder.none,
          hintStyle: TextStyle(
              color: hintColor ?? Theme.of(context).colorScheme.tertiary, fontSize: hintFontSize??(fontSize??14),
              fontWeight: bold ? FontWeight.bold : FontWeight.normal
          )),
      style: TextStyle(color: fontColor ?? Theme.of(context).colorScheme.primary, fontSize: fontSize??14,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal),
    ),);
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
        borderRadius: BorderRadius.circular(5),
      ),
      color: Theme.of(context).canvasColor,
      onSelected: onSelect,
      constraints: BoxConstraints(
        minWidth: itemWidth ?? 100,
        maxWidth: itemWidth ?? 100,
      ),
      itemBuilder: (builder) => items
          .map((e) => PopupMenuItem<T>(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              height: 36,
              value: e!,
              child: item ?? Container(
                    width: itemWidth ?? 100,
                    alignment: Alignment.center,
                    child: Text(e.toString(),
                      style: TextStyle(fontSize: 13),
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
        minWidth: itemWidth ?? 100,
        maxWidth: itemWidth ?? 100,
      ),
      padding: EdgeInsets.zero,
      offset: Offset(0, offsetY ?? 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: Theme.of(context).canvasColor,
      onSelected: onSelect,
      itemBuilder: (builder) => items
          .map((e) => PopupMenuItem<T>(
              padding: const EdgeInsets.symmetric(vertical: 0),
              height: height ?? 36,
              value: e!,
              child: itemBuilder(context, items.indexOf(e)),
            ),).toList(),
      child: child,
    );
  }

  static Text text(String text,{double? size, Color? color, bool bold = false, TextOverflow? overflow,
    TextAlign? align, int? maxLines, bool underline = false, bool lineThrough = false}) {
    return Text(text, style: TextStyle(color: color ?? Colors.black,
      fontSize: size ?? 14,
      fontWeight: bold ?FontWeight.w600: FontWeight.normal,
      decoration: underline ? TextDecoration.underline : (lineThrough? TextDecoration.lineThrough: TextDecoration.none),
    ), overflow: overflow, textAlign: align??TextAlign.left, maxLines: maxLines,);
  }

  static BorderRadius radius({double? tl, double? tr, double? br, double? bl}) {
    return BorderRadius.only(
      topLeft: Radius.circular(tl??0),
      topRight: Radius.circular(tr??0),
      bottomLeft: Radius.circular(bl??0),
      bottomRight: Radius.circular(br??0),
    );
  }
}
