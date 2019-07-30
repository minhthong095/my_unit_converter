import 'package:flutter/foundation.dart';
import 'package:my_unit_converter/converter/bloc/model-conversion.dart';

abstract class EventConverter {
  const EventConverter();
}

class UpdateInput extends EventConverter {
  final String newInput;
  const UpdateInput({@required this.newInput}) : super();
}

class UpdateInputType extends EventConverter {
  final ModelConversion inputConversion;
  const UpdateInputType({@required this.inputConversion}) : super();
}

class UpdateOutputType extends EventConverter {
  final ModelConversion outputConversion;
  const UpdateOutputType({@required this.outputConversion}) : super();
}

class InitTypes extends EventConverter {
  final String newInput;
  final ModelConversion outputConversion;
  final ModelConversion inputConversion;
  const InitTypes(
      {@required this.outputConversion,
      @required this.inputConversion,
      @required this.newInput})
      : super();
}
