package com.example.springApp.Services;

import com.example.springApp.Entities.Product;
import org.springframework.data.domain.Page;

public interface ProductService {

    Page<Product> getProductsList(int page);

    Product addProduct(Product product);

    Product editProduct(Product product);

    void deleteProduct(Long id);

    Page<Product> findProductsByName(String name, int page);

    Page<Product> getProductsOrderByPriceAsc(int page);

    Page<Product> getProductsOrderByPriceDesc(int page);


}
