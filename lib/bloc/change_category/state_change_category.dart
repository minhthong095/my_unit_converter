import 'package:flutter/widgets.dart';
import 'package:my_unit_converter/model_response/model_backdrop_response.dart';
import 'package:my_unit_converter/model_response/model_conversion_response.dart';

abstract class StateChangeCategory {
  final ModelBackdropResponse category;
  final ModelConversionResponse detailCategory;
  const StateChangeCategory({this.category, this.detailCategory});
}

class CategoryChanged extends StateChangeCategory {
  CategoryChanged(
      {@required ModelBackdropResponse category,
      @required ModelConversionResponse detailCategory})
      : super(category: category, detailCategory: detailCategory);
}
