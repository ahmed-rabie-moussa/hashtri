import 'package:flutter/material.dart';
import 'package:hashtri/constants.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;

  CustomActionBar(
      {this.hasBackArrow, this.title, this.hasTitle, this.hasBackground});

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;
    return Container(
      decoration: _hasBackground
          ? BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.white.withOpacity(0)],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1)))
          : null,
      padding: EdgeInsets.only(top: 56, bottom: 42, right: 24, left: 24),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        if (_hasBackArrow)
          Container(
            height: 42,
            width: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(8)),
            child: Image(
              image: AssetImage("assets/images/back_arrow.png"),
              color: Colors.white,
            ),
          ),
        Text(
          _hasTitle ? title ?? "title" : "",
          style: Constants.boldHeading,
        ),
        Container(
          height: 42,
          width: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(8)),
          child: Text(
            "0",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ]),
    );
  }
}
