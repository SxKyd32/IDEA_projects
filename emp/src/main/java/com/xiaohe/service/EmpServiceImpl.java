package com.xiaohe.service;

import com.xiaohe.dao.EmpDao;
import com.xiaohe.entity.Emp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 功能描述
 **/
@Service
@Transactional
public class EmpServiceImpl implements EmpService {

    @Autowired
    private EmpDao empDao;
    /**
     * 查询所有员工
     * */
    @Override
    public List<Emp> findAll() {
        return empDao.findAll();
    }

    @Override
    public void save(Emp emp) {
        empDao.save(emp);
    }

    @Override
    public void delete(String id) {
       empDao.delete(id);
    }

    @Override
    public Emp findOne(String id) {
        return empDao.findOne(id);
    }

    @Override
    public void update(Emp emp) {
        empDao.update(emp);
    }
}
