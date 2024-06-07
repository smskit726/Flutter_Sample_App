import 'package:flutter/material.dart';
import 'package:flutter_sample/model/menu.dart';

class CustomDrawer extends StatelessWidget {
  final List<Menu> menus;

  const CustomDrawer(this.menus, {super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [for (Menu menu in menus) _MenuBox(menu)],
      ),
    );
  }
}

class _MenuBox extends StatelessWidget {
  final Menu menu;

  const _MenuBox(this.menu);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Container(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: <Widget>[Icon(menu.icon), const SizedBox(width: 10), Text(menu.menuNm)],
      ),
    ));
  }
}
