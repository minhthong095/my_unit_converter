import 'package:flutter/foundation.dart';
import 'package:my_unit_converter/model_response/model_mini_conversion_response.dart';

abstract class EventConverter {}

class UpdateInput extends EventConverter {
  final String newInput;
  UpdateInput({@required this.newInput});
}

class UpdateInputType extends EventConverter {
  final ModelMiniConversionResponse inputConversion;
  UpdateInputType({@required this.inputConversion});
}

class UpdateOutputType extends EventConverter {
  final ModelMiniConversionResponse outputConversion;
  UpdateOutputType({@required this.outputConversion});
}

class ForceUpdateAll extends EventConverter {
  final String newInput;
  final ModelMiniConversionResponse outputConversion;
  final ModelMiniConversionResponse inputConversion;
  ForceUpdateAll(
      {@required this.outputConversion,
      @required this.inputConversion,
      @required this.newInput});
}
