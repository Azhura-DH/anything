import 'package:flutter/material.dart';

Widget settings() {
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
      child: Text('Settings'),
    ),
  );
}
