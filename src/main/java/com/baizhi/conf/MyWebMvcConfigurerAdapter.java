package com.baizhi.conf;

import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;


public class MyWebMvcConfigurerAdapter extends WebMvcConfigurerAdapter {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        /**
         * 资源映射路径
         * addResourceHandler：访问映射路径
         * addResourceLocations：资源绝对路径
         */
        registry.addResourceHandler("/服务器/**").addResourceLocations("/file:E:/服务器/");
    }

}
