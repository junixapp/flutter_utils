import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 富文本构造类
/// RichTextHelper().appendText().appendWidget().build();
class RichTextUtil {
  List<InlineSpan> spans = [];

  RichTextUtil appendText(String text,
      {Color color = const Color(0xff222222),
        double size = 14,
        bool bold = false,
        VoidCallback? onTap}) {
    var span = TextSpan(
        text: text,
        style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: bold ? FontWeight.w600 : FontWeight.normal),
        recognizer: TapGestureRecognizer()..onTap = onTap);
    spans.add(span);
    return this;
  }

  RichTextUtil appendSpace(double size) {
    spans.add(WidgetSpan(child: SizedBox(width: size,)),);
    return this;
  }

  RichTextUtil appendLine({double? size}) {
    spans.add(
      WidgetSpan(
          child: Text(
            "\r\n",
            style: TextStyle(fontSize: size ?? 14.w),
          )),
    );
    return this;
  }

  RichTextUtil appendWidget(Widget child,
      {PlaceholderAlignment alignment = PlaceholderAlignment.middle}) {
    spans.add(
      WidgetSpan(
        alignment: alignment,
        child: child,
      ),
    );
    return this;
  }

  Widget build({TextAlign textAlign = TextAlign.left}) {
    return Text.rich(
      TextSpan(children: spans),
      softWrap: true,
      textAlign: textAlign,
    );
  }
}
