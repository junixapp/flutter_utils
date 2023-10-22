import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum UIState { none, loading, success, error, empty }

/// 状态切换布局
class StatusLayout extends StatefulWidget {
  final UIState status;
  final Widget? loadingWidget, errorWidget, emptyWidget, contentWidget;
  final VoidCallback? onRetry;
  final double? width, height;

  const StatusLayout({
    super.key,
    this.status = UIState.loading,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
    this.contentWidget,
    this.width,
    this.height,
    this.onRetry,
  }) : assert(contentWidget != null);

  @override
  State<StatusLayout> createState() => _StatusLayoutState();
}

class _StatusLayoutState extends State<StatusLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      alignment: Alignment.center,
      child: buildChild(),
    );
  }

  Widget buildChild() {
    switch (widget.status) {
      case UIState.loading:
        return buildLoading();
      case UIState.error:
        return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.onRetry,
            child: buildError());
      case UIState.empty:
        return buildEmpty();
      case UIState.success:
        return widget.contentWidget ?? Container();
      case UIState.none:
        break;
    }
    return const SizedBox(
      width: 0,
      height: 0,
    );
  }

  Widget buildLoading() {
    return widget.loadingWidget != null
        ? widget.loadingWidget!
        : const Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget buildError() {
    return widget.errorWidget != null
        ? widget.errorWidget!
        : Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.error,
                  size: 42.w,
                  color: const Color(0XFF999999),
                ),
                SizedBox(height: 15.w),
                Text(
                  "加载失败，点击重试",
                  style: TextStyle(
                    color: const Color(0XFF999999),
                    fontSize: 14.w,
                  ),
                )
              ],
            ),
          );
  }

  Widget buildEmpty() {
    return widget.emptyWidget != null
        ? widget.emptyWidget!
        : Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "nodata".tr,
                  style: const TextStyle(
                    color: Color(0xFF9CA1B7),
                    fontSize: 12,
                  ),
                )
              ],
            ),
          );
  }
}
