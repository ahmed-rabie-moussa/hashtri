import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hashtri/widgets/custom_button.dart';
import 'package:hashtri/widgets/custom_input_field.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _formIsLoading = false;

  String _registerEmail = "";
  String _registerPassword = "";

  FocusNode _passwordFocusNode;

  //create a new Account from firebase
  Future<String> _createNewAccount() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
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
    String createAccountResult = await _createNewAccount();
    if (createAccountResult != null) {
      _alertDialogBuilder(createAccountResult);
      setState(() {
        _formIsLoading = false;
      });
    } else {
      setState(() {
        _formIsLoading = false;
      });
      Navigator.pop(context);
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
                  "Create Account,",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "UserName",
                    onChanged: (value) {
                      _registerEmail = value;
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
                      _registerPassword = value;
                    },
                    onSubmitted: (value) {
                      _submitForm();
                    },
                    textInputAction: TextInputAction.done,
                    isPasswordField: true,
                  ),
                  CustomButton(
                    text: "Create New Account",
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
                  text: "Back to Login",
                  onPressed: () {
                    Navigator.pop(context);
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
