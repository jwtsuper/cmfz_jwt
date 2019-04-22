package com.baizhi.service;

import com.baizhi.entity.Banner;

import java.util.Map;

public interface BannerService {
    public Map select(int page, int rows);

    public void insert(Banner banner);

    public void delete(int id);

    public void update(Banner banner);
}
