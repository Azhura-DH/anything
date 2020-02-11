import 'package:flutter/material.dart';
import 'package:anything/utils/set_notif.dart';

Widget notif(BuildContext context, notifDur, plugin) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        // stops: [0.0, 0.7],
        colors: [
          Colors.cyan,
          Color(0xFFffffff),
        ],
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MaterialButton(
            child: Text(
              'Overlay Notification !',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Colors.blueAccent[700],
            onPressed: () {
              checkOverNotif(context, notifDur);
            },
          ),
          SizedBox(height: 8.0),
          MaterialButton(
            child: Text('Flutter Local Notification !'),
            color: Colors.grey,
            onPressed: () => showLocalNotif(plugin),
          ),
          SizedBox(height: 8.0),
          MaterialButton(
            child: Text('Notification custom sound !'),
            color: Colors.orange,
            onPressed: () => showCustomNotif(plugin),
          ),
        ],
      ),
    ),
  );
}
