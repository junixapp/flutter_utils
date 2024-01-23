import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


/// 索引栏
class IndexBar extends StatefulWidget {
  final List<String>? index;
  final Function(String)? onIndexClick;
  const IndexBar({this.onIndexClick,this.index, Key? key}) : super(key: key);

  @override
  State<IndexBar> createState() => _IndexBarState();
}

class _IndexBarState extends State<IndexBar> with AfterLayoutMixin<IndexBar> {
  List<String> list = [
    "1",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  var _selectorIndex = -1;
  var cellHeight = 1.0;
  @override
  void initState() {
    super.initState();
    if(widget.index!=null) list = widget.index!;
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    if (context.size != null) {
      cellHeight = context.size!.height / list.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.w,
      child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: list
                .map(
                  (e) => Text(
                    e,
                    style: TextStyle(
                        color: _selectorIndex >= 0 && list[_selectorIndex] == e
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).colorScheme.primary,
                        fontSize: 12.w),
                  ),
                )
                .toList(),
          ),
          onVerticalDragDown: (DragDownDetails details) {
            //垂直方向 touchesBegin:
            //details.localPosition  获取当前context的坐标
            int index = _getIndex(context, details.localPosition);
            if (index > list.length) return;
            if (index != _selectorIndex) {
              setState(() {
                _selectorIndex = index;
                if (widget.onIndexClick != null) {
                  widget.onIndexClick!(list[index]);
                }
              });
            }
          },
          onVerticalDragUpdate: (DragUpdateDetails details) {
            int index = _getIndex(context, details.localPosition);
            if (index > list.length) return;
            if (index != _selectorIndex) {
              setState(() {
                _selectorIndex = index;
                if (widget.onIndexClick != null) {
                  widget.onIndexClick!(list[index]);
                }
              });
            }
          },
          onVerticalDragEnd: (DragEndDetails details) {
            setState(() {
              _selectorIndex = -1;
            });
          }),
    );
  }

  int _getIndex(BuildContext context, Offset localPosition) {
    int index = localPosition.dy ~/ cellHeight;
    return index;
  }
}
