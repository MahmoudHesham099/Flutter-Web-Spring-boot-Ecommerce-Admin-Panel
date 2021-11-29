import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Models/product.dart';
import 'package:flutterapp/Repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  Product? _productToEdit;
  final ProductRepository _productRepository = ProductRepository();

  addProduct(Product product) async {
    Product savedProduct = await _productRepository.addProduct(product);
    _products.add(savedProduct);
  }

  getAllProducts() {
    return _products;
  }

  getProductToEdit() {
    return _productToEdit;
  }

  setProducts(List<Product> events) {
    _products = events;
    notifyListeners();
  }

  setProductToEdit(Product? event) {
    _productToEdit = event;
  }
}
