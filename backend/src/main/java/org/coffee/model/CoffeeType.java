package org.coffee.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Entity
@Table(name = "coffee_types")
@Getter
@Setter
public class CoffeeType {

    @Id
    @Column(name = "id_coffee_type", columnDefinition = "CHAR(36)", updatable = false, nullable = false)
    private UUID idCoffeeType;

    @Column(name = "type_name", nullable = false, unique = true, length = 50)
    private String typeName;
}
