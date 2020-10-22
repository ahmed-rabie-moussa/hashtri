import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hashtri/constants.dart';
import 'package:hashtri/screens/product_page.dart';
import 'package:hashtri/widgets/custom_action_bar.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productRefrence =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        FutureBuilder<QuerySnapshot>(
          future: _productRefrence.get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error : ${snapshot.error}"),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                  padding: EdgeInsets.only(top: 108, bottom: 12),
                  children: snapshot.data.docs.map((document) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ProductPage(document.id.toString());
                        }));
                      },
                      child: Container(
                        height: 300,
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: Stack(children: [
                          Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  document.get("images")[0],
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.all(24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    document.get("name"),
                                    style: Constants.regularHeading,
                                  ),
                                  Text(
                                    "\$${document.get("price")}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          )
                        ]),
                      ),
                    );
                  }).toList());
            }

            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
        CustomActionBar(
          title: "Home",
        ),
      ]),
    );
  }
}
