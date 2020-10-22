import 'package:flutter/material.dart';
import 'package:hashtri/widgets/custom_action_bar.dart';

class SavedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Center(
          child: Text("Saved Page   !"),
        ),
        CustomActionBar(
          title: "Saved Products",
        ),
      ]),
    );
  }
}
