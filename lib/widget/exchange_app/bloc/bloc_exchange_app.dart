import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:my_unit_converter/model_response/model_backdrop_response.dart';
import 'package:my_unit_converter/model_response/model_conversion_response.dart';
import 'package:my_unit_converter/networking/requesting.dart';
import 'package:my_unit_converter/networking/url.dart';
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

  Stream<StateExchangeApp> _initDataExchangeApp(EventExchangeApp event) async* {
    if (event is prefix0.Init) {
      try {
        // final stopwatch = Stopwatch()..start();
        // final responseBackdrop =
        //     await Requesting2.singleton().getListBackdrop();

        // final responseConversions = await Requesting2.singleton()
        //     .postConversionData(event.tempBodyForConversion);
        // print('two() executed in ${stopwatch.elapsed}');
        // InitData(
        //     backdropResponse: responseBackdrop.data,
        //     conversionResponse: responseConversions.data);

        // final stopwatch2 = Stopwatch()..start();
        // final all = await Requesting2.singleton()
        //     .getAllData(event.tempBodyForConversion);
        // print('all() executed in ${stopwatch2.elapsed}');
        // InitData(
        //     backdropResponse: all[0].data, conversionResponse: all[1].data);

        // final stopwatch3 = Stopwatch()..start();
        // final all2 = await Requesting2.singleton()
        //     .getAllData2(event.tempBodyForConversion);
        // print('all2() executed in ${stopwatch3.elapsed}');
        // InitData(
        //     backdropResponse: all2[0].data, conversionResponse: all2[1].data);

        // final stopwatch2 = Stopwatch()..start();
        final all = await Requesting2.singleton()
            .getAllData(event.tempBodyForConversion);
        // print('all() executed in ${stopwatch2.elapsed}');
        yield InitData(
            backdropResponse: all[0].data, conversionResponse: all[1].data);
      } catch (e) {
        print(e);
        yield InitFailed(e: e);
      }
    }
  }
}
