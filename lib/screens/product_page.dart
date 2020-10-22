import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hashtri/constants.dart';
import 'package:hashtri/widgets/custom_action_bar.dart';
import 'package:hashtri/widgets/image_swipe.dart';

class ProductPage extends StatefulWidget {
  final String product_id;

  ProductPage(this.product_id);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final CollectionReference _productRefrence =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        FutureBuilder(
          future: _productRefrence.doc(widget.product_id).get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error : ${snapshot.error}"),
                ),
              );
            }
            //data returned
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> documentData = snapshot.data.data();
              List imageList = documentData["images"];

              return ListView(
                children: [
                  ImageSwipe(imageList),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 24, bottom: 4, left: 24, right: 24),
                      child: Text(
                        "${documentData["name"]}",
                        style: Constants.boldHeading,
                      )),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                      child: Text(
                        "\$${documentData["price"]}",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                    child: Text(
                      "\$${documentData["description"]}",
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade800),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                    child: Text(
                      "Select size",
                      style: Constants.regularDarkText,
                    ),
                  )
                ],
              );
            }

            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
        CustomActionBar(
          hasBackArrow: true,
          hasTitle: false,
          hasBackground: false,
        )
      ]),
    );
  }
}
