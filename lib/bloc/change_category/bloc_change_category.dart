import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:my_unit_converter/bloc/change_category/event_change_category.dart';
import 'package:my_unit_converter/bloc/change_category/state_change_category.dart';
import 'package:my_unit_converter/bloc/converter/bloc_converter.dart';
import 'package:my_unit_converter/bloc/converter/event_converter.dart';
import 'package:my_unit_converter/model_response/model_backdrop_response.dart';
import 'package:my_unit_converter/model_response/model_conversion_response.dart';
import 'package:my_unit_converter/tool/lodash.dart';

class BlocChangeCategory
    extends Bloc<EventChangeCategory, StateChangeCategory> {
  final int defaultIndex;
  final List<ModelBackdropResponse> data;
  final List<ModelConversionResponse> units;
  // final ModelBackdropResponse dèault
  final ModelConversionResponse defaultDetailCategory;

  BlocChangeCategory({
    @required this.defaultIndex,
    @required this.units,
    @required this.data,
    @required this.defaultDetailCategory,
  });

  @override
  StateChangeCategory get initialState => CategoryChanged(
      category: data[defaultIndex], detailCategory: defaultDetailCategory);

  @override
  Stream<StateChangeCategory> mapEventToState(
      EventChangeCategory event) async* {
    // print("EVENT CHANGE CATEGORY " + event.toString());

    // All events is change category.
    final conversion = Lodash.find(units, (model) {
      return model.name == data[(event as EventChange).index].title;
    });
    yield CategoryChanged(
        category: data[(event as EventChange).index],
        detailCategory: conversion);
  }
}
