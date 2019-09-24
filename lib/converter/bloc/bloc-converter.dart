import 'package:bloc/bloc.dart';
import 'package:my_unit_converter/converter/bloc/event-converter.dart';
import 'package:my_unit_converter/converter/bloc/model-converter.dart';
import 'package:my_unit_converter/converter/bloc/model-conversion.dart';
import 'package:my_unit_converter/converter/bloc/state-converter.dart';

class BlocConverter extends Bloc<EventConverter, StateConverter> {
  @override
  StateConverter get initialState => ConverterDefault();

  @override
  Stream<StateConverter> mapEventToState(EventConverter event) async* {
    // Formula: (mile(input) / mile(origin)) * yard(origin) = yard(output)
    final currentConverter = currentState.converter;
    String input = currentConverter.valueInput;
    ModelConversion unitFrom = currentConverter.conversionFrom;
    ModelConversion unitTo = currentConverter.conversionTo;

    if (event is UpdateInput)
      input = event.newInput;
    else if (event is UpdateInputType)
      unitFrom = event.inputConversion;
    else if (event is UpdateOutputType)
      unitTo = event.outputConversion;
    else if (event is InitTypes) {
      input = event.newInput;
      unitFrom = event.inputConversion;
      unitTo = event.outputConversion;
    }

    yield ConverterUpdated(
        outcome: input != ""
            ? calculateOutcome(double.parse(input), unitFrom, unitTo)
            : input,
        converter: ModelConverter(input, unitFrom, unitTo));
  }

  String calculateOutcome(
      double input, ModelConversion inputType, ModelConversion outputType) {
    final double outcomeValue =
        (input / inputType.conversion) * outputType.conversion;
    return isDecimal(outcomeValue)
        ? outcomeValue.toString()
        : outcomeValue.round().toString();
  }

  bool isDecimal(double value) => value % value.round() != 0;
}
