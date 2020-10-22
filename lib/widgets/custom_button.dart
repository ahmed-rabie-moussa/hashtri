import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hashtri/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isloading;

  CustomButton({this.text, this.onPressed, this.outlineBtn, this.isloading});

  @override
  Widget build(BuildContext context) {
    //default values
    bool _outLineBtn = outlineBtn ?? false;
    bool _isLoading = isloading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: _outLineBtn ? Colors.transparent : Colors.black,
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Stack(
          children: [
            Visibility(
              visible: !_isLoading,
              child: Center(
                child: Text(
                  text ?? "text",
                  style: TextStyle(
                      color: _outLineBtn ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
