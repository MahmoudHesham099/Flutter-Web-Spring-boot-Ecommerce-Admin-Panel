package com.example.springApp.Controllers;


import com.example.springApp.Entities.Product;
import com.example.springApp.Services.ProductService;
import com.example.springApp.Handlers.ResponseHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @GetMapping
    public ResponseEntity<Object> getProducts(){
        try {
          List<Product> products = productService.getProductsList();
          return ResponseHandler.handleResponse("Successfully get products", HttpStatus.OK,products);
        }catch (Exception e){
            return ResponseHandler.handleResponse("ERROR", HttpStatus.BAD_REQUEST,e.getMessage());
        }
    }

    @PostMapping("/add")
    public ResponseEntity<Object> addProduct(@RequestBody @Valid Product product){
        try {
            Product addedProduct = productService.addProduct(product);
            return ResponseHandler.handleResponse("Successfully add product", HttpStatus.OK,addedProduct);
        }catch (Exception e){
            return ResponseHandler.handleResponse("ERROR", HttpStatus.BAD_REQUEST,e.getMessage());
        }
    }

    @PutMapping("/edit")
    public ResponseEntity<Object> editProduct(@RequestBody @Valid Product product){
        try {
            Product editedProduct = productService.editProduct(product);
            if(editedProduct!=null){
                return ResponseHandler.handleResponse("Successfully edit product", HttpStatus.OK,editedProduct);
            }else{
                return ResponseHandler.handleResponse("Product Id Not exist", HttpStatus.BAD_REQUEST,null);
            }
        }catch (Exception e){
            return ResponseHandler.handleResponse("ERROR", HttpStatus.BAD_REQUEST,e.getMessage());
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Object> deleteProduct(@PathVariable Long id){
        try {
            productService.deleteProduct(id);
            return ResponseHandler.handleResponse("Successfully delete product", HttpStatus.OK,null);
        }catch (Exception e){
            return ResponseHandler.handleResponse("ERROR", HttpStatus.BAD_REQUEST,e.getMessage());
        }
    }

    @GetMapping("/find")
    public ResponseEntity<Object> findProducts(@RequestParam String name){
        try {
            List<Product> products = productService.findProductsByName(name);
            return ResponseHandler.handleResponse("Successfully find products", HttpStatus.OK,products);
        }catch (Exception e){
            return ResponseHandler.handleResponse("ERROR", HttpStatus.BAD_REQUEST,e.getMessage());
        }
    }

    @GetMapping("/sort/price/asc")
    public ResponseEntity<Object> sortProductsByPriceAsc(){
        try {
            List<Product> products = productService.getProductsOrderByPriceAsc();
            return ResponseHandler.handleResponse("Successfully sort products", HttpStatus.OK,products);
        }catch (Exception e){
            return ResponseHandler.handleResponse("ERROR", HttpStatus.BAD_REQUEST,e.getMessage());
        }
    }

    @GetMapping("/sort/price/desc")
    public ResponseEntity<Object> sortProductsByPriceDesc(){
        try {
            List<Product> products = productService.getProductsOrderByPriceDesc();
            return ResponseHandler.handleResponse("Successfully sort products", HttpStatus.OK,products);
        }catch (Exception e){
            return ResponseHandler.handleResponse("ERROR", HttpStatus.BAD_REQUEST,e.getMessage());
        }
    }
}
