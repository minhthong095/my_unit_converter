import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_unit_converter/bloc/exchange_app/bloc_exchange_app.dart';
import 'package:my_unit_converter/bloc/exchange_app/state_exchange_app.dart';

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
    // _blocExchangeApp.dispatch(Init(tempBodyForConversion: _tempBody));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocExchangeApp, StateExchangeApp>(
      listener: (context, state) {
        // Default always will be Init on StateExchangeApp
        print("IMPACT");
        // if (state is InitData)
        //   Navigator.of(context).pushAndRemoveUntil(
        //       TransitionBotTop(child: ExchangeApp()),
        //       (Route<dynamic> route) => false);
        // else if (state is InitFailed)
        // _showAlert(context, state.exception.toString());
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                Center(
                    child: InkWell(
                        onTap: () {},
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
                        ))),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: FractionallySizedBox(
                      widthFactor: 0.7,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              stops: [0.04, 0.04],
                              colors: [
                                Colors.red,
                                Colors.green,
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.5))),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
