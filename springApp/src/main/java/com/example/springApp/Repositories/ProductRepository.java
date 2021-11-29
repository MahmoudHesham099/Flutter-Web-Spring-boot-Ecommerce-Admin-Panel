package com.example.springApp.Repositories;

import com.example.springApp.Entities.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {
    Page<Product> findByNameContainingIgnoreCase(String name, Pageable pageable);

    Page<Product> findAllByOrderByPriceAsc(Pageable pageable);

    Page<Product> findAllByOrderByPriceDesc(Pageable pageable);

}
