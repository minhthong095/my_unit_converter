import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

// @JsonSerializable(nullable: false)
class ModelBackdropResponse {
  final String title;

  @JsonKey(name: 'icon_code')
  final String iconCode;

  final Color color;

  ModelBackdropResponse({this.title, this.iconCode, this.color});

  factory ModelBackdropResponse.fromJson(Map<String, dynamic> json) =>
      ModelBackdropResponse(
        title: json['title'] as String,
        iconCode: json['icon_code'] as String,
        color: HexColor(json['color']),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': this.title,
        'icon_code': this.iconCode,
        'color': this.color.toString(), // Temporary
      };
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}