package com.example.demo.controller;


import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.UserStu;
import com.example.demo.mapper.UserMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.sql.ResultSet;
import java.sql.Wrapper;

@RestController
@RequestMapping("/user")
public class UserController {

    @Resource
    UserMapper userMapper;

    @GetMapping("/hello")
    public String hello() {
        return "Hello!";
    }

    @RequestMapping("/save")
    @PostMapping
    public Result<?> save(@RequestBody UserStu user){
        if (user.getPassword() == null) {
            user.setPassword("123456");
        }
        userMapper.insert(user);
        return Result.success();
    }

    @PutMapping
    public Result<?> update(@RequestBody UserStu user){
        if (user.getPassword() == null) {
            user.setPassword("123456");
        }
        userMapper.updateById(user);
        return Result.success();
    }

    // @GetMapping
    // public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
    //                           @RequestParam(defaultValue = "10") Integer pageSize,
    //                           @RequestParam(defaultValue = "") String search) {
    //     LambdaQueryWrapper<UserStu> wrapper = Wrappers.<UserStu>lambdaQuery();
    //     if (StrUtil.isNotBlank(search)) {
    //         wrapper.like(UserStu::getName, search);
    //     }
    //     Page<UserStu> userPage = userMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
    //     return Result.success(userPage);
    // }

}
