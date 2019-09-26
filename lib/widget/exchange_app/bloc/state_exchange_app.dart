import 'package:flutter/foundation.dart';
import 'package:my_unit_converter/model_response/model_backdrop_response.dart';
import 'package:my_unit_converter/model_response/model_conversion_response.dart';

abstract class StateExchangeApp {
  final List<ModelBackdropResponse> backdropResponse;
  final List<ModelConversionResponse> conversionResponse;
  const StateExchangeApp(this.backdropResponse, this.conversionResponse);
}

class InitData extends StateExchangeApp {
  const InitData(
      {@required List<ModelBackdropResponse> backdropResponse,
      @required List<ModelConversionResponse> conversionResponse})
      : super(backdropResponse, conversionResponse);
}
