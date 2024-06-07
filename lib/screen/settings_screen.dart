import 'package:flutter/material.dart';
import 'package:flutter_sample/base/base_screen.dart';
import 'package:flutter_sample/utils/constants.dart';

class SettingsScreen extends BaseScreen {
  const SettingsScreen({super.key});

  @override
  Widget buildBody(BuildContext ctx) {
    return const Scaffold(
      body: Center(
        child: Text(Constants.settings),
      ),
    );
  }
}
