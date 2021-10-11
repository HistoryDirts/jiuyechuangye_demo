package com.example.demo.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserTch {
    private Integer id;
    private Integer number;
    private String name;
    private String guidance;
    private String specialty;
    private String hobby;
}
