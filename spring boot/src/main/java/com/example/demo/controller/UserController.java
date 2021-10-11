package com.example.demo.controller;


import com.example.demo.common.ResponseResult;
import com.example.demo.entity.*;
import com.example.demo.service.UserService;
import com.example.demo.utils.TokenUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 根据用户名密码进行登录校验
     * @param user
     * @return
     */
    @PostMapping("/login")
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseResult login(@RequestBody User user) {
        User loginUser = userService.login(user);
        Map<String, Object> map = null;
        if (loginUser != null) {
            //生成token
            String token = TokenUtils.genToken(loginUser);
            map = new HashMap<>();
            map.put("token", token);
        }else {
            return new ResponseResult(100, "用户名与密码不匹配", null);
        }

        return new ResponseResult(200, "登录成功", map);
    }

    /**
     * 用户注册接口
     * @param user
     * @return
     */
    @PostMapping("/register")
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseResult register(@RequestBody User user) {
        User res = userService.selectByName(user.getName());
        if (res != null) {
            return new ResponseResult(-1, "用户名重复");
        }
        if (user.getPassword() == null) {
            user.setPassword("123456");
        }
        //将用户信息插入用户主表
        userService.insert(user);
        //插入各自身份对应的表
        user.setId(userService.selectByName(user.getName()).getId());

        switch (user.getIdentity()) {
            case("student"):
                userService.insertToStudent(new UserStu(user.getId(),user.getNumber(),
                        user.getName(),"nothing","nothing","nothing"));
                userService.insertToIdentity(new User_Identity(user.getId(), Identity.STUDENT_TYPE_ID));
                break;
            case("teacher"):
                userService.insertToTeacher(new UserTch(user.getId(),user.getNumber(),
                        user.getName(),"nothing","nothing","nothing"));
                userService.insertToIdentity(new User_Identity(user.getId(), Identity.TEACHER_TYPE_ID));
                break;
            case("company"):
                userService.insertToCompany(new UserCmp(user.getId(),user.getNumber(),
                        user.getName(),"nothing","nothing","nothing"));
                userService.insertToIdentity(new User_Identity(user.getId(), Identity.COMPANY_TYPE_ID));
                break;
            case("other"):
                userService.insertToOther(new UserOther(user.getId(),user.getNumber(),
                        user.getName(),"nothing","nothing","nothing"));
                userService.insertToIdentity(new User_Identity(user.getId(), Identity.OTHER_TYPE_ID));
                break;
            default:
                return new ResponseResult(-1, "缺少用户身份信息", null);
        }

        //生成token
        Map<String, Object> map = null;
        map = new HashMap<>();
        String token = TokenUtils.genToken(user);
        map.put("token", token);

        return new ResponseResult(200, "注册成功", map);
    }

}
