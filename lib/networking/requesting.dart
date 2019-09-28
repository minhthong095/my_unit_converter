import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
    final reponse = await _post(URL.conversions, body: body);

    List<ModelConversionResponse> list =
        (jsonDecode(reponse.body) as List).map((model) {
      return ModelConversionResponse.fromJson(model);
    }).toList();

    return ModelReponse<List<ModelConversionResponse>>(
        rawReponse: reponse, data: list);
  }

  static Future<http.Response> _post(String url,
      {Map<String, String> headers, Map<String, dynamic> body}) {
    return http.post(url, headers: headers, body: jsonEncode(body));
  }
}

class Requesting2 {
  static final Requesting2 _singleton = Requesting2._();
  factory Requesting2.singleton() => _singleton;
  Requesting2._();

  static final _option = BaseOptions(
      connectTimeout: 7000, headers: {'Content-Type': 'application/json'});
  final _dio = Dio(_option);

  Future<Response> getListBackdrop() async {
    final response = await sending<ModelBackdropResponse>(
        'get', URL.backdropList, cast: (model) {
      return ModelBackdropResponse.fromJson(model);
    });

    return response;
  }

  Future<Response> postConversionData(Map<String, dynamic> body) async {
    final response = await sending<ModelConversionResponse>(
        'post', URL.conversions,
        body: body, cast: (model) {
      return ModelConversionResponse.fromJson(model);
    });
    return response;
  }

  Future<List<Response>> getAllData(Map<String, dynamic> bodyConversion) async {
    final a = await Future.wait([
      _dio.get(URL.backdropList),
      _dio.post(URL.conversions, data: bodyConversion)
    ]);

    a[0].data = _castListData<ModelBackdropResponse>(a[0], (model) {
      return ModelBackdropResponse.fromJson(model);
    });

    a[1].data = _castListData<ModelConversionResponse>(a[1], (model) {
      return ModelConversionResponse.fromJson(model);
    });

    // a[1].data = _wrapComputeParseConversions(a[1]);
    return a;
  }

  // Future<List<Response>> getAllData2(
  //     Map<String, dynamic> bodyConversion) async {
  //   final a = await Future.wait([
  //     _dio.get(URL.backdropList),
  //     _dio.post(URL.conversions, data: bodyConversion)
  //   ]);

  //   final b = await Future.wait([
  //     compute(_wrapComputeParseBackdrop, a[0].data),
  //     compute(_wrapComputeParseConversions, a[1].data)
  //   ]);

  //   a[0].data = b[0];

  //   a[1].data = b[1];

  //   return a;
  // }

  Future<List<Response>> getAllData2(
      Map<String, dynamic> bodyConversion) async {
    final a = await Future.wait([
      _dio.get(URL.backdropList),
      _dio.post(URL.conversions, data: bodyConversion)
    ]);

    final b = await compute(_wrapAll, <dynamic>[a[0].data, a[1].data]);

    a[0].data = b[0];

    a[1].data = b[1];

    return a;
  }

  static List<dynamic> _wrapAll(List<dynamic> responses) {
    final result = <dynamic>[];
    result.add(responses[0].map<ModelBackdropResponse>((model) {
      return ModelBackdropResponse.fromJson(model);
    }).toList());
    result.add(responses[1].map<ModelConversionResponse>((model) {
      return ModelConversionResponse.fromJson(model);
    }).toList());
    return result;
    // return <ModelBackdropResponse>[];
  }

  static List<ModelBackdropResponse> _wrapComputeParseBackdrop(
      dynamic response) {
    return response.map<ModelBackdropResponse>((model) {
      return ModelBackdropResponse.fromJson(model);
    }).toList();
    // return <ModelBackdropResponse>[];
  }

  static List<ModelConversionResponse> _wrapComputeParseConversions(
      dynamic response) {
    return response.map<ModelConversionResponse>((model) {
      return ModelConversionResponse.fromJson(model);
    }).toList();
    // return <ModelConversionResponse>[];
  }

  // Support small cast only for list json.
  Future<Response> sending<T>(String method, String url,
      {Map<String, dynamic> body, T Function(dynamic model) cast}) async {
    final response =
        await _dio.request(url, data: body, options: Options(method: method));

    response.data = _castListData<T>(response, cast);

    return response;
  }

  static List<T> _castListData<T>(
      Response response, T Function(dynamic model) cast) {
    return response.data.map<T>((model) {
      return cast(model);
    }).toList();
  }
}

typedef CreateJson = A Function(dynamic model);
