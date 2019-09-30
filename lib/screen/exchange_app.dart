import 'dart:convert' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_unit_converter/bloc/converter/bloc_converter.dart';
import 'package:my_unit_converter/bloc/converter/event_converter.dart';
import 'package:my_unit_converter/bloc/converter/model_conversion.dart';
import 'package:my_unit_converter/model_response/model_backdrop_response.dart';
import 'package:my_unit_converter/widget/backdrop.dart';
import 'package:my_unit_converter/widget/converter.dart';
import 'package:my_unit_converter/widget/list_converter.dart';

class ExchangeApp extends StatelessWidget {
  final List<ModelBackdropResponse> data;
  const ExchangeApp({@required this.data});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(fontFamily: 'Raleway'),
        home: BlocProvider<BlocConverter>(
          builder: (context) => BlocConverter(),
          child: $ExchangeApp(
            data: this.data,
          ),
        ));
  }
}

class $ExchangeApp extends StatefulWidget {
  final List<ModelBackdropResponse> data;
  const $ExchangeApp({@required this.data});

  @override
  _ExchangeAppState createState() => _ExchangeAppState();
}

class _ExchangeAppState extends State<$ExchangeApp> {
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
                backTitleColor: widget.data[_currentDataIndex].color,
                panelTitle: widget.data[_currentDataIndex].title,
                panelVisible: _panelVisible,
                backdrop: ListConverter(
                  data: widget.data,
                  defaultIndex: _currentDataIndex,
                  onItemTap: _onItemTap,
                ),
                panel: Converter(
                    units: _unit[widget.data[_currentDataIndex].title]),
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
    final defaultConversion = _unit[widget.data[index].title][0];
    blocConverter.dispatch(InitTypes(
        newInput: "",
        inputConversion: defaultConversion,
        outputConversion: defaultConversion));
  }
}
