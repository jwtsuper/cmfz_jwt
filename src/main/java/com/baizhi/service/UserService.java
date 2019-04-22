package com.baizhi.service;

import com.baizhi.entity.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    List<User> selectAll();

    void insert(User user);

    Map selectActiveCount();

    Map selectMale();

    Map selectFeMale();
}
