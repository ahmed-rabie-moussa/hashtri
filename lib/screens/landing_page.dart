import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hashtri/constants.dart';
import 'package:hashtri/screens/home_page.dart';
import 'package:hashtri/screens/login_page.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //Error in connection to firebase
        if (snapshot.hasError) {
          return Scaffold(
            body: Container(
              child: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            ),
          );
        }

        //Connection to database has done completely
        if (snapshot.connectionState == ConnectionState.done) {
          //the stream builder check that login state is alive
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              //if the stream snapshot has an error
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Container(
                    child: Center(
                      child: Text("Error: ${streamSnapshot.error}"),
                    ),
                  ),
                );
              }

              if (streamSnapshot.connectionState == ConnectionState.active) {
                User user = streamSnapshot.data;
                if (user == null) {
                  return LoginPage();
                } else
                  return HomePage();
              }

              // Checking the authentication state
              return Scaffold(
                body: Container(
                  child: Center(
                    child: Text("Checking authentication ..."),
                  ),
                ),
              );
            },
          );
        }

        // connectiong to firebase loading
        return Scaffold(
          body: Container(
            child: Center(
              child: Text("Initialization App ..."),
            ),
          ),
        );
      },
    );
  }
}
