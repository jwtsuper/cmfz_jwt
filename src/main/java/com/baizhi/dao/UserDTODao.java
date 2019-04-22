package com.baizhi.dao;

import com.baizhi.entity.UserDTO;

import java.util.List;

public interface UserDTODao {
    List<UserDTO> selectMale();

    List<UserDTO> selectFeMale();
}
