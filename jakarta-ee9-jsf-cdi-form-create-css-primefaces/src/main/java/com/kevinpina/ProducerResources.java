package com.kevinpina;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.context.RequestScoped;
import jakarta.enterprise.inject.Produces;
import jakarta.faces.context.FacesContext;
import jakarta.inject.Named;

import java.util.Locale;
import java.util.ResourceBundle;

@ApplicationScoped
public class ProducerResources {

    @Named("forFlashMessages")
    @Produces
    @RequestScoped
    public FacesContext beanFacesContext() {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        facesContext.getExternalContext().getFlash().setKeepMessages(true); // Keep the message in the next request to be visualized in the redirect
        return facesContext;
    }

    @Named("messageMyLanguage")
    @Produces
    public ResourceBundle beanBundle() {
        Locale locale = FacesContext.getCurrentInstance().getViewRoot().getLocale();
        return ResourceBundle.getBundle("messages", locale); // File: resources/messages.properties
    }

}
