package com.xiaohe.dao;

import com.xiaohe.entity.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserDao {
    void save(User user);

    /**根据用户名查询用户是否存在*/
    User findUserByName(String username);
}
