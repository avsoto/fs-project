package org.coffee.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "provinces")
@Getter
@Setter
public class Province {

    @Id
    @Column(name = "id_province", columnDefinition = "CHAR(36)")
    private String idProvince;

    @Column(nullable = false, length = 255)
    private String name;

}
