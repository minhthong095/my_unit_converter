import 'package:json_annotation/json_annotation.dart';
import 'package:my_unit_converter/model_response/model_mini_conversion_response.dart';
// part 'model_conversion_response.g.dart';

// @JsonSerializable(nullable: false)
class ModelConversionResponse {
  final String name;

  final List<ModelMiniConversionResponse> conversions;

  ModelConversionResponse({this.name, this.conversions});

  factory ModelConversionResponse.fromJson(Map<String, dynamic> json) =>
      ModelConversionResponse(
          name: json['name'] as String,
          conversions: (json['conversions'] as List)
              .map((e) => ModelMiniConversionResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList());

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'conversions': this.conversions,
      };
}
