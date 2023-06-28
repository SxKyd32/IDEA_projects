package com.example.wyz.dao;

import com.example.wyz.pojo.PosName;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PosNameDAO extends JpaRepository<PosName,Integer> {
    PosName findById(int id);
}