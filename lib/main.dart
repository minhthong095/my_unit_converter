import 'dart:convert' as prefix0;

import 'package:flutter/material.dart';
import 'package:my_unit_converter/backdrop/backdrop.dart';
import 'package:my_unit_converter/converter/bloc/model-conversion.dart';
import 'package:my_unit_converter/converter/converter.dart';
import 'package:my_unit_converter/list-converter/list-converter.dart';

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

  final _data = <DataItemConverter>[
    DataItemConverter(
        title: 'Area', iconPath: 'assets/icons/area.png', color: Colors.blue),
    DataItemConverter(
        title: 'Length',
        iconPath: 'assets/icons/length.png',
        color: Colors.greenAccent),
    DataItemConverter(
        title: 'Mass', iconPath: 'assets/icons/mass.png', color: Colors.green),
    DataItemConverter(
        title: 'Power',
        iconPath: 'assets/icons/power.png',
        color: Colors.indigo),
    DataItemConverter(
        title: 'Time', iconPath: 'assets/icons/time.png', color: Colors.lime),
    DataItemConverter(
        title: 'Volume',
        iconPath: 'assets/icons/volume.png',
        color: Colors.orange),
  ];

  int _currentDataIndex = 0;
  Map<String, List<ModelConversion>> _unit;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/converter/regular_units.json'),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (_unit == null) {
            _unit = (prefix0.JsonDecoder().convert(snapshot.data) as Map)
                .map((k, b) {
              final List<ModelConversion> listConversion = List.from((b as List)
                  .map((conversion) => ModelConversion(
                      conversion["name"],
                      conversion["conversion"],
                      conversion["base_unit"] == null ? false : true)));
              return MapEntry(k, listConversion);
            });
          }
          return SafeArea(
            child: Backdrop(
              panelTitle: 'Unit Converter',
              backdropTitle: 'Select a Category',
              backTitleColor: _data[_currentDataIndex].color,
              panelVisible: _panelVisible,
              backdrop: ListConverter(
                data: _data,
                defaultIndex: _currentDataIndex,
                onItemTap: _onItemTap,
              ),
              panel: Converter(unit: _unit[_data[_currentDataIndex].title]),
            ),
          );
        }
        return Container(height: 0, width: 0);
      },
    );
  }

  void _onItemTap(int index) {
    // Clicking Item will always trigger Panel visible.
    setState(() {
      _currentDataIndex = index;
      _panelVisible = true;
    });
  }
}
