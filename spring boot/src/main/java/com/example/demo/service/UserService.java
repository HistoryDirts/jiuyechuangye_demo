package com.example.demo.service;
import com.example.demo.entity.*;

import java.util.List;


public interface UserService {
    User selectById(Integer id);

    User login(User user);

    List<User> findAll();

    User selectByName(String name);

    void insert(User user);

    void insertToStudent(UserStu userStu);

    void insertToIdentity(User_Identity user_identity);

    void insertToTeacher(UserTch userTch);

    void insertToCompany(UserCmp userCmp);

    void insertToOther(UserOther userOther);
}
