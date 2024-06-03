import 'package:flutter/material.dart';

// BottomNavigation 있는 화면
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key, required this.controller});

  final BottomNavigationController controller;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.controller.screens.length, vsync: this, initialIndex: 0);
  }

  Widget buildBody() {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: widget.controller.screens,
      ),
      bottomNavigationBar: Material(
        color: Colors.grey[50],
        child: TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          indicator: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 3.5, color: Colors.red),
            ),
          ),
          tabs: widget.controller.tabs,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.controller.screens.length,
      child: buildBody(),
    );
  }
}

class BottomNavigationController {
  List<Widget> screens;
  List<Widget> tabs;

  BottomNavigationController({required this.screens, required this.tabs});
}
