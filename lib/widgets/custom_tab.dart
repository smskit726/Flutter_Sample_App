import 'package:flutter/material.dart';
import 'package:flutter_sample/model/menu.dart';

class CustomTab extends StatelessWidget {
  final Menu menu;
  final EdgeInsets iconMargin;

  const CustomTab(
    this.menu, {
    super.key,
    this.iconMargin = const EdgeInsets.only(bottom: 2),
  });

  @override
  Widget build(BuildContext context) {
    return Tab(icon: Icon(menu.icon), iconMargin: iconMargin, child: Text(menu.menuNm));
  }
}
