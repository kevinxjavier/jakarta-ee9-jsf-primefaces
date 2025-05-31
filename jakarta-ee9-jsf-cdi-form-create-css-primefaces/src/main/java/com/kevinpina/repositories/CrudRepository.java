package com.kevinpina.repositories;

import java.util.List;

public interface CrudRepository <T> {

    List<T> list();
    T findBy(Long id);
    void save(T t);
    void delete(Long id);

}
