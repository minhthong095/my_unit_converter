import 'package:flutter/material.dart';
import 'package:my_unit_converter/backdrop/backdrop.dart';
import 'package:my_unit_converter/converter/converter.dart';
import 'package:my_unit_converter/converter/list-converter.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(fontFamily: 'Raleway'),
        home: SafeArea(
          child: Backdrop(),
        ));
  }
}
