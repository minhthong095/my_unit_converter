import 'package:flutter/material.dart';
import 'package:my_unit_converter/backdrop/backdrop.dart';
import 'package:my_unit_converter/converter/converter.dart';
import 'package:my_unit_converter/converter/list-converter.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(fontFamily: 'Raleway'), home: ExchangeApp());
  }
}

class ExchangeApp extends StatefulWidget {
  @override
  _ExchangeAppState createState() => _ExchangeAppState();
}

class _ExchangeAppState extends State<ExchangeApp> {
  bool _panelVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Backdrop(
        panelTitle: 'Unit Converter',
        backdropTitle: 'Select a Category',
        panelVisible: _panelVisible,
        backdrop: ListConverter(
          onItemTap: _onItemTap,
        ),
        panel: Converter(),
      ),
    );
  }

  void _onItemTap() {
    // Clicking Item will always trigger Panel visible.
    setState(() {
      _panelVisible = true;
    });
  }
}
