import 'dart:convert';

import 'package:flutterapp/Common/constants.dart';
import 'package:flutterapp/Models/product.dart';
import 'package:flutterapp/Services/api_service.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  final APIService _apiService = APIService();

  Future<Map<String, dynamic>> getProductsList(
      int page, String? searchValue, SortTypes? sortType) async {
    Map<String, String> params = {
      "page": page.toString(),
      "limit": PAGE_LIMIT.toString()
    };
    if (searchValue != null) params["productName"] = searchValue;
    if (sortType != null) {
      params["sortType"] = sortType.toString().split('.').last;
    }
    http.Response response = await _apiService.get("/products", params);
    dynamic responseJson = jsonDecode(response.body);
    final productsData = responseJson['data']['content'] as List;
    List<Product> productsList =
        productsData.map((json) => Product.fromJson(json)).toList();
    final pagesData = responseJson['data']['totalPages'];
    Map<String, dynamic> returnedData = {
      "products list": productsList,
      "pages number": pagesData
    };
    return returnedData;
  }

  Future<Product> addProduct(Product product) async {
    http.Response response =
        await _apiService.post("/products/add", product.toJson(product));
    dynamic responseJson = jsonDecode(response.body);
    final jsonData = responseJson['data'];
    Product savedProduct = Product.fromJson(jsonData);
    return savedProduct;
  }

  Future<Product> editProduct(Product product) async {
    http.Response response =
        await _apiService.put("/products/edit", product.toJson(product));
    dynamic responseJson = jsonDecode(response.body);
    final jsonData = responseJson['data'];
    Product editedProduct = Product.fromJson(jsonData);
    return editedProduct;
  }

  Future<dynamic> deleteProduct(Product product) async {
    http.Response response =
        await _apiService.delete("/products/delete/${product.id}");
    dynamic responseJson = jsonDecode(response.body);
    final jsonMessage = responseJson['message'];
  }
}
