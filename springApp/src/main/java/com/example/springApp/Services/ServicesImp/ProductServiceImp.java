package com.example.springApp.Services.ServicesImp;

import com.example.springApp.Entities.Product;
import com.example.springApp.Repositories.ProductRepository;
import com.example.springApp.Services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

@Service
@Primary
public class ProductServiceImp implements ProductService {

    @Autowired
    private ProductRepository productRepository;

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
    public Page<Product> getRequestFilters(int page,int limit,String productName, Sort.Direction sortType) {
        Page<Product> productPage = null;
        if(productName==null && sortType==null){
            productPage = getProductsList(page,limit);
        }
        if(productName!=null && sortType==null ){
            productPage = findProductsByName(page,limit,productName);
        }
        if(productName==null && sortType != null ){
            productPage = getProductsOrderByPrice(page,limit,sortType);
        }
        if(productName!=null && sortType!=null){
            productPage = findProductsByNameAndOrderByPrice(page,limit,productName,sortType);
        }
        return  productPage;
    }

    private Page<Product> getProductsList(int page, int limit) {
        Pageable pageable = PageRequest.of(page, limit);
        return productRepository.findAll(pageable);
    }

    private Page<Product> findProductsByName(int page,int limit,String productName) {
        Pageable pageable = PageRequest.of(page, limit);
        return productRepository.findByNameContainingIgnoreCase(productName, pageable);
    }


    private Page<Product> getProductsOrderByPrice(int page, int limit,Sort.Direction sortType) {
        Sort sort = Sort.by(sortType, "price");
        Pageable pageable = PageRequest.of(page, limit,sort);
        return productRepository.findAll(pageable);
    }

    private Page<Product> findProductsByNameAndOrderByPrice(int page, int limit,
                                                           String productName,
                                                           Sort.Direction sortType) {
        Sort sort = Sort.by(sortType, "price");
        Pageable pageable = PageRequest.of(page, limit,sort);
        return productRepository.findByNameContainingIgnoreCase(productName,pageable);
    }
}
