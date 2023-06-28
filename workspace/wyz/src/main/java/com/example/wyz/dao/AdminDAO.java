package com.example.wyz.dao;

import com.example.wyz.pojo.Admin;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AdminDAO extends JpaRepository<Admin,Integer> {
    Admin findByName(String name);
}
