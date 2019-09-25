import 'package:flutter/cupertino.dart';
import 'package:my_unit_converter/converter/bloc/model-converter.dart';

abstract class StateConverter {
  final ModelConverter converter;
  final String outcome;
  const StateConverter(this.converter, this.outcome);
}

class ConverterDefault extends StateConverter {
  ConverterDefault() : super(ModelConverter("", null, null), "");
}

class ConverterUpdated extends StateConverter {
  const ConverterUpdated(
      {@required ModelConverter converter, @required String outcome})
      : super(converter, outcome);
}
