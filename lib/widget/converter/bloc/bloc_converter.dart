import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:my_unit_converter/model/model_convert.dart';
import 'package:my_unit_converter/networking/requesting.dart';
import 'package:my_unit_converter/widget/converter/bloc/event_converter.dart';
import 'package:my_unit_converter/widget/converter/bloc/model_conversion.dart';
import 'package:my_unit_converter/widget/converter/bloc/state_converter.dart';

class BlocConverter extends Bloc<EventConverter, StateConverter> {
  @override
  StateConverter get initialState => ConverterDefault();

  @override
  Stream<StateConverter> mapEventToState(EventConverter event) async* {
    yield* _runModifyThing(event);
  }

  Stream<ConverterUpdated> _runModifyThing(EventConverter event) async* {
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

    // print('start prime()');
    // final stopwatch = Stopwatch()..start();
    // // await compute(_test, 1);
    // await _test(1);
    // print('prime() executed in ${stopwatch.elapsed}');

    yield ConverterUpdated(
        outcome: input != ""
            ? calculateOutcome(double.parse(input), unitFrom, unitTo)
            : input,
        converter: ModelConverter(input, unitFrom, unitTo));
  }

  static _test(int a) {
    int i = -1000000000;
    while (i < 1090000000) {
      i += 1;
    }
    print("SATISFIED");
  }

  String calculateOutcome(
      double input, ModelConversion inputType, ModelConversion outputType) {
    final double outcomeValue =
        (input / inputType.conversion) * outputType.conversion;
    return isDecimal(outcomeValue)
        ? outcomeValue.toString()
        : outcomeValue.round().toString();
  }

  bool isPrime(int numX) {
    if (numX % 2 == 0) return false;
    for (int i = 3; i * i < numX; i += 2) if (numX % i == 0) return false;
    return true;
  }

  bool isDecimal(double value) => value % value.round() != 0;
}
