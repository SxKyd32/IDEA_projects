package com.xiaohe.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

/**
 * 功能描述
 *
 * @author 和振斌
 * @date 2020/8/31
 * @return
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class User {

    private String id;

    private String username;

    private String realname;

    private String password;

    private String sex;

    private String status;

    private Date registerTime;
}
