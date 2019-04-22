package com.baizhi.service.impl;

import com.baizhi.dao.BannerDao;
import com.baizhi.entity.Banner;
import com.baizhi.service.BannerService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("bannerService")
@Transactional
public class BannerServiceImpl implements BannerService {
    @Autowired
    private BannerDao bannerDao;

    @Override
    public Map select(int page, int rows) {
        Map map = new HashMap();
        /*参数的page代表 控件发来的页数 rows 代表每一页显示多少条*/
        PageHelper.startPage(page, rows);
        PageInfo<Banner> pageInfo = new PageInfo<>(bannerDao.selectAll());
        /*接收的数据 和总条数需要返回存在map中*/
        /*list 查询的数据*/
        List<Banner> list = pageInfo.getList();
        for (Banner banner : list) {
            System.out.println(banner);
        }
        /*查询的总条数*/
        long count = pageInfo.getTotal();
        /*需要存在map key必须是 rows total 分别存储数据和总条数*/
        map.put("rows", list);
        map.put("total", count);

        return map;
    }

    @Override
    public void insert(Banner banner) {
        bannerDao.insert(banner);

    }

    @Override
    public void delete(int id) {
        bannerDao.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Banner banner) {
        bannerDao.updateByPrimaryKey(banner);

    }
}
