package com.example.wyz.service;

import com.example.wyz.dao.WorkerDAO;
import com.example.wyz.pojo.Worker;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WorkerService {
    @Autowired
    WorkerDAO workerDAO;
    public Worker save(Worker worker){return workerDAO.save(worker);}
    public void deleteById(int id){workerDAO.deleteById(id);}
    public List<Worker> findAll(){return workerDAO.findAll();}
}
