import 'dart:convert' as prefix0;

import 'package:flutter/material.dart';
import 'package:my_unit_converter/widget/splash/splash.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
    );
  }
}
