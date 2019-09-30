import 'package:flutter/foundation.dart';
import 'package:my_unit_converter/model_response/model_mini_conversion_response.dart';

abstract class EventConverter {
  const EventConverter();
}

class UpdateInput extends EventConverter {
  final String newInput;
  const UpdateInput({@required this.newInput}) : super();
}

class UpdateInputType extends EventConverter {
  final ModelMiniConversionResponse inputConversion;
  const UpdateInputType({@required this.inputConversion}) : super();
}

class UpdateOutputType extends EventConverter {
  final ModelMiniConversionResponse outputConversion;
  const UpdateOutputType({@required this.outputConversion}) : super();
}

class InitTypes extends EventConverter {
  final String newInput;
  final ModelMiniConversionResponse outputConversion;
  final ModelMiniConversionResponse inputConversion;
  const InitTypes(
      {@required this.outputConversion,
      @required this.inputConversion,
      @required this.newInput})
      : super();
}
