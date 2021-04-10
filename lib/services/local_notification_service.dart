import 'package:alpha_sample/models/internal/received_notification.dart';
import 'package:alpha_sample/views/sample/builder/sample_builder_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

class LocalNotificationService {
  int localNotificationID = 12385;

  Future initialise() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification');
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {
          didReceiveLocalNotificationSubject.add(ReceivedNotification(
              id: id, title: title, body: body, payload: payload));
        });
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      selectNotificationSubject.add(payload);
    });
  }

  Future<void> configureDidReceiveLocalNotificationSubject(
      BuildContext context) async {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification notification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: notification.title != null ? Text(notification.title) : null,
          content: notification.body != null ? Text(notification.body) : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Action"),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.pushNamed(context, SampleBuilderPage.routeName);
              },
            )
          ],
        ),
      );
    });
  }

  Future<void> configureSelectNotificationSubject() async {
    selectNotificationSubject.stream.listen((String payload) async {
      if (payload != null) debugPrint('Local Notification payload: $payload');
    });
  }

  Future<void> triggerLocalNotification(
      ReceivedNotification notification) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'local notification',
      'alpha sample local notification',
      'trigger local notification',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(localNotificationID++,
        notification.title, notification.body, platformChannelSpecifics,
        payload: notification.payload);
  }

  Future<void> scheduleLocalNotification(
      ReceivedNotification notification, int seconds) async {
    notification.id = localNotificationID++;
    var dateTime = DateTime.now().add(Duration(seconds: seconds));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'local notification',
      'alpha sample local notification',
      'trigger local notification',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      notification.id,
      notification.title,
      notification.body,
      dateTime,
      platformChannelSpecifics,
      payload: notification.payload,
    );
  }

  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
  }
}
