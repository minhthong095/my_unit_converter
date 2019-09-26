import 'package:bloc/bloc.dart';
import 'package:my_unit_converter/networking/requesting.dart';
import 'package:my_unit_converter/widget/exchange_app/bloc/event_exchange_app.dart';
import 'package:my_unit_converter/widget/exchange_app/bloc/event_exchange_app.dart'
    as prefix0;
import 'package:my_unit_converter/widget/exchange_app/bloc/state_exchange_app.dart';

class BlocExchangeApp extends Bloc<EventExchangeApp, StateExchangeApp> {
  @override
  StateExchangeApp get initialState =>
      InitData(backdropResponse: null, conversionResponse: null);

  @override
  Stream<StateExchangeApp> mapEventToState(EventExchangeApp event) async* {
    yield* _initDataExchangeApp(event);
  }

  Stream<InitData> _initDataExchangeApp(EventExchangeApp event) async* {
    if (event is prefix0.Init) {
      try {
        final responseBackdrop = await Requesting.getListBackdrop();
        final responseConversions =
            await Requesting.postConversionData(event.tempBodyForConversion);

        yield InitData(
            backdropResponse: responseBackdrop.data,
            conversionResponse: responseConversions.data);
      } catch (e) {
        yield InitData(backdropResponse: null, conversionResponse: null);
      }
    }
  }
}
