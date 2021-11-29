package com.example.springApp.Controllers;


import com.example.springApp.Entities.Product;
import com.example.springApp.Services.ProductService;
import com.example.springApp.Handlers.ResponseHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.websocket.server.PathParam;
import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("/api/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @GetMapping
    public ResponseEntity<Object> getProducts(@RequestParam int page){
        try {
          Page<Product> productPage = productService.getProductsList(page);
          return ResponseHandler.handleResponse("Successfully get products",HttpStatus.OK,productPage);
        }catch (Exception e){
            return ResponseHandler.handleResponse("ERROR",HttpStatus.BAD_REQUEST,e.getMessage());
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
    public ResponseEntity<Object> findProducts(@RequestParam int page,@RequestParam String name){
        try {
            Page<Product> products = productService.findProductsByName(name, page);
            return ResponseHandler.handleResponse("Successfully find products", HttpStatus.OK,products);
        }catch (Exception e){
            return ResponseHandler.handleResponse("ERROR", HttpStatus.BAD_REQUEST,e.getMessage());
        }
    }

    @GetMapping("/sort/price")
    public ResponseEntity<Object> sortProductsByPrice(@RequestParam int page,@RequestParam String type){
        try {
            Page<Product> products;
            if(Objects.equals(type, "asc")){
                products = productService.getProductsOrderByPriceAsc(page);
            }else if (Objects.equals(type, "desc")){
                products = productService.getProductsOrderByPriceDesc(page);
            }else{
                return ResponseHandler.handleResponse("Wrong Type Parameter", HttpStatus.BAD_REQUEST,null);
            }
            return ResponseHandler.handleResponse("Successfully sort products", HttpStatus.OK,products);
        }catch (Exception e){
            return ResponseHandler.handleResponse("ERROR", HttpStatus.BAD_REQUEST,e.getMessage());
        }
    }
}
