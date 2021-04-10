import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagesGesture extends StatefulWidget {
  static const String routeName = "/ImagesGesture";
  final String urlImages;
  ImagesGesture({this.urlImages});
  @override
  _ImagesGestureState createState() => _ImagesGestureState();
}

class _ImagesGestureState extends State<ImagesGesture> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
      imageProvider: NetworkImage(widget.urlImages),
    ));
  }
}
