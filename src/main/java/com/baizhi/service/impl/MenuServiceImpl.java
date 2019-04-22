package com.baizhi.service.impl;

import com.baizhi.dao.MenuDao;
import com.baizhi.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("menuService")
@Transactional
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuDao menuDao;

    @Override
    public List select() {


        return menuDao.selectAllMenu();
    }
}
