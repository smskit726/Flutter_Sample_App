import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key, required this.title});
  final String title;

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Text(widget.title),
      ),
    );
  }
}
