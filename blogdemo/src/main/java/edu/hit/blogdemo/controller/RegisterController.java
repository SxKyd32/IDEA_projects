package edu.hit.blogdemo.controller;

import edu.hit.blogdemo.pojo.User;
import edu.hit.blogdemo.result.Result;
import edu.hit.blogdemo.result.ResultFactory;
import edu.hit.blogdemo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLIntegrityConstraintViolationException;

@RestController
public class RegisterController {

    @Autowired
    UserService userService;

    @CrossOrigin
    @GetMapping("api/searchuser")
    //搜索所有用户信息
    public Result searchUser() {
        return ResultFactory.buildSuccessResult(userService.searchAllUser());
    }

    //新增或更新经纪人信息
    @CrossOrigin
    @PostMapping("api/userregister")
    @ResponseBody
    public User addUser(@RequestBody User user) throws SQLIntegrityConstraintViolationException{
        System.out.println("the result is:"+user.getUserPhone());
        System.out.println("the result is:"+user.getUserPassword());
        try {
            userService.addOrUpdate(user);
        }catch(SQLIntegrityConstraintViolationException e){
            System.out.println("用户名重复！");
        }
        return user;
    }
}
