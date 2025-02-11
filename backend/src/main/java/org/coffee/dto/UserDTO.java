package org.coffee.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.coffee.model.Province;

import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO {
    private UUID idProducer;
    private String name;
    private String description;
    private String image;
    private String email;
    private String phone;
    private Province location;
}
