package com.example.demo.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;

/**
    对应数据库中的user_stu表
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class UserStu {
    private Integer id;
    private Integer number;
    private String name;
    private String majorName;
    private String specialty;
    private String hobby;
}

