import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_unit_converter/model/model_reponse.dart';
import 'package:my_unit_converter/model_response/model_backdrop_response.dart';
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
}
