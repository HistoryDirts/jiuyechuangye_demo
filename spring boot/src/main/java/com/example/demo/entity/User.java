package com.example.demo.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private Integer id;
    private String name;
    private String password;
    private Integer number; //学号/工号
    private Integer level;  //用户等级
    private Integer score;  //用户积分
    private Integer exp;    //用户经验值
    private String intro;   //用户简介
    private String nationality;//国籍
    private String headPath;//头像路径
    private String identity;//用户身份
}
