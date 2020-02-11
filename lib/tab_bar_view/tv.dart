import 'package:anything/ui/user_widget.dart';
import 'package:flutter/material.dart';

Widget tv(BuildContext context) {
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
      child: UserWidget(),
    ),
  );
}
