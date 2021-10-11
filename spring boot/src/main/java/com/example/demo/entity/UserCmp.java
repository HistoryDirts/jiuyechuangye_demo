package com.example.demo.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserCmp {
    private Integer id;
    private Integer number;
    private String name;
    private String business;
    private String linkman;
    private String profile;
}
