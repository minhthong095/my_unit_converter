import 'dart:convert' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_unit_converter/widget/backdrop/backdrop.dart';
import 'package:my_unit_converter/widget/converter/bloc/bloc_converter.dart';
import 'package:my_unit_converter/widget/converter/bloc/event_converter.dart';
import 'package:my_unit_converter/widget/converter/bloc/model_conversion.dart';
import 'package:my_unit_converter/widget/converter/converter.dart';
import 'package:my_unit_converter/widget/list_converter/list_converter.dart';

class ExchangeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(fontFamily: 'Raleway'),
        home: BlocProvider<BlocConverter>(
          builder: (context) => BlocConverter(),
          child: _ExchangeApp(),
        ));
  }
}

class _ExchangeApp extends StatefulWidget {
  @override
  _ExchangeAppState createState() => _ExchangeAppState();
}

class _ExchangeAppState extends State<_ExchangeApp> {
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
        title: 'Digital Storage',
        iconPath: 'assets/icons/digital_storage.png',
        color: Colors.indigo),
    DataItemConverter(
        title: 'Time', iconPath: 'assets/icons/time.png', color: Colors.lime),
    DataItemConverter(
        title: 'Volume',
        iconPath: 'assets/icons/volume.png',
        color: Colors.orange),
  ];

  bool _panelVisible = false;
  int _currentDataIndex = 0;
  Map<String, List<ModelConversion>> _unit;
  BlocConverter blocConverter;

  @override
  void initState() {
    blocConverter = BlocProvider.of<BlocConverter>(context);
    super.initState();
  }

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
            _initConverterState(0);
          }
          return Container(
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: Backdrop(
                backdropTitlePanelOn: 'Unit Converter',
                backdropTitlePanelOff: 'Select a Category',
                backTitleColor: _data[_currentDataIndex].color,
                panelTitle: _data[_currentDataIndex].title,
                panelVisible: _panelVisible,
                backdrop: ListConverter(
                  data: _data,
                  defaultIndex: _currentDataIndex,
                  onItemTap: _onItemTap,
                ),
                panel: Converter(units: _unit[_data[_currentDataIndex].title]),
              ),
            ),
          );
        }
        return Container(height: 0, width: 0);
      },
    );
  }

  void _onItemTap(int index) {
    _initConverterState(index);
    // Clicking Item will always trigger Panel visible.
    setState(() {
      _currentDataIndex = index;
      _panelVisible = true;
    });
  }

  void _initConverterState(int index) {
    final defaultConversion = _unit[_data[index].title][0];
    blocConverter.dispatch(InitTypes(
        newInput: "",
        inputConversion: defaultConversion,
        outputConversion: defaultConversion));
  }
}
