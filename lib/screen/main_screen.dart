import 'package:flutter/material.dart';
import 'package:flutter_sample/base/base_screen.dart';
import 'package:flutter_sample/model/menu.dart';
import 'package:flutter_sample/screen/messenger_screen.dart';
import 'package:flutter_sample/screen/notice_screen.dart';
import 'package:flutter_sample/widgets/bottom_nav_scaffold.dart';
import 'package:flutter_sample/widgets/custom_drawer.dart';
import 'package:flutter_sample/widgets/custom_tab.dart';

import 'home_screen.dart';

class MainScreen extends BaseScreen {
  const MainScreen({super.key});

  @override
  Widget buildBody(BuildContext ctx) {
    return _ScreenBody();
  }
}

class _ScreenBody extends BaseScreen {
  List<Widget> _createScreens() {
    return const [
      HomeScreen(),
      MessengerScreen(),
      NoticeScreen(),
    ];
  }

  List<CustomTab> _createTabs() {
    return const [
      CustomTab(Menu.home),
      CustomTab(Menu.messenger),
      CustomTab(Menu.notice),
    ];
  }

  Map<Menu, Widget> _createDrawerMap() {
    return {
      Menu.home: const CustomDrawer([Menu.notice, Menu.search, Menu.eBizCard])
    };
  }

  PreferredSizeWidget _buildAppBar(int currentIndex) {
    return AppBar(
      leading: _hasDrawer(currentIndex)
          ? Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                  highlightColor: Colors.transparent,
                );
              },
            )
          : null,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
      ],
    );
  }

  bool _hasDrawer(int index) {
    return _createDrawerMap().containsKey(_createTabs()[index].menu);
  }

  @override
  Widget buildBody(BuildContext ctx) {
    return BottomNavScaffold(
      appBarBuilder: (currentIndex) => _buildAppBar(currentIndex),
      drawerMap: _createDrawerMap(),
      screens: _createScreens(),
      tabs: _createTabs(),
      labelStyle: const TextStyle(color: Colors.deepOrangeAccent),
    );
  }
}
