package com.xiaohe.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;

/**
 * 功能描述
 *
 * @author 和振斌
 * @date 2020/9/3
 * @return
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Emp implements Serializable {
    private String id;

    private String name;

    private String path;

    private Double salary;;

    private Integer age;
}
