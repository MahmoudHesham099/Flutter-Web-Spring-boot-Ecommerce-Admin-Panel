import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

class APIService {
  final String _baseUrl = "http://localhost:8080/api";
  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };

  Future<dynamic> get(String url, Map<String, String> params) async {
    try {
      dynamic responseJson;
      Uri uri = Uri.parse(_baseUrl + url).replace(queryParameters: params);
      // params /*String|Iterable<String>*/
      http.Response response = await http.get(uri);
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
      String bodyString = json.encode(body);
      http.Response response =
          await http.post(uri, headers: headers, body: bodyString);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> put(String url, Map<String, dynamic> body) async {
    try {
      dynamic responseJson;
      Uri uri = Uri.parse(_baseUrl + url);
      String bodyString = json.encode(body);
      http.Response response =
          await http.put(uri, headers: headers, body: bodyString);
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> delete(String url) async {
    try {
      Uri uri = Uri.parse(_baseUrl + url);
      http.Response response = await http.delete(uri, headers: headers);
      return response;
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
