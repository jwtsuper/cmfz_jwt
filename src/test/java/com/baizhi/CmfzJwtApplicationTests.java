package com.baizhi;

import com.baizhi.dao.AlbumDao;
import com.baizhi.dao.BannerDao;
import com.baizhi.dao.MenuDao;
import com.baizhi.dao.UserDao;
import com.baizhi.entity.Album;
import com.baizhi.entity.Banner;
import com.baizhi.entity.Menu;
import com.baizhi.service.MenuService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class CmfzJwtApplicationTests {
    @Autowired
    private UserDao userDao;
    @Autowired
    private MenuService menuService;
    @Autowired
    private MenuDao menuDao;
    @Autowired
    private BannerDao bannerDao;
    @Autowired
    private AlbumDao albumDao;

    @Test
    public void contextLoads() {
        /*PageHelper.startPage(1,2);
        PageInfo<User> pageInfo=new PageInfo<>(userDao.selectAll());
        List<User> list=pageInfo.getList();
        for (User user : list) {
            System.out.println(user);
        }*/
       /* List<User> users = userDao.selectAllBanner();
        for (User user : users) {
            System.out.println(user);
        }*/
    }

    @Test
    public void test2() {
        List<Menu> list = menuDao.selectAllMenu();
        for (Menu menu : list) {
            System.out.println(menu);
        }

    }

    @Test
    public void test3() {
        List<Banner> banners = bannerDao.selectAll();
        for (Banner banner : banners) {
            System.out.println(banner);
        }
    }

    @Test
    public void test4() {
        List<Album> list = albumDao.selectAllAlbum();
        for (Album album : list) {
            System.out.println(album);
        }
    }

   /* @Test
    public void test5() {
        int i = userDao.selectActiveCount();
        System.out.println(i);
    }*/
}
