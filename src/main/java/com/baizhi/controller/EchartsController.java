package com.baizhi.controller;

import com.baizhi.service.UserDTOService;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("echarts")
public class EchartsController {

    @Autowired
    private UserService userService;
    @Autowired
    private UserDTOService service;

    @RequestMapping("userActive")
    public Map count() {

        return userService.selectActiveCount();
    }

    @RequestMapping("male")
    public Map male() {
        return service.selectMale();
    }

    @RequestMapping("female")
    public Map female() {
        return service.selectFeMale();
    }
}
