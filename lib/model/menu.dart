import 'package:flutter/material.dart';
import 'package:flutter_sample/utils/constants.dart';

enum Menu {
  home(Constants.home, '/', icon: Icons.home_outlined),
  login(Constants.login, "/login"),
  settings(Constants.settings, '/settings', icon: Icons.settings),
  eBizCard(Constants.eBizCard, '/eBizCard', icon: Icons.contact_phone_outlined),
  notice(Constants.notice, '/notice', icon: Icons.notifications_none),
  messenger(Constants.messenger, '/messenger', icon: Icons.message_outlined),
  search(Constants.search, '/search', icon: Icons.search),
  searchEmp(Constants.searchEmp, '/search/emp'),
  searchOrg(Constants.searchOrg, '/search/org'),
  docs(Constants.docs, '/docs', icon: Icons.file_present);

  final String menuNm;
  final String route;
  final IconData? icon;

  const Menu(this.menuNm, this.route, {this.icon});
}
