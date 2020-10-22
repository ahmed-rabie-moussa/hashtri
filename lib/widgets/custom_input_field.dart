import 'package:flutter/material.dart';
import 'package:hashtri/constants.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField;

  CustomInput(
      {this.hintText,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.isPasswordField});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Color(0xfff2f2f2)),
      child: TextField(
        textInputAction: textInputAction,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        obscureText: isPasswordField ?? false,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? "Press to type here.",
            contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 24)),
        style: Constants.regularDarkText,
      ),
    );
  }
}
