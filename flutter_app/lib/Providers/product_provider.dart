import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Models/product.dart';
import 'package:flutterapp/Repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];
  Product? productToEdit;
  final ProductRepository _productRepository = ProductRepository();
  static int page = 0;

  addProduct(Product product) async {
    Product savedProduct = await _productRepository.addProduct(product);
    products.add(savedProduct);
  }

  getProducts() async {
    List<Product> pageProducts = await _productRepository.getProductsList(page);
    products = products + pageProducts;
    page++;
  }
}
