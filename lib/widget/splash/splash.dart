import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_unit_converter/networking/requesting.dart';
import 'package:my_unit_converter/page_transition/transition_bot_top.dart';
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

class $Splash extends StatefulWidget {
  @override
  _$SplashState createState() => _$SplashState();
}

class _$SplashState extends State<$Splash> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Tween _opacityAnimation;
  BlocExchangeApp _blocExchangeApp;
  final Map<String, dynamic> _tempBody = <String, dynamic>{
    "AParam": "AValue",
    "BParam": ["BValue1", "BValue2", "BValue3"]
  };

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _opacityAnimation = Tween(begin: 0.5, end: 1);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        _controller.reverse();
      else if (status == AnimationStatus.dismissed) _controller.forward();
    });
    _controller.forward();

    _blocExchangeApp = BlocProvider.of<BlocExchangeApp>(context);
    _blocExchangeApp.dispatch(Init(tempBodyForConversion: _tempBody));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showAlert(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Error"),
              content: Text(msg),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocExchangeApp, StateExchangeApp>(
      listener: (context, state) {
        // Default always will be Init on StateExchangeApp
        print("IMPACT");
        if (state is InitData)
          Navigator.of(context).pushAndRemoveUntil(
              TransitionBotTop(child: ExchangeApp()),
              (Route<dynamic> route) => false);
        else if (state is InitFailed)
          _showAlert(context, state.exception.toString());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: InkWell(
                onTap: () {
                  _blocExchangeApp
                      .dispatch(Init(tempBodyForConversion: _tempBody));

                  // Navigator.of(context).pushAndRemoveUntil(
                  //     MaterialPageRoute(builder: (ctx) => ExchangeApp()),
                  //     (Route<dynamic> route) => false);
                },
                child: AnimatedBuilder(
                  animation: _opacityAnimation.animate(_controller),
                  builder: (context, child) {
                    return Opacity(
                        opacity: _controller.value,
                        child: Image.asset(
                          'assets/icons/flutter.png',
                          width: 150,
                          height: 150,
                        ));
                  },
                ))),
      ),
    );
  }
}
