package org.coffee.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "products")
@Getter
@Setter
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id_product", columnDefinition = "CHAR(36)", updatable = false, nullable = false)
    private UUID idProduct;

    @Column(nullable = false, length = 255)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal price;

    @Column(columnDefinition = "TEXT")
    private String image;

    @Column(nullable = false)
    private int stock = 0;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal weight;

    @Column(columnDefinition = "TEXT")
    private String certifications;

    @Column(name = "creation_date", nullable = false, updatable = false)
    private LocalDateTime creationDate;

    @ManyToOne
    @JoinColumn(name = "id_producer", referencedColumnName = "id_producer", foreignKey = @ForeignKey(name = "FK_product_producer"))
    private Producer producer;

    @ManyToOne
    @JoinColumn(name = "id_coffee_type", referencedColumnName = "id_coffee_type", foreignKey = @ForeignKey(name = "FK_product_coffee_type"))
    private CoffeeType coffeeType;

}
