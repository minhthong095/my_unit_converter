import 'dart:async';

import 'package:flutter/material.dart';

// Formula: (mile(input) / mile(origin)) * yard(origin) = yard(output)

class Converter extends StatefulWidget {
  final List unit;

  const Converter({@required this.unit});

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  final _inputStream = StreamController<String>();

  @override
  void dispose() {
    _inputStream.close();
    super.dispose();
  }

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
                inputStream: _inputStream,
              ),
              SizedBox(
                height: 20,
              ),
              DropDownForm(
                data: widget.unit,
              ),
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
              InputOutputForm(title: 'Output', newInputStream: _inputStream),
              SizedBox(
                height: 20,
              ),
              DropDownForm(
                data: widget.unit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputOutputForm extends StatefulWidget {
  final String title;
  final String newInput;
  final StreamController<String> inputStream;
  final StreamController<String> newInputStream;

  const InputOutputForm(
      {@required this.title,
      this.newInput,
      this.newInputStream,
      this.inputStream});

  @override
  _InputOutputFormState createState() => _InputOutputFormState();
}

class _InputOutputFormState extends State<InputOutputForm> {
  final _controller = TextEditingController();

  @override
  void initState() {
    if (widget.newInputStream != null)
      widget.newInputStream.stream.listen((onData) {
        _controller.text = onData;
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
        controller: _controller,
        style: TextStyle(fontSize: 30, color: Colors.black38),
        onChanged: (value) {
          widget.inputStream.add(value);
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

class DropDownForm extends StatelessWidget {
  final List data;

  const DropDownForm({@required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.black38)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
              hint: Text('Choose'),
              onChanged: (_) {},
              value: this.data[0]['name'],
              items: this.data.map((value) {
                return DropdownMenuItem<String>(
                    value: value['name'],
                    child: Text(
                      value['name'],
                      style: TextStyle(fontSize: 24),
                    ));
              }).toList()),
        ));
  }
}
