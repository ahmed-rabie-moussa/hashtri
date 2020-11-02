import 'package:flutter/material.dart';
import 'package:hashtri/screens/home_page.dart';
import 'package:hashtri/screens/landing_page.dart';
import './page_model.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatelessWidget {
  List<PageModel> pages = List<PageModel>();
  List<Widget> circles = List<Widget>();
  ValueNotifier<int> valueNotifier = ValueNotifier<int>(0);

  getSeen(BuildContext ctx) async {
    final preferences = await SharedPreferences.getInstance();
    bool seen =
        (preferences.containsKey('seen')) ? preferences.getBool('seen') : false;
    if (seen) {
      Navigator.push(ctx, MaterialPageRoute(builder: (context) {
        return LandingPage();
      }));
    } else
      return;
  }

  @override
  Widget build(BuildContext context) {
    getSeen(context);
    createPages();
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: PageView.builder(
            itemBuilder: (context, position) {
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage("assets/images/on_boarding.png"),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      child: Icon(
                        pages[position].icon,
                        color: Colors.white,
                        size: 140,
                      ),
                      offset: Offset(0, -40),
                    ),
                    Text(pages[position].title,
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 24)),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 24, right: 24, top: 16),
                      child: Text(
                        pages[position].description,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white60),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: pages.length,
            onPageChanged: (position) {
              valueNotifier.value = position;
            },
          ),
        ),
        Transform.translate(
          offset: Offset(0, 150),
          child: Container(
            alignment: Alignment.center,
            child: _displayPageViewIndicator(pages.length),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 24, right: 24),
              height: 36,
              child: RaisedButton(
                color: Colors.white,
                child: Text(
                  "GET STARTED",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('seen', true);
                  prefs.commit();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LandingPage();
                  }));
                },
              ),
            ),
          ),
        )
      ],
    ));
  }

  void createPages() {
    pages.add(PageModel(
        "Welcome",
        "Find your way through the products and shopping",
        Icons.all_inclusive));
    pages.add(PageModel("You'r Right",
        "By choosing this you are on the right road", Icons.done));
    pages.add(PageModel("Shopping", "You well find all what you need",
        Icons.add_shopping_cart));
  }

  Widget _displayPageViewIndicator(int length) {
    return PageViewIndicator(
      pageIndexNotifier: valueNotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.grey,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 12.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
