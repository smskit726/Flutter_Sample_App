import 'package:flutter/material.dart';

abstract class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  void onStart() {}

  Widget buildBody(BuildContext ctx);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => onStart());

    return buildBody(context);
  }
}
