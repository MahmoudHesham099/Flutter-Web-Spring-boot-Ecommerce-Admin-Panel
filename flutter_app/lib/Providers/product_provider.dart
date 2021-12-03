import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Models/product.dart';
import 'package:flutterapp/Repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];
  Product? productToEdit;
  final ProductRepository _productRepository = ProductRepository();
  static int page = 0;

  getProducts() async {
    List<Product> pageProducts = await _productRepository.getProductsList(page);
    products = products + pageProducts;
    page++;
    notifyListeners();
  }

  addProduct(Product product) async {
    Product savedProduct = await _productRepository.addProduct(product);
    products.add(savedProduct);
    notifyListeners();
  }

  editProduct(Product product) async {
    Product editedProduct = await _productRepository.editProduct(product);
    products[products.indexOf(product)] = editedProduct;
    notifyListeners();
  }

  deleteProduct(Product product) async {
    await _productRepository.deleteProduct(product);
    products.remove(product);
    notifyListeners();
  }
}
