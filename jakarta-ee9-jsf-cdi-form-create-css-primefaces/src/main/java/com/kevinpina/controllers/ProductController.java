package com.kevinpina.controllers;

import com.kevinpina.ProducerResources;
import com.kevinpina.entities.Category;
import com.kevinpina.entities.Product;
import com.kevinpina.services.ProductService;
import jakarta.enterprise.context.RequestScoped;
import jakarta.enterprise.inject.Model;
import jakarta.enterprise.inject.Produces;
import jakarta.faces.application.FacesMessage;
import jakarta.faces.context.FacesContext;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

import java.util.List;
import java.util.ResourceBundle;

//@Named("productController") // The name value by the default is the name of the class
//@RequestScoped
@Model // @Model resume the use of @Name "by default the name of class" and @RequestScope
       // in this case in webapp/form.xhtml <h:commandButton value="Create" action="#{productController.save}" /> ...
@Slf4j
public class ProductController {

    //private static Logger logger = LoggerFactory.getLogger(ProductController.class);

    private Product product;

    @Getter
    @Setter
    private Long id;

    @Inject
    private ProductService productService;

    @Inject
    @Named("forFlashMessages")
    private FacesContext beanFacesContext;

    @Inject
    @Named("messageMyLanguage")
    private ResourceBundle beanBundle;

    @Inject
    private ProducerResources producerResources;

    @Produces // Registering in CDI to be retrieving from the view .xhtml
    @Model // @Model resume the use of @RequestScope and @Name "by default the name of method (without get or set prefix)"
    public String title() {
        // return "Index JakartaEE10 JSF - Title";
        return beanBundle.getString("product.text.title");
    }

    @Produces // Registering in CDI to be retrive from the view .xhtml
    @Named("h1")
    @RequestScoped
    public String header1() {
        return "Index JakartaEE10 JSF - Header1";
    }

    @Produces
    @Named("productList")
    @RequestScoped
    public List<Product> getProducts() {
        // return Stream.of(new Product("Apple"), new Product("Orange"), new Product("Lemon")).toList();

        List<Product> products = productService.listProducts();

        log.info("--- Total Size: {}", products.size());
        products.forEach(p -> log.info(p.getName()));

        return products;
    }

    @Produces // Registering in CDI to be retrive from the view
    @Model // @Model resume the use of @Name "by default the name of method" and @RequestScope
           // in this case in webapp/form.xhtml <h:inputText id="name" value="#{product.name}" /> ...
    public Product product() {
        product = new Product();
        if (id != null && id > 0) {
            // product = productService.getProduct(id).orElseThrow();
            productService.getProduct(id).ifPresent(p -> product = p);
        }
        return product;
    }

    @Produces
    @Model
    public List<Category> getCategories() {
        return productService.listCategories();
    }

    public String save() {
        log.info("--- {}", product);
        productService.save(product);

        if (product.getId() != null && product.getId() > 0) {
            // beanFacesContext.addMessage(null, new FacesMessage("Product Saved " + product.getName())); // By Default FacesMessage.SEVERITY_INFO
            beanFacesContext.addMessage(null, new FacesMessage(String.format(beanBundle.getString("product.text.saved"), product.getName()))); // By Default FacesMessage.SEVERITY_INFO
        } else {
            // beanFacesContext.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "Product Created " + product.getName(), ""));
            beanFacesContext.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, String.format(producerResources.beanBundle().getString("product.text.created"), product.getName()), ""));
        }
        return "index.xhtml?faces-redirect=true";
    }

    public String edit(Long id) {
        this.id = id;
        return "form.xhtml";
    }

    public String delete(Product product) {
        productService.delete(product.getId());
        // beanFacesContext.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Product Deleted " + product.getName(), ""));
        beanFacesContext.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, String.format(beanBundle.getString("product.text.deleted"), product.getName()), ""));
        return "index.xhtml?faces-redirect=true";
    }

}
