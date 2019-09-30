import 'package:bloc/bloc.dart';
import 'package:my_unit_converter/bloc/alert_failed/event_alert_failed.dart';
import 'package:my_unit_converter/bloc/alert_failed/state_alert_failed.dart';

class BlocAlertFailed extends Bloc<EventAlertFailed, StateAlertFailed> {
  @override
  StateAlertFailed get initialState => OnAlertEmpty();

  @override
  Stream<StateAlertFailed> mapEventToState(EventAlertFailed event) async* {
    yield OnAlertFailed();
  }
}
