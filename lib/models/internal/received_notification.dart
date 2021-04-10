import 'package:flutter/material.dart';

class ReceivedNotification {
  int id;
  String title;
  String body;
  String payload;

  ReceivedNotification({
    this.id,
    @required this.title,
    @required this.body,
    this.payload = "new payload",
  });
}
