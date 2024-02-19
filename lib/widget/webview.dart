import 'package:flutter/material.dart';
import 'package:fuck_utils/util/object_util.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  final String url;
  final String? jsChannel;
  final Function(JavaScriptMessage)? onMessageReceived;
  final Function(String?)? onGetTitle;
  final Future<NavigationDecision> Function(NavigationRequest?)? onNavigation;
  const WebView(this.url,
      {Key? key,
      this.jsChannel,
      this.onMessageReceived,
      this.onGetTitle,
      this.onNavigation})
      : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final WebViewController _controller;
  var prog = 0.obs;
  var loadingPage = false.obs;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            prog.value = progress;
          },
          onPageStarted: (String url) {
            loadingPage.value = true;
          },
          onPageFinished: (String url) async {
            loadingPage.value = false;
            if (widget.onGetTitle != null) {
              var title = await _controller.getTitle();
              widget.onGetTitle!(title);
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            return (widget.onNavigation != null)
                ? await widget.onNavigation!(request)
                : NavigationDecision.navigate;
          },
        ),
      );
    if (ObjectUtil.isNotEmpty(widget.jsChannel) &&
        widget.onMessageReceived != null) {
      _controller.addJavaScriptChannel(widget.jsChannel!,
          onMessageReceived: widget.onMessageReceived!);
    }
    _controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    _controller.setBackgroundColor(Theme.of(context).scaffoldBackgroundColor);
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        Obx(() => loadingPage.value
            ? LinearProgressIndicator(
                value: prog.value / 100,
                color: Theme.of(context).primaryColor,
                minHeight: 2,
              )
            : const SizedBox()),
      ],
    );
  }
}
