package com.example.demo.service.impl;

import com.demo.entity.*;
import com.example.demo.entity.*;
import com.example.demo.mapper.UserMapper;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User selectById(Integer id) {
        return userMapper.selectById(id);
    }

    @Override
    public User login(User user) {
        return userMapper.login(user);
    }

    @Override
    public List<User> findAll() {
        return userMapper.findAll();
    }

    @Override
    public User selectByName(String name) {
        return userMapper.selectByName(name);
    }

    @Override
    public void insert(User user) {
        userMapper.insert(user);
    }

    @Override
    public void insertToStudent(UserStu userStu) {
        userMapper.insertToStudent(userStu);
    }

    @Override
    public void insertToIdentity(User_Identity userIdentity) {
        userMapper.insertToIdentity(userIdentity);
    }

    @Override
    public void insertToTeacher(UserTch userTch) {
        userMapper.insertToTeacher(userTch);
    }

    @Override
    public void insertToCompany(UserCmp userCmp) {
        userMapper.insertToCompany(userCmp);
    }

    @Override
    public void insertToOther(UserOther userOther) {
        userMapper.insertToOther(userOther);
    }


}
