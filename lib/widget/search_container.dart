
import 'package:flutter/material.dart';
import 'package:fuck_utils/fuck_utils.dart';

class SearchContainer extends StatefulWidget {
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? radius;
  final Color? bg;
  final Color? inputColor;
  final double? inputSize;
  final Color? hintColor;
  final double? hintSize;
  final String? hint;
  final bool? centerText;
  final Widget? clearIcon;
  final Widget? searchIcon;
  final int? maxLength;
  final ValueChanged<String>? onSubmit;

  const SearchContainer({super.key, this.margin, this.padding, this.bg, this.radius,
    this.inputColor, this.inputSize, this.hintSize, this.hintColor, this.hint,
    this.centerText, this.clearIcon, this.searchIcon, this.maxLength, this.onSubmit});

  @override
  State<SearchContainer> createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  TextEditingController controller = TextEditingController();
  var showClear = false.obs;
  @override
  void initState() {
    super.initState();
    controller.addListener(() { 
      showClear.value = controller.text.isNotEmpty;
    });
  }
  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SuperContainer(margin: widget.margin, padding: widget.padding, radius: widget.radius ?? 0,
    color: widget.bg ?? Colors.transparent, child: Row(children: [
      widget.searchIcon ?? Icon(Icons.search, color: widget.hintColor ?? Colors.grey,),
        const SizedBox(width: 10,),
        Expanded(child: WidgetUtil.textField(context, controller, widget.hint ?? '',
          fontSize: widget.inputSize ?? 16, hintFontSize: widget.hintSize ?? 16,
          fontColor: widget.inputColor, hintColor: widget.hintColor,
            textAlign: widget.centerText==true ? TextAlign.center : TextAlign.left,
          maxLength: widget.maxLength ?? 50, onSubmit: widget.onSubmit
        )),
        const SizedBox(width: 10,),
        Obx(() => showClear.value ? OnClick(widget.clearIcon ?? Icon(Icons.clear,
        color: widget.hintColor ?? Colors.grey,), onTap: ()=> controller.text = "",)
          : const SizedBox()),
      ],),);
  }
}
