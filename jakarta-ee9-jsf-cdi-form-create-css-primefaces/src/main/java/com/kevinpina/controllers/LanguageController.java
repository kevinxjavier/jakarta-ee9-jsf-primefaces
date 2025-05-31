package com.kevinpina.controllers;

import jakarta.annotation.PostConstruct;
import jakarta.enterprise.context.SessionScoped;
import jakarta.faces.context.FacesContext;
import jakarta.faces.event.ValueChangeEvent;
import jakarta.inject.Named;
import lombok.Getter;
import lombok.Setter;

import java.io.Serial;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

@Getter
@Setter
@Named
@SessionScoped
public class LanguageController implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    private Locale locale;
    private String language;
    private Map<String, String> supportedLanguages;

    @PostConstruct
    public void init() {
        locale = FacesContext.getCurrentInstance().getViewRoot().getLocale();
        supportedLanguages = new HashMap<>();
        supportedLanguages.put("English", "en");
        supportedLanguages.put("Español", "es");
        supportedLanguages.put("Deutsch", "de");
    }

    public void selectLanguage(ValueChangeEvent event) {
        String newLanguage = event.getNewValue().toString();
        supportedLanguages.values().forEach(value -> {
            if (value.equals(newLanguage)) {
                this.locale = new Locale(value); // value will be "es = resources/message_es.properties", etc...
                FacesContext.getCurrentInstance().getViewRoot().setLocale(this.locale);
            }
        });
    }

}
