import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_unit_converter/bloc/alert_failed/bloc_alert_failed.dart';
import 'package:my_unit_converter/bloc/alert_failed/state_alert_failed.dart'
    as prefix0;

// Suitable for screen Widget.
class AlertFailed extends StatefulWidget {
  final Widget partner;

  const AlertFailed({this.partner});

  @override
  _FailedAlert createState() => _FailedAlert();
}

class _FailedAlert extends State<AlertFailed>
    with SingleTickerProviderStateMixin {
  static final double _marginBot = 40;
  static final double _heightAlert = 50;
  AnimationController _controller;
  final _tweenPosition = Tween<double>(begin: -_heightAlert, end: _marginBot)
      .chain(CurveTween(curve: Curves.easeOutExpo));
  Animation<double> _animation;
  BlocAlertFailed _blocAlertFailed;
  StreamSubscription _listenerAlertFailed;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(const Duration(milliseconds: 1100), () {});
        _controller.reverse();
      }
    });
    _animation = _tweenPosition.animate(_controller);

    _blocAlertFailed = BlocProvider.of<BlocAlertFailed>(context);
    _listenerAlertFailed = _blocAlertFailed.listen((state) {
      if (state is prefix0.OnAlertFailed) _controller.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          widget.partner,
          AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget child) {
              return Positioned(
                bottom: _animation.value,
                left: 0,
                right: 0,
                child: Container(
                  height: _heightAlert,
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: 0.7,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Something failed.",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 2.5),
                                blurRadius: 2,
                                color: Colors.grey[400])
                          ],
                          gradient: LinearGradient(
                            stops: [0.032, 0.032],
                            colors: [
                              Colors.red,
                              Colors.grey[50],
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(2.5))),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      );

  @override
  void dispose() {
    _controller.dispose();
    _listenerAlertFailed.cancel();
    super.dispose();
  }
}
