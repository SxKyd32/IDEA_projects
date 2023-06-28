package com.xiaohe.service;

import com.xiaohe.dao.UserDao;
import com.xiaohe.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * 功能描述
 *
 * @author 和振斌
 * @date 2020/8/31
 * @return
 */
@Service
@Transactional//事务
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;
    /**
     * 用户注册
     * */
    @Override
    public void register(User user) {

        //1生成用户状态
        user.setStatus("已激活");
        user.setRegisterTime(new Date());
        userDao.save(user);
    }

    /**
     * 根据用户名查询用户是否存在
     * */
    @Override
    public User findUserByName(String username) {
        return userDao.findUserByName(username);
    }

    /**
     * 用户登录
     * */
    @Override
    public User login(User user) {
        //根据用户名进行查询
        User userDB = userDao.findUserByName(user.getUsername());
        if(userDB!=null){

            //比较密码是否相同
            if(user.getPassword().equals(userDB.getPassword())){
                //相同,登录成功
                  return userDB;
            }else {
                throw new RuntimeException("密码输入不正确");
            }

        }else {
            throw new RuntimeException("该用户不存在");
        }

    }
}
