package com.xiaohe;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.StringRedisTemplate;

@SpringBootTest
class EmsApplicationTests {

    @Autowired
    private StringRedisTemplate redisTemplate;



    @Test
    void contextLoads() {
        redisTemplate.opsForValue().set("name","zhangsan");
    }

}
