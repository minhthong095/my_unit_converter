import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_backdrop_response.g.dart';

@JsonSerializable(nullable: false)
class ModelBackdropResponse {
  final String title;

  @JsonKey(name: 'icon_code')
  final String iconCode;

  final Color color;

  ModelBackdropResponse({this.title, this.iconCode, this.color});

  factory ModelBackdropResponse.fromJson(Map<String, dynamic> json) =>
      _$ModelBackdropResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ModelBackdropResponseToJson(this);
}
