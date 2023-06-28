package com.example.wyz.controller;

import com.example.wyz.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class adminController {
    @Autowired
    AdminService adminService;
    @CrossOrigin
    @GetMapping("/api/login/{name}/{password}")
    public int Login(@PathVariable("name") String name, @PathVariable("password") String password){
        int result=400;
        if(adminService.findByName(name).getPassword().equals(password))
            result=200;
        return result;
    }
}
