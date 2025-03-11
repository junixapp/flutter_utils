import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class WidgetUtil {
  WidgetUtil._();

  static final TextInputFormatter numberFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
  static final TextInputFormatter passwordFormatter = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9!#\$_-]'));

  ///快捷创建输入框
  static Widget textField(BuildContext context, TextEditingController controller,
      String hint, { Color? fontColor, Color? hintColor, double? fontSize,double? hintFontSize, TextInputType? inputType,
        int maxLength = 100, TextAlign? textAlign, FocusNode? focusNode, bool? obscureText,
        bool? disabled, List<TextInputFormatter>? inputFormatters, Key? key,
        int? maxLines, double? borderWidth, Color? borderColor, double? radius, EdgeInsets? padding,
        bool bold = false, EdgeInsets? margin,  ValueChanged<String>? onSubmit,
        TextInputAction? inputAction, Color? bgColor,
        bool autofocus = false
      }){
    return Padding(padding: margin ?? EdgeInsets.zero, child: TextField(key: key, controller: controller,
      maxLines: obscureText==true ?  1:  maxLines,
      maxLength: maxLength,
      cursorColor: fontColor,
      inputFormatters: inputFormatters,
      keyboardType: (maxLines==null&&obscureText!=true) ? TextInputType.multiline : (inputType ?? TextInputType.text),
      enabled: !(disabled ?? false),
      autofocus: autofocus,
      textInputAction: inputAction ?? TextInputAction.done,
      textAlignVertical: TextAlignVertical.center,
      textAlign: textAlign??TextAlign.left,
      focusNode: focusNode,
      obscureText: obscureText??false,
      onSubmitted: (v)=> onSubmit?.call(v),
      decoration: InputDecoration(
          prefixIcon: null,
          suffixIcon: null,
          isCollapsed: true,
          counterText: "",
          filled: bgColor!=null,
          fillColor: bgColor,
          focusedBorder: (borderWidth!=null || borderColor!=null|| radius!=null) ?
          OutlineInputBorder(borderSide: BorderSide(width: borderWidth ?? 1, color: borderColor ?? Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(radius??0)) : InputBorder.none,
          contentPadding: padding ?? EdgeInsets.zero,
          disabledBorder: (borderWidth!=null || borderColor!=null|| radius!=null) ?
            OutlineInputBorder(borderSide: BorderSide(width: borderWidth ?? 1,
                color: borderColor ?? Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(radius??0)) : InputBorder.none,
          enabledBorder: (borderWidth!=null || borderColor!=null|| radius!=null) ?
            OutlineInputBorder(borderSide: BorderSide(width: borderWidth ?? 1,
              color: borderColor ?? Theme.of(context).dividerColor) ,
                borderRadius: BorderRadius.circular(radius??0), gapPadding: 0) : InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
              color: hintColor ?? Theme.of(context).colorScheme.tertiary, fontSize: hintFontSize??(fontSize??16),
              fontWeight: bold ? FontWeight.bold : FontWeight.normal
          )),
      style: TextStyle(color: fontColor ?? Theme.of(context).colorScheme.primary, fontSize: fontSize??16,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal),
    ),);
  }

  static Text text(String text,{double? size, Color? color, bool bold = false, TextOverflow? overflow,
    TextAlign? align, int? maxLines, bool underline = false, bool lineThrough = false}) {
    return Text(text, style: TextStyle(color: color ?? Colors.black,
      fontSize: size ?? 16,
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

  ///infinite_scroll_pagination
  static PagedChildBuilderDelegate<T> pagedDelegate<T>(
      PagingController pagingController, ItemWidgetBuilder<T> itemBuilder){
    return PagedChildBuilderDelegate<T>(
      animateTransitions: true,
      itemBuilder: itemBuilder,
      firstPageErrorIndicatorBuilder: (_) => Center(child: InkResponse(onTap: pagingController.retryLastFailedRequest,
        child: const Text("失败，点击重试",style: TextStyle(fontSize: 16),
        ),),),
      newPageErrorIndicatorBuilder: (_) => Center(child: InkResponse(onTap: pagingController.retryLastFailedRequest,
        child: const Text("失败，点击重试",style: TextStyle(fontSize: 16),
        ),),),
      firstPageProgressIndicatorBuilder: (_) => Container(alignment: Alignment.center,
        child: const SizedBox(width: 30, height: 30, child: CircularProgressIndicator(),),),
      newPageProgressIndicatorBuilder: (_) => Container(alignment: Alignment.center,
        child: const SizedBox(width: 30, height: 30, child: CircularProgressIndicator(),),),
      noItemsFoundIndicatorBuilder: (_) => Container(alignment: Alignment.center,
        child: Text("数据为空", style: TextStyle(color: Colors.black.withOpacity(0.5)),),),
      noMoreItemsIndicatorBuilder: (_) => Container(alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text("没有更多数据", style: TextStyle(color: Colors.black.withOpacity(0.5)),),),
    );
  }

}
