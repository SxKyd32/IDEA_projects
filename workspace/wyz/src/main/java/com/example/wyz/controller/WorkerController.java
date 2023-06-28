package com.example.wyz.controller;

import com.example.wyz.pojo.Worker;
import com.example.wyz.service.PosNameService;
import com.example.wyz.service.WorkerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class WorkerController {
    @Autowired
    WorkerService workerService;
    @Autowired
    PosNameService posNameService;
    @CrossOrigin
    @PostMapping("/api/worker/add")
    public Worker add_Worker(@RequestBody @Valid Worker worker){
        return workerService.save(worker);
    }

    @CrossOrigin
    @GetMapping("/api/worker/delete/{id}")
    public void delete_Worker(@PathVariable("id") int id){
        workerService.deleteById(id);
    }
    @CrossOrigin
    @PostMapping("/api/worker/edit")
    public Worker edit_Worker(@RequestBody @Valid Worker worker){
        return workerService.save(worker);
    }
    @CrossOrigin
    @GetMapping("/api/workers")
    @ResponseBody
    public List<Map<String,Object>> all_Worker(){
        String posName="";
        List<Map<String,Object>> result = new ArrayList<>();
        List<Worker> workers = workerService.findAll();
        for(Worker worker:workers){
            posName = posNameService.findById(worker.getPos()).getName();
            Map map = new HashMap();
            map.put("posName",posName);
            map.put("worker",worker);
            result.add(map);
        }
        return result;
    }
}
