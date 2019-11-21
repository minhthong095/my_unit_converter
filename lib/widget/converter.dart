import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_unit_converter/bloc/converter/bloc_converter.dart';
import 'package:my_unit_converter/bloc/converter/event_converter.dart';
import 'package:my_unit_converter/bloc/converter/state_converter.dart';
import 'package:my_unit_converter/model_response/model_mini_conversion_response.dart';
import 'package:my_unit_converter/screen/exchange_app.dart';

class Converter extends StatefulWidget {
  final List<ModelMiniConversionResponse> units;

  const Converter({@required this.units});

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
              _InputOutputForm(
                newInput: "", // Default after rebuild
                title: 'Input',
              ),
              SizedBox(
                height: 20,
              ),
              _DropDownForm(data: widget.units),
              SizedBox(
                height: 100,
              ),
              BlocBuilder<BlocConverter, StateConverter>(
                builder: (context, state) {
                  return _InputOutputForm(
                      enabledField: false, newInput: state.outcome);
                },
              ),
              SizedBox(
                height: 20,
              ),
              _DropDownForm(
                bSide: true,
                data: widget.units,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropDownForm extends StatefulWidget {
  final List<ModelMiniConversionResponse> data;
  final bool bSide;

  const _DropDownForm({@required this.data, this.bSide = false});

  @override
  _DropDownFormState createState() => _DropDownFormState();
}

class _DropDownFormState extends State<_DropDownForm> {
  BlocConverter blocConverter;

  @override
  void initState() {
    blocConverter = BlocProvider.of<BlocConverter>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocConverter, StateConverter>(
      builder: (context, state) {
        // print("BUILD DROPDOWN FORM");
        return Container(
            width: double.infinity,
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black38)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<ModelMiniConversionResponse>(
                  hint: Text('Choose'),
                  onChanged: (ModelMiniConversionResponse conversion) {
                    widget.bSide
                        ? blocConverter.dispatch(
                            UpdateOutputType(outputConversion: conversion))
                        : blocConverter.dispatch(
                            UpdateInputType(inputConversion: conversion));
                  },
                  value: widget.bSide
                      ? state.converter.conversionTo
                      : state.converter.conversionFrom,
                  items: widget.data.map((value) {
                    return DropdownMenuItem<ModelMiniConversionResponse>(
                        value: value,
                        child: Text(
                          value.name,
                          style: TextStyle(fontSize: 24),
                        ));
                  }).toList()),
            ));
      },
    );
  }
}

class _InputOutputForm extends StatefulWidget {
  final String title;
  final String newInput;
  final bool enabledField;

  const _InputOutputForm(
      {this.title = '', this.enabledField = true, this.newInput});

  @override
  _InputOutputFormState createState() => _InputOutputFormState();
}

class _InputOutputFormState extends State<_InputOutputForm> {
  final _controller = TextEditingController();
  BlocConverter blocConverter;

  @override
  void didUpdateWidget(_InputOutputForm oldWidget) {
    _controller.text = widget.newInput;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    blocConverter = BlocProvider.of<BlocConverter>(context);
  }

  @override
  void didChangeDependencies() {
    InheritedHidePanelCallback.of(context).hidePanelCallback =
        _hidePanelCallback;
    super.didChangeDependencies();
  }

  void _hidePanelCallback() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    // print("BUILD INOUT FORM");
    return Container(
      color: widget.enabledField ? null : Colors.grey[100],
      child: TextField(
        enabled: widget.enabledField,
        controller: _controller,
        style: TextStyle(fontSize: 30, color: Colors.black38),
        onChanged: (value) {
          blocConverter.dispatch(UpdateInput(newInput: value));
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
