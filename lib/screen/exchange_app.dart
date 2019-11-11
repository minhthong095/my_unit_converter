import 'dart:async';
import 'dart:convert' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_unit_converter/bloc/change_category/bloc_change_category.dart';
import 'package:my_unit_converter/bloc/change_category/state_change_category.dart';
import 'package:my_unit_converter/bloc/converter/bloc_converter.dart';
import 'package:my_unit_converter/bloc/converter/event_converter.dart';
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
    final defaultDetailCategory = Lodash.find(units, (model) {
      return model.name == data[defaultIndex].title;
    });
    final blocConverter =
        BlocConverter(defaultDetailCategory: defaultDetailCategory);
    return new MaterialApp(
        theme: ThemeData(fontFamily: 'Raleway'),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<BlocConverter>(builder: (context) => blocConverter),
            BlocProvider<BlocChangeCategory>(
                builder: (context) => BlocChangeCategory(
                    data: data,
                    defaultIndex: defaultIndex,
                    units: units,
                    defaultDetailCategory: defaultDetailCategory))
          ],
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
  BlocConverter blocConverter;

  @override
  void initState() {
    blocConverter = BlocProvider.of<BlocConverter>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: BlocListener<BlocChangeCategory, StateChangeCategory>(
          listener: (context, state) {
            blocConverter.dispatch(ForceUpdateAll(
                newInput: "",
                outputConversion: state.detailCategory.conversions[0],
                inputConversion: state.detailCategory.conversions[0]));
          },
          child: BlocBuilder<BlocChangeCategory, StateChangeCategory>(
            builder: (context, state) {
              // print("BUILD BACKDROP " + state.toString());
              return InheritedHidePanelCallback(
                child: Backdrop(
                  backdropTitlePanelOn: 'Unit Converter',
                  backdropTitlePanelOff: 'Select a Category',
                  backTitleColor: state.category.color,
                  panelTitle: state.category.title,
                  backdrop: ListConverter(
                    data: widget.data,
                    cateogry: state.category,
                  ),
                  panel: Converter(units: state.detailCategory.conversions),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// class BackdropState extends StatefulWidget {
//   final Widget child;

//   BackdropState({@required this.child});

//   @override
//   _StateBackdropState createState() => _StateBackdropState();
// }

// class _StateBackdropState extends State<BackdropState> {

//   @override
//   void dispose() {
//     print("_StateBackdropState dispose");
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) => InheritedHidePanelCallback(
//         state: this,
//         child: widget.child,
//       );
// }

// class InheritedHidePanelCallback extends InheritedWidget {
//   _StateBackdropState backdropState;

//   InheritedHidePanelCallback(
//       {@required _StateBackdropState state, @required child})
//       : super(child: child);

//   @override
//   bool updateShouldNotify(InheritedWidget oldWidget) => true;
// }

class InheritedHidePanelCallback extends InheritedWidget {
  VoidCallback hidePanelCallback;

  InheritedHidePanelCallback({@required child}) : super(child: child);

  static InheritedHidePanelCallback of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(InheritedHidePanelCallback)
        as InheritedHidePanelCallback);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
