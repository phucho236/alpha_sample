import 'dart:io';

import 'package:alpha_sample/utils/shared_pref_utils.dart';
import 'package:device_info/device_info.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const imageExtensions = ['png', 'jpg', 'gif'];

void fieldFocusChange(BuildContext context, FocusNode from, FocusNode to) {
  from.unfocus();
  FocusScope.of(context).requestFocus(to);
}

void showInfoError(BuildContext context, String message) {
  showFlushBar(context, message, Colors.red.shade500);
}

void showInfo(BuildContext context, String message) {
  showFlushBar(context, message, Colors.blue.shade500);
}

void showFlushBar(BuildContext context, String message, Color color) {
  Flushbar(
    message: message,
    icon: Icon(Icons.info_outline, size: 28, color: color),
    leftBarIndicatorColor: color,
    duration: Duration(seconds: 3),
  )..show(context);
}

Future<void> launchAction(String url) async {
  if (await canLaunch(url))
    await launch(url);
  else
    throw 'Could not launch $url';
}

void onWidgetDidBuild(Function callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    callback();
  });
}

Future handlingDevicesID() async {
  String devicesIdSharePres = await PrefUtils.getDevicesId();
  String devicesIdNow = await getDevicesId();
  if (devicesIdSharePres != devicesIdNow) {
    await PrefUtils.setDevicesId(value: devicesIdNow);
  }
}

Future<String> getDevicesId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    print(iosDeviceInfo.identifierForVendor);
    return iosDeviceInfo.identifierForVendor;
    // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    print(androidDeviceInfo.androidId);
    return androidDeviceInfo.androidId;
    // unique ID on Android
  }
}
