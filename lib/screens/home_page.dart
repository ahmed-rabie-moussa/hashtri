import 'package:flutter/material.dart';
import 'package:hashtri/tabs/home_tab.dart';
import 'package:hashtri/tabs/saved_tab.dart';
import 'package:hashtri/tabs/search_tab.dart';
import 'package:hashtri/widgets/custom_bottom_tabs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Expanded(
            child: PageView(
              controller: _tabsPageController,
              onPageChanged: (pageNum) {
                setState(() {
                  _selectedTab = pageNum;
                });
              },
              children: [
                HomeTab(),
                SearchTab(),
                SavedTab(),
              ],
            ),
          ),
        ),
        Container(
          child: Center(
            child: BottomTabs(
              selectedTab: _selectedTab,
              tabPressed: (tabPressed) {
                setState(() {
                  _tabsPageController.animateToPage(tabPressed,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInCubic);
                });
              },
            ),
          ),
        )
      ],
    ));
  }
}
