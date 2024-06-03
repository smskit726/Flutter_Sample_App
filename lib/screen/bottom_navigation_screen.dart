import 'package:flutter/material.dart';
import 'package:flutter_sample/screen/test_screen.dart';
import 'package:flutter_sample/widgets/bottom_navigation.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = List.generate(
      4,
      (index) => TestScreen(title: '화면 ${index + 1}'),
    );

    List<Widget> tabs = List.generate(
      4,
      (index) => Tab(
        icon: const Icon(
          Icons.account_circle_outlined,
        ),
        iconMargin: const EdgeInsets.only(bottom: 2),
        child: Text('메뉴 ${index + 1}'),
      ),
    );

    return BottomNavigation(
      controller: BottomNavigationController(screens: screens, tabs: tabs),
    );
  }
}
