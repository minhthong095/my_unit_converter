import 'dart:async';

import 'package:flutter/material.dart';

class InputOutputForm extends StatefulWidget {
  final String title;
  final String newInput;
  final StreamController<double> fieldStreamA;
  final StreamController<double> fieldStreamB;
  final bool enabledField;

  const InputOutputForm(
      {@required this.title,
      this.enabledField = true,
      this.newInput,
      this.fieldStreamB,
      this.fieldStreamA});

  @override
  _InputOutputFormState createState() => _InputOutputFormState();
}

class _InputOutputFormState extends State<InputOutputForm> {
  final _controller = TextEditingController();

  @override
  void initState() {
    if (widget.fieldStreamB != null)
      widget.fieldStreamB.stream.listen((onData) {
        _controller.text = onData.toString();
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        enabled: widget.enabledField,
        controller: _controller,
        style: TextStyle(fontSize: 30, color: Colors.black38),
        onChanged: (value) {
          widget.fieldStreamA.add(double.parse(value));
        },
        decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 30, color: Colors.black38),
            labelText: widget.title,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38),
              borderRadius: BorderRadius.circular(0),
            )),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
