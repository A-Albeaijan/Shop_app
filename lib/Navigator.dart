import 'package:flutter/material.dart';

void NavigatorPush(context, widget) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => widget(),
    ),
  );
}

void NavigatorpushReplacement(context, widget) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => widget(),
    ),
  );
}
