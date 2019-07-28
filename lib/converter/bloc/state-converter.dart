import 'package:flutter/cupertino.dart';
import 'package:my_unit_converter/converter/bloc/model-choose-unit.dart';

abstract class StateConverter {}

class ConverterDefault extends StateConverter {
  final ModelChooseUnit chooseUnit = ModelChooseUnit(0, null, null);
}

class ConverterUpdated extends StateConverter {
  final ModelChooseUnit chooseUnit;

  ConverterUpdated({@required this.chooseUnit});
}
