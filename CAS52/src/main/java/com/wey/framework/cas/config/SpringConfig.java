package com.wey.framework.cas.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

/**
 * 将此类添加到配置的信息里面去(spring.factories)
 * @author weisunqing
 *
 */
@Configuration
@ComponentScan("com.wey.framework.cas")
@MapperScan("com.wey.framework.cas.mapper")
public class SpringConfig {
    
}
