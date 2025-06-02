package com.kevinpina.repositories;

import com.kevinpina.entities.Product;

import java.util.List;

public interface ProductRepository extends CrudRepository<Product> {

    List<Product> searchByName(String name);

}
