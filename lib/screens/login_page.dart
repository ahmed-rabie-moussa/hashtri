import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hashtri/screens/register_page.dart';
import 'package:hashtri/widgets/custom_button.dart';
import 'package:hashtri/widgets/custom_input_field.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _formIsLoading = false;

  String _enteredEmail = "";
  String _enteredPassword = "";

  FocusNode _passwordFocusNode;

  //sign in with Account in firebase
  Future<String> _signInAccount() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _enteredEmail, password: _enteredPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return e.message;
    }
  }

  //this is an alert dialog to show if there is an error
  Future<void> _alertDialogBuilder(String errorMessage) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(errorMessage),
            ),
            actions: [
              FlatButton(
                child: Text("Close dialog"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void _submitForm() async {
    setState(() {
      _formIsLoading = true;
    });
    String signInAccountResult = await _signInAccount();
    if (signInAccountResult != null) {
      _alertDialogBuilder(signInAccountResult);
      setState(() {
        _formIsLoading = false;
      });
    }
  }

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  "Welcome User,\n Login to your account",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "UserName",
                    onChanged: (value) {
                      _enteredEmail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: "Password",
                    focusNode: _passwordFocusNode,
                    onChanged: (value) {
                      _enteredPassword = value;
                    },
                    onSubmitted: (value) {
                      _submitForm();
                    },
                    textInputAction: TextInputAction.done,
                    isPasswordField: true,
                  ),
                  CustomButton(
                    text: "Login",
                    onPressed: () {
                      _submitForm();
                    },
                    outlineBtn: false,
                    isloading: _formIsLoading,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: CustomButton(
                  text: "Create New Account",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  outlineBtn: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
