import 'package:flutter/material.dart';

class MyBorderStyle {
  static Border cuteBorder = Border.all(color: Colors.black, width: 2);

  static const BorderRadiusGeometry cuteRadius = BorderRadius.only(
    topLeft: Radius.circular(50),
  );
}
