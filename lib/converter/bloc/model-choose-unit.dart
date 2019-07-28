import 'package:my_unit_converter/converter/bloc/model-conversion.dart';

class ModelChooseUnit {
  final double valueInput;
  final ModelConversion unitFrom;
  final ModelConversion unitTo;

  const ModelChooseUnit(this.valueInput, this.unitFrom, this.unitTo);
}
