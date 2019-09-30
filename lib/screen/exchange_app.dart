import 'dart:convert' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_unit_converter/bloc/change_category/bloc_change_category.dart';
import 'package:my_unit_converter/bloc/converter/bloc_converter.dart';
import 'package:my_unit_converter/model_response/model_backdrop_response.dart';
import 'package:my_unit_converter/model_response/model_conversion_response.dart';
import 'package:my_unit_converter/tool/lodash.dart';
import 'package:my_unit_converter/widget/backdrop.dart';
import 'package:my_unit_converter/widget/converter.dart';
import 'package:my_unit_converter/widget/list_converter.dart';

class ExchangeApp extends StatelessWidget {
  final List<ModelBackdropResponse> data;
  final List<ModelConversionResponse> units;
  const ExchangeApp({@required this.data, @required this.units});
  final int defaultIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(fontFamily: 'Raleway'),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<BlocConverter>(
                builder: (context) => BlocConverter(
                    defaultConverter: this.units[defaultIndex].conversions[0])),
            BlocProvider<BlocChangeCategory>(
                builder: (context) =>
                    BlocChangeCategory(defaultIndex: defaultIndex))
          ],
          child: $ExchangeApp(
            data: this.data,
            units: this.units,
          ),
        ));
  }
}

class $ExchangeApp extends StatefulWidget {
  final List<ModelBackdropResponse> data;
  final List<ModelConversionResponse> units;
  const $ExchangeApp({@required this.data, @required this.units});

  @override
  _ExchangeAppState createState() => _ExchangeAppState();
}

class _ExchangeAppState extends State<$ExchangeApp> {
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
        return Container(
          color: Colors.white,
          child: SafeArea(
            top: false,
            child: BlocBuilder<BlocChangeCategory, int>(
              builder: (context, index) {
                print("BUILD BACKDROP");
                return Backdrop(
                  backdropTitlePanelOn: 'Unit Converter',
                  backdropTitlePanelOff: 'Select a Category',
                  backTitleColor: widget.data[index].color,
                  panelTitle: widget.data[index].title,
                  panelVisible: false,
                  backdrop: ListConverter(
                    data: widget.data,
                    defaultIndex: index,
                  ),
                  panel:
                      Converter(units: _getConversionIndex(index).conversions),
                );
              },
            ),
          ),
        );
      },
    );
  }

  ModelConversionResponse _getConversionIndex(int index) {
    final b = Lodash.find(widget.units, (model) {
      return model.name == widget.data[index].title;
    });
    return Lodash.find(widget.units, (model) {
      return model.name == widget.data[index].title;
    });
  }
}