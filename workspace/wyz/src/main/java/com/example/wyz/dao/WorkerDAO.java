package com.example.wyz.dao;

import com.example.wyz.pojo.Worker;
import org.springframework.data.jpa.repository.JpaRepository;

public interface WorkerDAO extends JpaRepository<Worker,Integer> {
}
