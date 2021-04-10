import 'dart:async';

import 'package:alpha_sample/utils/custom_google_map_widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMapWidget extends StatefulWidget {
  @override
  _CustomGoogleMapWidgetState createState() => _CustomGoogleMapWidgetState();
}

const double CAMERA_ZOOM = 16;
const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889);
const LatLng DEST_LOCATION = LatLng(10.833160, 106.663213);

class _CustomGoogleMapWidgetState extends State<CustomGoogleMapWidget> {
  StreamSubscription<LocationData> locationSubscription;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();
  String googleAPIKey = 'AIzaSyBHwSceZWVDO_3B9WyycSlWKJ3adYeHI48';
  PolylinePoints polylinePoints;

  ///For my customer Marker pins
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  ///Google Map Variable
  LocationData _currentLocation;
  Location location;
  bool isListenLocationChanged = false;
  bool isClock = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      setSourceAndDestinationIcons();
      _onConfigGoogleMap();
    } catch (e) {
      debugPrint('error : ${e}');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onDeactiveListenLocationChanged();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      target: SOURCE_LOCATION,
    );

    return GoogleMap(
      myLocationEnabled: true,
      compassEnabled: true,
      tiltGesturesEnabled: false,
      markers: _markers,
      polylines: _polylines,
      mapType: MapType.normal,
      initialCameraPosition: initialCameraPosition,
      onTap: (LatLng loc) {},
      onMapCreated: (GoogleMapController controller) {
        controller.setMapStyle(GoogleMapStyle.mapStyles);
        _controller.complete(controller);
      },
    );
  }

  _onShowMarkerOnMap(
      {LatLng latLng, BitmapDescriptor pinMarker, String markerId}) {
    _markers.removeWhere((m) => m.markerId.value == markerId);
    _markers.add(Marker(
      markerId: MarkerId(markerId),
      position: latLng,
      icon: pinMarker,
    ));
  }

  _onUpdateCameraPosition({LatLng locationData}) async {
    print('_markers: $locationData');
    double sLat, sLng, nLat, nLng;
    final GoogleMapController controller = await _controller.future;
    if (locationData == null) {
      for (int i = 0; i < _markers.length; i++) {
        var markerPosition = _markers.elementAt(i).position;
        if (sLat == null || markerPosition.latitude <= sLat) {
          sLat = markerPosition.latitude;
        }
        if (nLat == null || markerPosition.latitude >= nLat) {
          nLat = markerPosition.latitude;
        }
        if (sLng == null || markerPosition.longitude <= sLng) {
          sLng = markerPosition.longitude;
        }
        if (nLng == null || markerPosition.longitude >= nLng) {
          nLng = markerPosition.longitude;
        }
      }
      LatLngBounds bounds = LatLngBounds(
          northeast: LatLng(nLat, nLng), southwest: LatLng(sLat, sLng));

      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
    } else {
      CameraPosition cPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        target: LatLng(locationData.latitude, locationData.longitude),
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    }
  }

  void _onCreateDirection({@required LatLng thisLocation}) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(_currentLocation.latitude, _currentLocation.longitude),
        PointLatLng(thisLocation.latitude, thisLocation.longitude));

    _markers.removeWhere((m) => m.markerId.value == 'thisLocationMaker');
    _onShowMarkerOnMap(
        latLng: thisLocation,
        pinMarker: destinationIcon,
        markerId: 'thisLocationMaker');

    Set<Polyline> polylines = Set<Polyline>();

    if (result != null) {
      List<LatLng> polylineCoordinates = [];
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      polylines.add(Polyline(
          width: 2, // set the width of the polylines
          polylineId: PolylineId("poly"),
          color: Colors.black,
          points: polylineCoordinates));

      setState(() {
        _polylines = polylines;
      });
    }
    _onUpdateCameraPosition();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/driving_pin.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
  }

  void updatePinOnMap(LocationData driverCurrentPosition) async {
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      target: LatLng(
          driverCurrentPosition.latitude, driverCurrentPosition.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    setState(() {
      var pinPosition = LatLng(
          driverCurrentPosition.latitude, driverCurrentPosition.longitude);

      _markers.removeWhere((m) => m.markerId.value == 'currentLocationMaker');
      _markers.add(Marker(
        markerId: MarkerId('currentLocationMaker'),
        position: pinPosition,
        icon: sourceIcon,
      ));
    });
  }

  _onActiveListenLocationChanged() {
    if (locationSubscription == null) {
      location.changeSettings(interval: 60000);
      locationSubscription =
          location.onLocationChanged.listen((LocationData cLoc) {
        if (isListenLocationChanged == true) {
          print('currentLocation: $cLoc');
        }
      });
    }
  }

  _onDeactiveListenLocationChanged() {
    if (locationSubscription != null) {
      locationSubscription.cancel();
    }
  }

  Future<void> _onConfigGoogleMap() async {
    location = new Location();
    polylinePoints = PolylinePoints();

    _onActiveListenLocationChanged();

    LocationData currentLocation = await location.getLocation();
    print('currentLocation: $currentLocation');
    if (currentLocation != null) {
      LatLng currentLatLng =
          LatLng(currentLocation.latitude, currentLocation.longitude);

      _onShowMarkerOnMap(
          latLng: currentLatLng,
          pinMarker: sourceIcon,
          markerId: 'currentLocationMaker');
      _onUpdateCameraPosition(locationData: currentLatLng);
      setState(() {
        _currentLocation = currentLocation;
      });
    }
  }

  void _onClearMapData() {
    print('==== onClearMapData');
    Set<Polyline> polylines = Set<Polyline>();
    _markers.removeWhere((m) => m.markerId.value == 'destinationLocationMaker');
    setState(() {
      _polylines = polylines;
    });
  }
}
