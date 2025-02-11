package org.coffee.dto.request;

import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class ProducerRequestDTO {
    private String name;
    private String description;
    private String image;
    private String email;
    private String phone;
    private Boolean status;
    private UUID locationId;
}
