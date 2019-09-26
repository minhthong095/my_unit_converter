import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_unit_converter/widget/exchange_app/bloc/bloc_exchange_app.dart';
import 'package:my_unit_converter/widget/exchange_app/bloc/event_exchange_app.dart';
import 'package:my_unit_converter/widget/exchange_app/bloc/state_exchange_app.dart';
import 'package:my_unit_converter/widget/exchange_app/exchange_app.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => BlocExchangeApp(),
      child: $Splash(),
    );
  }
}

class $Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> tempBody = <String, dynamic>{
      "AParam": "AValue",
      "BParam": ["BValue1", "BValue2", "BValue3"]
    };
    final blocExchangeApp = BlocProvider.of<BlocExchangeApp>(context);
    blocExchangeApp.dispatch(Init(tempBodyForConversion: tempBody));

    return BlocListener<BlocExchangeApp, StateExchangeApp>(
      listener: (context, state) {
        // Default always will be Init on StateExchangeApp
        if (state.backdropResponse != null && state.conversionResponse != null)
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) => ExchangeApp()),
              (Route<dynamic> route) => false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: InkWell(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => ExchangeApp()),
                (Route<dynamic> route) => false);
          },
          child: Image.asset(
            'assets/icons/flutter.png',
            width: 150,
            height: 150,
          ),
        )),
      ),
    );
  }
}
