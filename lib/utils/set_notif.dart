import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future allowNotif(BuildContext context) async {
  await dissmisNotif(context);
}

dissmisNotif(context) {
  OverlaySupportEntry.of(context).dismiss();
}

showLocalNotif(plugin) async {
  var android = AndroidNotificationDetails(
    'channelId',
    'channelName',
    'channelDescription',
    priority: Priority.High,
    importance: Importance.Max,
  );

  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android, iOS);
  await plugin.show(
    0,
    'Test Local Notification',
    'Testing flutter local notification',
    platform,
    payload: 'Notification succeed !',
  );
}

showCustomNotif(plugin) async {
  var android = AndroidNotificationDetails(
    'channelId',
    'channelName',
    'channelDescription',
    sound: 'slow_spring_board',
    priority: Priority.High,
    importance: Importance.Max,
  );

  var iOS = IOSNotificationDetails(sound: 'slow_spring_board');
  var platform = NotificationDetails(android, iOS);
  await plugin.show(
    0,
    'Test Local Notification',
    'Testing flutter local notification',
    platform,
    payload: 'Custom_Sound',
  );
}

checkOverNotif(BuildContext context, notifDur) {
  showOverlayNotification(
    (context) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: SafeArea(
          child: ListTile(
            leading: SizedBox.fromSize(
              size: const Size(40, 40),
              child: ClipOval(
                child: Container(
                  child: Icon(Icons.access_alarm),
                ),
              ),
            ),
            title: Text('Overlay Notification'),
            subtitle: Text('Testing overlay notification...'),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                dissmisNotif(context);
              },
            ),
          ),
        ),
      );
    },
    duration: Duration(seconds: notifDur),
  );
}