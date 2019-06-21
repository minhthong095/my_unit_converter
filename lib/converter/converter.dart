import 'package:flutter/material.dart';

// Formula: (mile(input) / mile(origin)) * yard(origin) = yard(output)

class Converter extends StatefulWidget {
  final List unit;

  const Converter({@required this.unit});

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              InputOutputForm.input(),
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
              InputOutputForm.output(),
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

class InputOutputForm extends StatelessWidget {
  final String _title;

  const InputOutputForm.output() : _title = 'Output';
  const InputOutputForm.input() : _title = 'Input';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        style: TextStyle(fontSize: 30, color: Colors.black38),
        decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 30, color: Colors.black38),
            labelText: _title,
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
