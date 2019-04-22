package com.baizhi.service.impl;

import com.baizhi.dao.UserDTODao;
import com.baizhi.entity.UserDTO;
import com.baizhi.service.UserDTOService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class UserDTOServiceImpl implements UserDTOService {
    @Autowired
    private UserDTODao userDTODao;

    @Override
    public Map selectMale() {
        List<UserDTO> male = userDTODao.selectMale();
        Map map = new HashMap();
        map.put("male", male);
        return map;
    }

    @Override
    public Map selectFeMale() {
        List<UserDTO> female = userDTODao.selectFeMale();
        Map map = new HashMap();
        map.put("female", female);
        return map;

    }
}
