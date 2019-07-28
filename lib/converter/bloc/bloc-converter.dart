import 'package:bloc/bloc.dart';
import 'package:my_unit_converter/converter/bloc/event-converter.dart';
import 'package:my_unit_converter/converter/bloc/model-choose-unit.dart';
import 'package:my_unit_converter/converter/bloc/model-conversion.dart';
import 'package:my_unit_converter/converter/bloc/state-converter.dart';

class BlocConverter extends Bloc<EventConverter, StateConverter> {
  @override
  StateConverter get initialState => ConverterDefault();

  @override
  Stream<StateConverter> mapEventToState(EventConverter event) async* {
    if (event is EventConverterTest) {
      print("BLAME IT ON ME");
      return;
    }
    if (event is UpdateInput) {
      yield ConverterUpdated(
          chooseUnit: ModelChooseUnit(123, ModelConversion("123", 1, false),
              ModelConversion("123", 123, false)));
      return;
    }
  }
}
