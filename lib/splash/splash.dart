import 'package:flutter/material.dart';
import 'package:my_unit_converter/exchange_app/exchange_app.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
