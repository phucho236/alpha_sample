import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:alpha_sample/utils/shared_pref_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
  }
  if (message.containsKey('notification')) {
    final dynamic notification = message['notification'];
  }
  return Future<void>.value();
}

class FcmNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {
    if (Platform.isIOS)
      _fcm.requestNotificationPermissions(IosNotificationSettings());

    _fcm.configure(
      /// Called when the app is in the foreground and we receive a push notification
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onBackgroundMessage:
          Platform.isAndroid ? myBackgroundMessageHandler : null,

      /// Called when the app has been closed completely and it's opened
      /// from the push notification.
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        _handleNotificationData(message);
      },

      /// Called when the app is in the background and it's opened
      /// from the push notification.
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _handleNotificationData(message);
      },
    );
  }

  Future<void> getFcmToken() async {
    await _fcm.getToken().then((value) async {
      if (value != null) await PrefUtils.setFcmToken(fcmToken: value);
      debugPrint('FCM Token - ${value.toString()}');
    });
  }

  void _handleNotificationData(Map<String, dynamic> message) {
    var notificationData = message['data'];
    log('- FCM data: ${json.encode(notificationData)}');
  }
}
