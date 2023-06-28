package com.xiaohe.controller;

import com.xiaohe.entity.Emp;
import com.xiaohe.service.EmpService;
import com.xiaohe.utils.R;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

/**
 * 功能描述
 **/
@RequestMapping(value = "emp")
@Slf4j
@CrossOrigin
@RestController
public class EmpController {

    @Autowired
    private EmpService empService;

    @Value("${photo.dir}")
    private String realPath;




    /**
     * 删除员工
     * */
    @DeleteMapping(value = "delete")
    public R delete(String id){
        Emp emp = empService.findOne(id);
        File file = new File(realPath, emp.getPath());
        if(file.exists())file.delete();
        empService.delete(id);
        return R.ok();
    }
    /**
     * 添加员工
     * */
    @PostMapping(value = "save")
    public R save(Emp emp, MultipartFile photo) throws IOException {
        try {
            //图像保存
            String newFileName= UUID.randomUUID().toString()+"."+ FilenameUtils.getExtension(photo.getOriginalFilename());
            photo.transferTo(new File(realPath,newFileName));
            //设置图像地址
            emp.setPath(newFileName);

            empService.save(emp);
            return R.ok().data("status",true).data("msg","添加员工成功！");
        } catch (IOException e) {
            e.printStackTrace();
            return R.error().data("status",false).data("msg","员工保存失败");
        }
    }
    @GetMapping(value = "findAll")
    public R findAll(){
        List<Emp> list = empService.findAll();
        return R.ok().data("list",list);
    }

    //查询一个员工的信息
    @GetMapping(value = "findOne")
    public R findOne(String id){
        Emp emp = empService.findOne(id);
        return R.ok().data("emp",emp);
    }
    //更新员工信息
    @PostMapping(value = "update")
    public R update(Emp emp){
        log.info(emp.toString());
        empService.update(emp);
        return R.ok().data("msg","成功");
    }
}
