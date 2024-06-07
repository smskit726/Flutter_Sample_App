import 'package:flutter/material.dart';
import 'package:flutter_sample/model/menu.dart';
import 'package:flutter_sample/widgets/custom_tab.dart';

class BottomNavScaffold extends StatefulWidget {
  final List<Widget> screens;
  final List<CustomTab> tabs;
  final Color? bottomNavigationColor;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final Decoration indicator;
  final PreferredSizeWidget? Function(int currentIndex)? appBarBuilder;
  final Map<Menu, Widget?> drawerMap;

  const BottomNavScaffold({
    super.key,
    required this.screens,
    required this.tabs,
    this.bottomNavigationColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.indicator = const BoxDecoration(border: Border(top: BorderSide(width: 3.5, color: Colors.deepOrangeAccent))),
    this.appBarBuilder,
    this.drawerMap = const {},
  });

  @override
  State<BottomNavScaffold> createState() => _BottomNavScaffoldState();
}

class _BottomNavScaffoldState extends State<BottomNavScaffold> with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.screens.length, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      if (_tabController.index != _currentIndex) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.screens.length,
      child: Scaffold(
        appBar: widget.appBarBuilder != null ? widget.appBarBuilder!(_currentIndex) : null,
        body: TabBarView(
          controller: _tabController,
          children: widget.screens,
        ),
        bottomNavigationBar: Material(
          color: widget.bottomNavigationColor,
          child: TabBar(
            controller: _tabController,
            labelStyle: widget.labelStyle,
            unselectedLabelStyle: widget.unselectedLabelStyle,
            indicator: widget.indicator,
            tabs: widget.tabs,
          ),
        ),
        drawer: widget.drawerMap[widget.tabs[_currentIndex].menu],
      ),
    );
  }
}
