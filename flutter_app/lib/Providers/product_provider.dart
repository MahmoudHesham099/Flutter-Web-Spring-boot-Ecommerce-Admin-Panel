import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Common/constants.dart';
import 'package:flutterapp/Models/product.dart';
import 'package:flutterapp/Repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];
  Product? productToEdit;
  final ProductRepository _productRepository = ProductRepository();

  getProducts(int page) async {
    List<Product> pageProducts =
        await _productRepository.getProductsList(page, null, null);
    products = products + pageProducts;
    notifyListeners();
  }

  filterProducts(int page, String? searchValue, SortTypes? sortType) async {
    bool bothNull = searchValue == null && sortType == null;
    if (!bothNull) {
      List<Product> pageProducts =
          await _productRepository.getProductsList(page, searchValue, sortType);
      products = pageProducts;
      notifyListeners();
    }
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
