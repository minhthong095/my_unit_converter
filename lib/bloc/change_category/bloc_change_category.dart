import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:my_unit_converter/bloc/change_category/event_change_category.dart';

class BlocChangeCategory extends Bloc<EventChangeCategory, int> {
  final int defaultIndex;

  BlocChangeCategory({@required this.defaultIndex});

  @override
  int get initialState => defaultIndex;

  @override
  Stream<int> mapEventToState(EventChangeCategory event) async* {
    yield (event as EventChange).index;
  }
}
