package com.example.wyz.service;

import com.example.wyz.dao.PosNameDAO;
import com.example.wyz.pojo.PosName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PosNameService {
    @Autowired
    PosNameDAO posNameDAO;
    public PosName findById(int id){return posNameDAO.findById(id);}
}
