import 'package:http/http.dart';

class ModelReponse<T> {
  final Response rawReponse;
  final T data;

  ModelReponse({this.rawReponse, this.data});
}
