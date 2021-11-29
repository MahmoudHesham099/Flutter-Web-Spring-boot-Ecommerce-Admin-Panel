import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

class APIService {
  final String _baseUrl = "localhost:8080";
  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };

  Future<dynamic> get(String url, Map<String, dynamic> params) async {
    try {
      dynamic responseJson;
      Uri uri = Uri.http(_baseUrl, "/api" + url, params);
      print(uri);
      http.Response response = await http.get(uri);
      print(response);
      responseJson = returnResponse(response);
      print(responseJson);
      return responseJson;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    try {
      dynamic responseJson;
      Uri uri = Uri.http(_baseUrl, "/api" + url);
      String bodyString = json.encode(body);
      http.Response response =
          await http.post(uri, headers: headers, body: bodyString);
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
