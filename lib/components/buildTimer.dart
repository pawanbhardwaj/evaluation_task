import 'package:flutter/material.dart';

Row buildTimer() {
  return Row(
    children: [
      Text("The OTP will be expired in ",
          style: TextStyle(color: Colors.black.withOpacity(0.7))),
      TweenAnimationBuilder(
        tween: Tween(begin: 60.0, end: 0.0),
        duration: Duration(seconds: 60),
        builder: (_, double value, child) => Text("00:${value.toInt()}",
            style: TextStyle(color: Colors.black.withOpacity(0.7))),
      ),
    ],
  );
}
