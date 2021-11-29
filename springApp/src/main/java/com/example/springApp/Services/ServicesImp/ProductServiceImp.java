package com.example.springApp.Services.ServicesImp;

import com.example.springApp.Entities.Product;
import com.example.springApp.Repositories.ProductRepository;
import com.example.springApp.Services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@Primary
public class ProductServiceImp implements ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Override
    public Page<Product> getProductsList(int page) {
        Pageable pageable = PageRequest.of(page, 3);
        return productRepository.findAll(pageable);
    }

    @Override
    public Product addProduct(Product product) {
        return productRepository.save(product);
    }

    @Override
    public Product editProduct(Product product) {
        boolean exist = productRepository.existsById(product.getId());
        if(exist){
          return productRepository.save(product);
        }
        return null;
    }

    @Override
    public void deleteProduct(Long id) {
        productRepository.deleteById(id);
    }

    @Override
    public Page<Product> findProductsByName(String name, int page) {
        Pageable pageable = PageRequest.of(page, 3);
        return productRepository.findByNameContainingIgnoreCase(name, pageable);
    }

    @Override
    public Page<Product> getProductsOrderByPriceAsc(int page) {
        Pageable pageable = PageRequest.of(page, 3);
        return productRepository.findAllByOrderByPriceAsc(pageable);
    }

    @Override
    public Page<Product> getProductsOrderByPriceDesc(int page) {
        Pageable pageable = PageRequest.of(page, 3);
        return productRepository.findAllByOrderByPriceDesc(pageable);
    }
}
