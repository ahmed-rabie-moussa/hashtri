import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List imageList;

  ImageSwipe(this.imageList);

  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: PageView(
          children: [
            for (int i = 0; i < widget.imageList.length; i++)
              Container(
                child: Image.network(
                  "${widget.imageList[i]}",
                  fit: BoxFit.fitHeight,
                ),
              )
          ],
        ));
  }
}
