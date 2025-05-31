package com.kevinpina.converters;

import com.kevinpina.entities.Category;
import com.kevinpina.services.ProductService;
import jakarta.enterprise.context.RequestScoped;
import jakarta.faces.component.UIComponent;
import jakarta.faces.context.FacesContext;
import jakarta.faces.convert.Converter;
import jakarta.inject.Inject;
import jakarta.inject.Named;

@RequestScoped
@Named("categoryConverter")
public class CategoryConverter implements Converter<Category> {

    @Inject
    private ProductService productService;

    @Override
    public Category getAsObject(FacesContext facesContext, UIComponent uiComponent, String id) {
        return (id == null) ? null : productService.getCategory(Long.valueOf(id)).orElse(null);
    }

    @Override
    public String getAsString(FacesContext facesContext, UIComponent uiComponent, Category category) {
        return (category == null) ? "0" : category.getId().toString();
    }

}
