import 'package:flutter/material.dart';
import 'package:fuck_utils/fuck_utils.dart';
import 'package:get/get.dart';

/// 状态切换布局
class StatusLayout extends StatefulWidget {
  final RxStatus? status;
  final Widget? loadingWidget, errorWidget, emptyWidget, contentWidget;
  final VoidCallback? onRetry;
  final double? width, height;
  final bool showLoadingOnce;

  const StatusLayout({
    super.key,
    this.status,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
    this.contentWidget,
    this.width,
    this.height,
    this.onRetry,
    this.showLoadingOnce = false
  }) : assert(contentWidget != null);

  @override
  State<StatusLayout> createState() => _StatusLayoutState();
}

class _StatusLayoutState extends State<StatusLayout> {
  bool hasLoading = false;

  @override
  void initState() {
    super.initState();
  }

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
    if(widget.status==null) return const SizedBox();
    if(widget.status!.isLoading){
      if(hasLoading && widget.showLoadingOnce) return buildChild();
      return buildLoading();
    }
    if(widget.status!.isError){
      return OnClick(buildError(), onTap: widget.onRetry,);
    }
    if(widget.status!.isEmpty){
      return buildEmpty();
    }
    if(widget.status!.isSuccess){
      return widget.contentWidget ?? const SizedBox();
    }
    return const SizedBox();
  }

  Widget buildLoading() {
    hasLoading = true;
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
                  size: 42,
                  color: const Color(0XFF999999),
                ),
                SizedBox(height: 15),
                Text(
                  "加载失败，点击重试",
                  style: TextStyle(
                    color: const Color(0XFF999999),
                    fontSize: 16,
                  ),
                )
              ],
            ),
          );
  }

  Widget buildEmpty() {
    return widget.emptyWidget != null
        ? widget.emptyWidget!
        : const Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('暂无数据',
                  style: TextStyle(
                    color: Color(0xFF9CA1B7),
                    fontSize: 12,
                  ),
                )
              ],
            ),
          );
  }
}
