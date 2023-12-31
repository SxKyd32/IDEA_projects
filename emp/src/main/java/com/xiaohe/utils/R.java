package com.xiaohe.utils;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

/**
 * 功能描述
 *统一返回结果
 * @author 和振斌
 * @date 2020/8/3
 * @return
 */
@Data
public class R {

    private Boolean success;


    private Integer code;


   private String message;

    private Map<String, Object> data = new HashMap<String, Object>();

   //构造方法私有化
    private R(){}

    //成功的静态方法

    public static R ok(){
        R r=new R();
        r.setSuccess(true);
        r.setCode(ResultCode.SUCCESS);
        r.setMessage("成功");
        return r;
    }

    //失败的静态方法

    public static R error(){
        R r=new R();
        r.setSuccess(true);
        r.setCode(ResultCode.ERROR);
        r.setMessage("失败");
        return r;
    }
    public R success(Boolean success){
        this.setSuccess(success);
        return this;
    }

    public R message(String message){
        this.setMessage(message);
        return this;
    }

    public R code(Integer code){
        this.setCode(code);
        return this;
    }

    public R data(String key, Object value){
        this.data.put(key, value);
        return this;
    }
    public R data(Map<String, Object> map){
        this.setData(map);
        return this;
    }





}
