import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatelessWidget {
  final WebViewController controller;

  const WebviewScreen(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ScreenBody(controller),
    );
  }
}

class _ScreenBody extends StatelessWidget {
  final WebViewController controller;

  const _ScreenBody(this.controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
