package com.xiaohe.controller;

import com.xiaohe.entity.User;
import com.xiaohe.service.UserService;
import com.xiaohe.utils.R;
import com.xiaohe.utils.VerifyCodeUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 功能描述
 *
 * @author 和振斌
 * @date 2020/8/31
 * @return
 */
@RestController
@RequestMapping(value = "user")
@CrossOrigin
@Slf4j
public class UserController {

    @Autowired
    private UserService userService;


    /**
     * 用户登录
     * */
    @PostMapping("login")
    public R login(@RequestBody User user){
        try {
            User userDB = userService.login(user);
            return R.ok().data("status",true).data("msg","登录成功").data("userDb",userDB);
        } catch (Exception e) {
            e.printStackTrace();
            return R.error().data("status",false).data("msg",e.getMessage());
        }

    }



    /**
    * 生成验证码
     * */
    @GetMapping(value = "getImage")
    public String getImageCode(HttpServletRequest request) throws IOException {
        //使用工具类生成验证码
        String code = VerifyCodeUtils.generateVerifyCode(4);
        //将生成的验证码放入到servletContext作用域
        request.getServletContext().setAttribute("code",code);

        //将图片转为base64
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        VerifyCodeUtils.outputImage(100,30,byteArrayOutputStream,code);
        String s = "data:image/png;base64,"+Base64Utils.encodeToString(byteArrayOutputStream.toByteArray());

        return s;
    }

    /**
     * 用户注册
     * */
    @PostMapping(value = "register")
   public Map<String,Object>  register(@RequestBody User user,
                                       HttpServletRequest request,
                                       String code){
        Map<String,Object> map=new HashMap<>();
        try {
            //判断验证码输入是否正确
            String key = (String) request.getServletContext().getAttribute("code");
            if(key.equalsIgnoreCase(code)){
                //根据用户名判断该用户是否存在
                User userList=userService.findUserByName(user.getUsername());
                if(userList !=null){
                    map.put("state", false);
                    map.put("msg", "该用户已存在");
                }else{
                    userService.register(user);
                    map.put("state", true);
                    map.put("msg", "提示: 注册成功!");

                }

            }else{
                throw  new RuntimeException("验证码错误");
            }

        } catch (Exception e) {
            e.printStackTrace();
            map.put("state", false);
            map.put("msg", "提示: 注册失败!");
        }
        System.out.println(map);
       return map;
    }

}
