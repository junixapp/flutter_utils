import 'package:flutter/material.dart';
import 'package:fuck_utils/fuck_utils.dart';

/// 状态切换布局
class StatusLayout extends StatefulWidget {
  final RxStatus? status;
  final Widget? loading, error, empty, success;
  final VoidCallback? onRetry;
  final double? width, height;
  final bool showLoadingOnce;
  final Color? loadingColor;
  final double? loadingSize;
  final Color? errorColor;
  final String? errorText;
  final Color? emptyColor;
  final String? emptyText;
  final Alignment? alignment;
  final BoxConstraints? constraints;

  const StatusLayout({
    super.key,
    this.status,
    this.loading,
    this.error,
    this.empty,
    this.success,
    this.width,
    this.height,
    this.onRetry,
    this.showLoadingOnce = false,
    this.loadingColor,
    this.loadingSize,
    this.errorColor,
    this.errorText,
    this.emptyColor,
    this.emptyText,
    this.alignment,
    this.constraints,
  }) : assert(success != null);

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
      constraints: widget.constraints,
      width: widget.width,
      height: widget.height,
      alignment: widget.alignment ?? Alignment.center,
      child: buildChild(),
    );
  }

  Widget buildChild() {
    if(widget.status==null) return const SizedBox();
    if(widget.status!.isLoading){
      if(hasLoading && widget.showLoadingOnce) return widget.success ?? const SizedBox();
      return buildLoading();
    }
    if(widget.status!.isError){
      return OnClick(buildError(), onTap: widget.onRetry,);
    }
    if(widget.status!.isEmpty){
      return buildEmpty();
    }
    if(widget.status!.isSuccess){
      return widget.success ?? const SizedBox();
    }
    return const SizedBox();
  }

  Widget buildLoading() {
    hasLoading = true;
    return widget.loading != null
        ? widget.loading!
        : SizedBox(
              width: widget.loadingSize ?? 20,
              height: widget.loadingSize ?? 20,
              child: CircularProgressIndicator(color: widget.loadingColor,),
            );
  }

  Widget buildError() {
    return widget.error != null
        ? widget.error!
        : Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.error,
                  size: 42,
                  color: widget.errorColor ?? const Color(0XFF999999),
                ),
                const SizedBox(height: 15),
                Text(widget.errorText ?? "加载失败，点击重试",
                  style: TextStyle(
                    color: widget.errorColor ?? const Color(0XFF999999),
                    fontSize: 16,
                  ),
                )
              ],
            ),
          );
  }

  Widget buildEmpty() {
    return widget.empty != null
        ? widget.empty!
        : Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(widget.emptyText ?? '暂无数据',
                  style: TextStyle(
                    color: widget.emptyColor ?? const Color(0xFF9CA1B7),
                    fontSize: 12,
                  ),
                )
              ],
            ),
          );
  }
}
