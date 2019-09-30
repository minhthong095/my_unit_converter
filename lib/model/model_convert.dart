import 'package:equatable/equatable.dart';
import 'package:my_unit_converter/model_response/model_mini_conversion_response.dart';

class ModelConverter {
  final String valueInput;
  final ModelMiniConversionResponse conversionFrom;
  final ModelMiniConversionResponse conversionTo;

  ModelConverter(this.valueInput, this.conversionFrom, this.conversionTo);
}
