package com.kevinpina.repositories;

import com.kevinpina.entities.Product;
import jakarta.enterprise.context.RequestScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;

import java.util.List;

@RequestScoped
public class ProductRepositoryImpl implements ProductRepository {

    @Inject
    private EntityManager entityManager;

    @Override
    public List<Product> list() {
        //String sql = "SELECT p FROM Product p";
        String sql = "SELECT p FROM Product p LEFT OUTER JOIN FETCH p.category";
        return entityManager.createQuery(sql, Product.class).getResultList();
    }

    @Override
    public Product findBy(Long id) {
        //return entityManager.find(Product.class, id);
        return entityManager.createQuery("SELECT p FROM Product p LEFT OUTER JOIN FETCH p.category WHERE p.id = :id", Product.class)
                .setParameter("id", id)
                .getSingleResult();
    }

    @Override
    public void save(Product product) {
        if (product.getId() != null && product.getId() > 0) {
            entityManager.merge(product);
        } else {
            entityManager.persist(product);
        }
    }

    @Override
    public void delete(Long id) {
        Product product = findBy(id);
        entityManager.remove(product);
    }

    @Override
    public List<Product> searchByName(String name) {
        //String sql = "SELECT p FROM Product p";
        String sql = "SELECT p FROM Product p LEFT OUTER JOIN FETCH p.category WHERE p.name LIKE :name";
        return entityManager.createQuery(sql, Product.class)
                .setParameter("name", "%" + name + "%")
                .getResultList();
    }
}
