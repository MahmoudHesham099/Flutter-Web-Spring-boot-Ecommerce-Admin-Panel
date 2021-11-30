import 'package:flutterapp/Models/product.dart';
import 'package:flutterapp/Services/api_service.dart';

class ProductRepository {
  final APIService _apiService = APIService();

  Future<List<Product>> getProductsList(int page) async {
    Map<String, String> params = {"page": page.toString()};
    dynamic response = await _apiService.get("/products", params);
    final jsonData = response['data']['content'] as List;
    List<Product> productsList =
        jsonData.map((json) => Product.fromJson(json)).toList();
    return productsList;
  }

  Future<Product> addProduct(Product product) async {
    dynamic response =
        await _apiService.post("/products/add", product.toJson(product));
    final jsonData = response['data'];
    Product savedProduct = Product.fromJson(jsonData);
    return savedProduct;
  }
}
