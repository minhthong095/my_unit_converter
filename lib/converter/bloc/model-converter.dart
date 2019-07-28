import 'package:equatable/equatable.dart';
import 'package:my_unit_converter/converter/bloc/model-conversion.dart';

class ModelConverter extends Equatable {
  final String valueInput;
  final ModelConversion conversionFrom;
  final ModelConversion conversionTo;

  ModelConverter(this.valueInput, this.conversionFrom, this.conversionTo)
      : super([valueInput, conversionFrom, conversionTo]);
}
