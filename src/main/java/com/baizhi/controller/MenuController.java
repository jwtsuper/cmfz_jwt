package com.baizhi.controller;

import com.baizhi.entity.Menu;
import com.baizhi.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @RequestMapping("select")
    @ResponseBody
    public List<Menu> select(HttpSession session) {
        Map map = new HashMap();
        List<Menu> list = menuService.select();
        map.put("list", list);
        return list;
    }
}
