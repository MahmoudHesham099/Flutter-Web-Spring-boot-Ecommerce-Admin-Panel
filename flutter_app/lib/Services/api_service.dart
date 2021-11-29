import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

class APIService {
  final String _baseUrl = "http://localhost:8080/api";

  Future<dynamic> get(String url) async {
    try {
      dynamic responseJson;
      Uri uri = Uri.parse(_baseUrl + url);
      final response = await http.get(uri);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    try {
      dynamic responseJson;
      Uri uri = Uri.parse(_baseUrl + url);
      final response = await http.post(uri, body: body);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      print(e);
    }
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        print(response.body);
    }
  }
}
