// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_backdrop_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelBackdropResponse _$ModelBackdropResponseFromJson(
    Map<String, dynamic> json) {
  return ModelBackdropResponse(
    title: json['title'] as String,
    iconCode: json['icon_code'] as String,
    color: HexColor(json['color']),
  );
}

Map<String, dynamic> _$ModelBackdropResponseToJson(
        ModelBackdropResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'icon_code': instance.iconCode,
      'color': instance.color,
    };

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
