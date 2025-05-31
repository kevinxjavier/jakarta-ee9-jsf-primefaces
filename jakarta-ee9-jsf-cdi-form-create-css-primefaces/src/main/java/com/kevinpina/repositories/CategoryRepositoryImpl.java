package com.kevinpina.repositories;

import com.kevinpina.entities.Category;
import jakarta.enterprise.context.RequestScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;

import java.util.List;

@RequestScoped
public class CategoryRepositoryImpl implements CrudRepository<Category> {

    @Inject
    private EntityManager entityManager;

    @Override
    public List<Category> list() {
        return entityManager.createQuery("select c from Category c", Category.class).getResultList();
    }

    @Override
    public Category findBy(Long id) {
        return entityManager.find(Category.class, id);
    }

    @Override
    public void save(Category category) {
        if (category.getId() != null && category.getId() > 0) {
            entityManager.merge(category);
        } else {
            entityManager.persist(category);
        }
    }

    @Override
    public void delete(Long id) {
        entityManager.remove(findBy(id));
    }
}
