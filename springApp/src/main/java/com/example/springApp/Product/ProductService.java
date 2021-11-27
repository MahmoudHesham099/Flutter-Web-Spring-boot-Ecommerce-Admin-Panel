package com.example.springApp.Product;

import java.util.List;

public interface ProductService {

    List<Product> getProductsList();

    Product addProduct(Product product);

    Product editProduct(Product product);

    void deleteProduct(Long id);

    List<Product> findProductsByName(String name);

    List<Product> getProductsOrderByPrice();
}
