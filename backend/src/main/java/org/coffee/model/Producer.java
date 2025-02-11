package org.coffee.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "producers")
@Getter
@Setter
public class Producer {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id_producer", columnDefinition = "CHAR(36)", updatable = false, nullable = false)
    private UUID idProducer;

    @Column(nullable = false, length = 255)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    @ManyToOne
    @JoinColumn(name = "location", referencedColumnName = "id_province", nullable = true)
    private Province location;

    @Column(columnDefinition = "TEXT")
    private String image;

    @Column(nullable = false, unique = true, length = 255)
    private String email;

    @Column(length = 20)
    private String phone;

    @Column(nullable = false)
    private Boolean status = true;

    @Column(name = "registration_date", nullable = false, updatable = false)
    private LocalDateTime registrationDate;

}
