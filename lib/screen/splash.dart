import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_unit_converter/bloc/alert_failed/bloc_alert_failed.dart';
import 'package:my_unit_converter/bloc/alert_failed/state_alert_failed.dart';
import 'package:my_unit_converter/bloc/converter/state_converter.dart';
import 'package:my_unit_converter/bloc/exchange_app/bloc_exchange_app.dart';
import 'package:my_unit_converter/bloc/exchange_app/event_exchange_app.dart';
import 'package:my_unit_converter/bloc/exchange_app/state_exchange_app.dart';
import 'package:my_unit_converter/model/model_convert.dart';
import 'package:my_unit_converter/page_transition/transition_bot_top.dart';
import 'package:my_unit_converter/widget/alert_failed.dart';

import 'exchange_app.dart';

class Splash extends StatefulWidget {
  @override
  _ProviderSplash createState() => _ProviderSplash();
}

class _ProviderSplash extends State<Splash> {
  BlocAlertFailed _blocAlertFailed;

  @override
  void initState() {
    _blocAlertFailed = BlocAlertFailed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocAlertFailed>(builder: (context) => _blocAlertFailed),
        BlocProvider<BlocExchangeApp>(
            builder: (context) => BlocExchangeApp(_blocAlertFailed)),
      ],
      child: _$Splash(),
    );
  }
}

class _$Splash extends StatefulWidget {
  @override
  _StateSplash createState() => _StateSplash();
}

class _StateSplash extends State<_$Splash> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Tween _opacityAnimation;
  BlocExchangeApp _blocExchangeApp;
  final Map<String, dynamic> _tempBody = <String, dynamic>{
    "AParam": "AValue",
    "BParam": ["BValue1", "BValue2", "BValue3"]
  };
  AnimationStatusListener _listener;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _opacityAnimation = Tween(begin: 0.5, end: 1);
    _listener = ((status) {
      if (status == AnimationStatus.completed)
        _controller.reverse();
      else if (status == AnimationStatus.dismissed) _controller.forward();
    });
    _controller.addStatusListener(_listener);
    _controller.forward();

    _blocExchangeApp = BlocProvider.of<BlocExchangeApp>(context);
    _fetchData();

    super.initState();
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  void _stopLoadingAnimation() {
    _controller.removeStatusListener(_listener);
    _controller.animateTo(1);
  }

  void _startLoadingAnimation() {
    _controller.addStatusListener(_listener);
    _controller.reverse();
    _fetchData();
  }

  void _fetchData() {
    _blocExchangeApp.dispatch(Init(tempBodyForConversion: _tempBody));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocAlertFailed, StateAlertFailed>(
      listener: (context, state) {
        if (state is OnAlertFailed) {
          _stopLoadingAnimation();
        }
      },
      child: BlocListener<BlocExchangeApp, StateExchangeApp>(
        listener: (context, state) {
          print("IMPACT");
          if (state is InitData)
            Navigator.of(context).pushAndRemoveUntil(
                TransitionBotTop(
                    child: ExchangeApp(
                  units: state.conversionResponse,
                  data: state.backdropResponse,
                )),
                (Route<dynamic> route) => false);
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: AlertFailed(
                partner: Center(
                  child: InkWell(
                      onTap: () {
                        _startLoadingAnimation();
                      },
                      child: AnimatedBuilder(
                        animation: _opacityAnimation.animate(_controller),
                        builder: (context, child) {
                          return Opacity(
                              opacity: _controller.value,
                              child: Image.asset(
                                'assets/icons/flutter.png',
                                width: 130,
                                height: 130,
                              ));
                        },
                      )),
                ),
              ),
            )),
      ),
    );
  }
}
