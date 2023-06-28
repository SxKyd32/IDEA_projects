package com.example.wyz.service;

import com.example.wyz.dao.AdminDAO;
import com.example.wyz.pojo.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {
    @Autowired
    AdminDAO adminDAO;
    public Admin findByName(String name){return adminDAO.findByName(name);}
}
