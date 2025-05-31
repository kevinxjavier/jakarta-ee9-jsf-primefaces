package com.kevinpina;

import jakarta.enterprise.context.RequestScoped;
import jakarta.enterprise.inject.Produces;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@RequestScoped
public class ProducerEntityManager {

    @PersistenceContext(name = "exampleJPA")
    private EntityManager entityManager;

    @Produces
    @RequestScoped
    private EntityManager beanEntityManager() {
        return entityManager;
    }

}