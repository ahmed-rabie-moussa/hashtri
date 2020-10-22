import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;

  BottomTabs({this.selectedTab, this.tabPressed});

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 22)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomTabButton(
              imagePath: "assets/images/tab_home.png",
              isSelected: _selectedTab == 0 ? true : false,
              onPressed: () {
                setState(() {
                  widget.tabPressed(0);
                });
              },
            ),
            BottomTabButton(
              imagePath: "assets/images/tab_search.png",
              isSelected: _selectedTab == 1 ? true : false,
              onPressed: () {
                setState(() {
                  widget.tabPressed(1);
                });
              },
            ),
            BottomTabButton(
              imagePath: "assets/images/tab_saved.png",
              isSelected: _selectedTab == 2 ? true : false,
              onPressed: () {
                setState(() {
                  widget.tabPressed(2);
                });
              },
            ),
            BottomTabButton(
              imagePath: "assets/images/tab_logout.png",
              isSelected: _selectedTab == 3 ? true : false,
              onPressed: () {
                setState(() {
                  widget.tabPressed(3);
                });
              },
            )
          ],
        ));
  }
}

class BottomTabButton extends StatelessWidget {
  final String imagePath;
  final bool isSelected;
  final Function onPressed;

  BottomTabButton({this.imagePath, this.isSelected, this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _selected = isSelected ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: _selected
                        ? Theme.of(context).accentColor
                        : Colors.transparent,
                    width: 2))),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Image(
            width: 32,
            height: 32,
            image: AssetImage(imagePath),
            color: _selected ? Theme.of(context).accentColor : Colors.black,
          ),
        ),
      ),
    );
  }
}
