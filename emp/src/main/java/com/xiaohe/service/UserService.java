package com.xiaohe.service;

import com.xiaohe.entity.User;

/**
 * 功能描述
 *
 * @author 和振斌
 * @date 2020/8/31
 * @return
 */
public interface UserService {
    void register(User user);

    //根据用户名查询用户是否存在
    User findUserByName(String username);

    User login(User user);
}
