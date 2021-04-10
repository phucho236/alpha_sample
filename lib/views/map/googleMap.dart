import 'package:alpha_sample/utils/custom_google_map_widget/controllers/map_controller.dart';
import 'package:alpha_sample/utils/custom_google_map_widget/index.dart';
import 'package:alpha_sample/widgets/container/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  static const String routeName = "/MapPage";

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Location location;
  bool isListeningEvenBus = false;
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ASAppBar(showBack: true, title: 'Map'),
      body: Center(
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            CustomGoogleMapWidget(),
          ],
        ),
      ),
    );
  }
}
