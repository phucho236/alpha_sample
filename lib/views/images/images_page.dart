import 'package:alpha_sample/views/images/images_gesture.dart';
import 'package:flutter/material.dart';

class ImagesPage extends StatefulWidget {
  static const String routeName = "/ImagesPage";
  @override
  _ImagesPageState createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  String urlImages =
      "https://media3.s-nbcnews.com/j/newscms/2019_41/3047866/191010-japan-stalker-mc-1121_06b4c20bbf96a51dc8663f334404a899.fit-760w.JPG";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: MaterialButton(
          onPressed: () {
            Navigator.pushNamed(context, ImagesGesture.routeName,
                arguments: urlImages);
          },
          child: Image.network(urlImages)),
    ));
  }
}
