package com.xiaohe.service;

import com.xiaohe.entity.Emp;

import java.util.List;

public interface EmpService {
    /**
     * 查询所有员工
     * */
    List<Emp> findAll();

    void save(Emp emp);

    void delete(String id);

    Emp findOne(String id);

    void update(Emp emp);
}
