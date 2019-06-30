import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_unit_converter/converter/dropdown-form.dart';
import 'package:my_unit_converter/converter/input-output-form.dart';

// Formula: (mile(input) / mile(origin)) * yard(origin) = yard(output)

class Converter extends StatefulWidget {
  final List unit;

  const Converter({@required this.unit});

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  final _inOutStream = StreamController<double>();
  final _convertStream = StreamController<double>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              InputOutputForm(
                title: 'Input',
                fieldStreamA: _inOutStream,
              ),
              SizedBox(
                height: 20,
              ),
              DropDownForm(
                  data: widget.unit, chooseUnitStreamA: _convertStream),
              SizedBox(
                height: 40,
              ),
              Image.asset(
                'assets/images/arrow.png',
                scale: 12,
              ),
              SizedBox(
                height: 40,
              ),
              InputOutputForm(
                title: 'Output',
                fieldStreamB: _inOutStream,
                enabledField: false,
              ),
              SizedBox(
                height: 20,
              ),
              DropDownForm(
                  inOutStream: _inOutStream,
                  data: widget.unit,
                  chooseUnitStreamB: _convertStream),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _inOutStream.close();
    _convertStream.close();
    super.dispose();
  }
}
