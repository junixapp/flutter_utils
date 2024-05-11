import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fuck_utils/fuck_utils.dart';

class WebViewPage extends StatefulWidget {
  final String? title;
  final String? url;
  const WebViewPage({Key? key, this.title, this.url}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  var title = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: widget.title ?? title,
      body: WebView(
        widget.url ?? "",
        onGetTitle: (t) {
          if(!mounted || !StringUtil.isEmpty(widget.title)) return;
          setState(() {
            title = t ?? "";
          });
        },
      ),
    );
  }
}
