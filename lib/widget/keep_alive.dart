
import 'package:flutter/widgets.dart';

class KeepAlive extends StatefulWidget {
  final Widget child;
  const KeepAlive(this.child, {super.key});

  @override
  State<KeepAlive> createState() => _KeepAliveState();
}

class _KeepAliveState extends State<KeepAlive> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
