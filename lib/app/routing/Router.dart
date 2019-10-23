import 'dart:convert';
import 'package:http/http.dart' as http;

class Router {
  static const JsonDecoder decoder = const JsonDecoder();
  static dynamic decodeFromJson(String input) => decoder.convert(input);

  String baseUrl = 'https://www.googleapis.com/books/v1/volumes?q=';

  Router(String query) {
    baseUrl = baseUrl + query;
  }

  Future<dynamic> get() =>
      http.get(baseUrl).then(_handleResponse).catchError(_handleError);

  _handleResponse(http.Response response) {
    if (response.statusCode == 200) return decodeFromJson(response.body);
    throw Error();
  }

  _handleError(e) {
    throw e;
  }
}
