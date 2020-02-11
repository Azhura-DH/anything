import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'tab_bar_view/home.dart';
import 'tab_bar_view/notif.dart';
import 'tab_bar_view/settings.dart';
import 'tab_bar_view/tv.dart';

void main() => runApp(MyApp());

const app = 'Anything';
const int notifDur = 3;
bool notifPoint = true;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: app,
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('app_icon');
    var ios = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotif);
  }

  Future _onSelectNotif(String payload) async {
    debugPrint('payload: $payload');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Notification'),
        content: Text('$payload'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(app),
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              // text: 'Home',
            ),
            Tab(
              icon: Icon(Icons.live_tv),
              // text: 'TV',
            ),
            Tab(
              icon: Icon(Icons.notifications),
              // text: 'Notify',
            ),
            Tab(
              icon: Icon(Icons.settings),
              // text: 'Settings',
            ),
          ],
          labelColor: Colors.cyan,
          unselectedLabelColor: Color(0x5F00bcd4),
          indicatorColor: Colors.cyan,
          indicatorWeight: 3.0,
        ),
        body: TabBarView(
          children: <Widget>[
            home(),
            tv(context),
            notif(context, notifDur, flutterLocalNotificationsPlugin),
            settings(),
          ],
        ),
      ),
    );
  }
}
