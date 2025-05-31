package com.kevinpina.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;

import java.time.LocalDate;

@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "product") // If comment field @ManyToOne use: @Table(name = "product_test")
@Entity
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // To take action this validation in from.xhtml <h:inputText id="price" delete required="true" if not required has more priority
    @NotNull(message = "No puede estar vacio")   // For Numeric, Dates and Objects
    @Min(message = "No puede ser menor que 5", value = 5)    // For Numeric
    @Max(1000) // For Numeric
    private Float price;

    // @Digits(integer = 3, fraction = 2)            // For BigDecimal
    // @DecimalMin(value = "1.0", inclusive = false) // For BigDecimal
    // private BigDecimal price;

    @NotEmpty                // Only for Strings
    @Size(min = 4, max = 10) // Only for Strings
    private String sku;

    // @Email                // Validate Email
    // private String email;

    @NotEmpty(message = "Debe colocar un nombre")
    private String name;

    @NotNull
    @Column(name = "date")
    private LocalDate registryDate;

    public Product(String name) {
        this.name = name;
    }

    @NotNull
    // From Product: One Product has One Category "?ToOne".
    //               One Category has Many Products "ManyToOne"
    @ManyToOne(fetch =FetchType.LAZY )
    private Category category;

    //@PrePersist   // Deactivated to not persist automatically the date
    public void prePersist() {
        registryDate = LocalDate.now();
    }

    /*@Override
    public String toString() {
        return name;
    }*/

}
