package com.baizhi.service.impl;

import com.baizhi.dao.UserDao;
import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional //控制事务
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public List<User> selectAll() {
        return userDao.selectAll();
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public Map selectActiveCount() {
        Map map = new HashMap();
        String xAxisData[] = {"一周", "两周", "三周", "四周"};
        List seriesData = new ArrayList();
        map.put("xAxisData", xAxisData);
        for (int i = 0; i <= 3; i++) {
            int count = userDao.selectActiveCount(i + 1);
            seriesData.add(count);

        }
        map.put("seriesData", seriesData);
        return map;
    }

    @Override
    public Map selectMale() {
        Map map = new HashMap();
        int[] male = userDao.selectMale();
        map.put("male", male);
        return map;
    }

    @Override
    public Map selectFeMale() {
        Map map = new HashMap();
        int[] feMale = userDao.selectFeMale();
        map.put("female", feMale);
        return map;
    }
}
