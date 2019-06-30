import 'dart:async';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

class DropDownForm extends StatefulWidget {
  final List data;
  final StreamController<double> chooseUnitStreamA;
  final StreamController<double> chooseUnitStreamB;
  final StreamController<double> inOutStream;

  const DropDownForm(
      {@required this.data,
      this.chooseUnitStreamA,
      this.chooseUnitStreamB,
      this.inOutStream});

  @override
  _DropDownFormState createState() => _DropDownFormState();
}

class _DropDownFormState extends State<DropDownForm> {
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
              value: widget.data[0]['conversion'],
              items: widget.data.map((value) {
                return DropdownMenuItem<double>(
                    value: value['conversion'],
                    child: Text(
                      value['name'],
                      style: TextStyle(fontSize: 24),
                    ));
              }).toList()),
        ));
  }
}
