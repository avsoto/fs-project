package org.coffee.dto.response;

import lombok.Getter;
import lombok.Setter;
import org.coffee.model.Province;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
public class ProducerResponseDTO {
    private UUID idProducer;
    private String name;
    private String description;
    private String image;
    private String email;
    private String phone;
    private Boolean status;
    private LocalDateTime registrationDate;
    private Province province;
}
