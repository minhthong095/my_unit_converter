import 'package:bloc/bloc.dart';
import 'package:my_unit_converter/bloc/alert_failed/bloc_alert_failed.dart';
import 'package:my_unit_converter/bloc/alert_failed/event_alert_failed.dart';
import 'package:my_unit_converter/bloc/exchange_app/state_exchange_app.dart';
import 'package:my_unit_converter/networking/requesting.dart';

import 'event_exchange_app.dart';

class BlocExchangeApp extends Bloc<EventExchangeApp, StateExchangeApp> {
  final BlocAlertFailed _blocAlertFailed;

  BlocExchangeApp(this._blocAlertFailed);

  @override
  StateExchangeApp get initialState =>
      InitData(backdropResponse: null, conversionResponse: null);

  @override
  Stream<StateExchangeApp> mapEventToState(EventExchangeApp event) async* {
    yield* _initDataExchangeApp(event);
  }

  Stream<StateExchangeApp> _initDataExchangeApp(EventExchangeApp event) async* {
    if (event is Init) {
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
        // print(e);
        _blocAlertFailed.add(EventAlertFailed());
        yield InitFailed(e: e);
      }
    }
  }
}
