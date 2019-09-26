import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_unit_converter/model/model_reponse.dart';
import 'package:my_unit_converter/model_response/model_backdrop_response.dart';
import 'package:my_unit_converter/model_response/model_conversion_response.dart';
import 'package:my_unit_converter/networking/url.dart';

class Requesting {
  static final _headers = {'Content-Type': 'application/json'};

  static Future<ModelReponse<List<ModelBackdropResponse>>>
      getListBackdrop() async {
    final reponse = await http.get(URL.backdropList, headers: _headers);

    List<ModelBackdropResponse> list =
        (jsonDecode(reponse.body) as List).map((model) {
      return ModelBackdropResponse.fromJson(model);
    }).toList();

    return ModelReponse<List<ModelBackdropResponse>>(
        rawReponse: reponse, data: list);
  }

  static Future<ModelReponse<List<ModelConversionResponse>>> postConversionData(
      Map<String, dynamic> body) async {
    final reponse = await _postBody(URL.conversions, body: body);

    List<ModelConversionResponse> list =
        (jsonDecode(reponse.body) as List).map((model) {
      return ModelConversionResponse.fromJson(model);
    }).toList();

    return ModelReponse<List<ModelConversionResponse>>(
        rawReponse: reponse, data: list);
  }

  static Future<http.Response> _postBody(String url,
      {Map<String, String> headers, Map<String, dynamic> body}) {
    return http.post(url, headers: headers, body: jsonEncode(body));
  }
}
