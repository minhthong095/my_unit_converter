import 'dart:async';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_unit_converter/converter/bloc/bloc-converter.dart';
import 'package:my_unit_converter/converter/bloc/event-converter.dart';
import 'package:my_unit_converter/converter/bloc/model-conversion.dart';

// Formula: (mile(input) / mile(origin)) * yard(origin) = yard(output)

class Converter extends StatefulWidget {
  final List<ModelConversion> unit;

  const Converter({@required this.unit});

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => BlocConverter(),
      child: Container(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: <Widget>[
                _InputOutputForm(
                  title: 'Input',
                ),
                SizedBox(
                  height: 20,
                ),
                _DropDownForm(data: widget.unit),
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
                _InputOutputForm(
                  title: 'Output',
                  enabledField: false,
                ),
                SizedBox(
                  height: 20,
                ),
                _DropDownForm(
                  data: widget.unit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DropDownForm extends StatefulWidget {
  final List<ModelConversion> data;
  final StreamController<double> chooseUnitStreamA;
  final StreamController<double> chooseUnitStreamB;
  final StreamController<double> inOutStream;

  const _DropDownForm(
      {@required this.data,
      this.chooseUnitStreamA,
      this.chooseUnitStreamB,
      this.inOutStream});

  @override
  _DropDownFormState createState() => _DropDownFormState();
}

class _DropDownFormState extends State<_DropDownForm> {
  @override
  void initState() {
    // if (widget.ch  ooseUnitStreamB != null)
    //   widget.chooseUnitStreamB.stream.listen((onData) {
    //     print('OnData ' + onData.toString());
    //   });
    if (widget.inOutStream != null && widget.chooseUnitStreamB != null) {
      StreamGroup.merge(
              [widget.inOutStream.stream, widget.chooseUnitStreamB.stream])
          .asBroadcastStream(onListen: (listen) {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.black38)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<double>(
              hint: Text('Choose'),
              onChanged: (double conversion) {
                widget.chooseUnitStreamA.add(conversion);
              },
              value: widget.data[0].conversion,
              items: widget.data.map((value) {
                return DropdownMenuItem<double>(
                    value: value.conversion,
                    child: Text(
                      value.name,
                      style: TextStyle(fontSize: 24),
                    ));
              }).toList()),
        ));
  }
}

class _InputOutputForm extends StatefulWidget {
  final String title;
  final String newInput;
  final bool enabledField;

  const _InputOutputForm(
      {@required this.title, this.enabledField = true, this.newInput});

  @override
  _InputOutputFormState createState() => _InputOutputFormState();
}

class _InputOutputFormState extends State<_InputOutputForm> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BlocConverter blocConverter = BlocProvider.of<BlocConverter>(context);

    return Container(
      child: TextField(
        enabled: widget.enabledField,
        controller: _controller,
        style: TextStyle(fontSize: 30, color: Colors.black38),
        onChanged: (value) {
          blocConverter.dispatch(EventConverterTest());
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
