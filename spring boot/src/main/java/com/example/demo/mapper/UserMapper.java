package com.example.demo.mapper;

import com.demo.entity.*;
import com.example.demo.entity.*;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface UserMapper{

    User login(User user);
    public List<User> findAll();

    User selectByName(String name);

    User selectById(Integer id);

    void insert(User user);

    void insertToStudent(UserStu userStu);

    void insertToIdentity(User_Identity user_identity);

    void insertToTeacher(UserTch userTch);

    void insertToCompany(UserCmp userCmp);

    void insertToOther(UserOther userOther);
}
