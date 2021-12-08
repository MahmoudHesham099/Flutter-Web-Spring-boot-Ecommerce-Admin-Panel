import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Common/constants.dart';
import 'package:flutterapp/Models/product.dart';
import 'package:flutterapp/Repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];
  Product? productToEdit;
  int pagesNumber = 0;

  final ProductRepository _productRepository = ProductRepository();

  getProducts(int page, String? searchValue, SortTypes? sortType,
      GetTypes getTypes) async {
    Map<String, dynamic> returnedData =
        await _productRepository.getProductsList(page, searchValue, sortType);
    List<Product> pageProducts = returnedData["products list"];
    pagesNumber = returnedData["pages number"];
    if (getTypes == GetTypes.PAGING) {
      products = products + pageProducts;
    } else if (getTypes == GetTypes.FILTER) {
      products = pageProducts;
    }
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
