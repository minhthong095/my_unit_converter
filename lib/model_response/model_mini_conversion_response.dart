import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

// part 'model_mini_conversion_response.g.dart';

// @JsonSerializable(nullable: false)
class ModelMiniConversionResponse extends Equatable {
  final String name;

  final double conversion;

  @JsonKey(name: 'base_unit', defaultValue: false, nullable: true)
  final bool baseUnit;

  ModelMiniConversionResponse({this.name, this.conversion, this.baseUnit});

  factory ModelMiniConversionResponse.fromJson(Map<String, dynamic> json) =>
      ModelMiniConversionResponse(
        name: json['name'] as String,
        conversion: json['conversion'] as double,
        baseUnit: json['base_unit'] as bool ?? false,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'conversion': this.conversion,
        'base_unit': this.baseUnit,
      };

  @override
  List<Object> get props => [name, conversion, baseUnit];
}
