package com.baizhi.controller;

import com.baizhi.entity.Banner;
import com.baizhi.service.BannerService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("banner")
public class BannerController {

    @Autowired
    private BannerService bannerService;

    @RequestMapping("select")
    @ResponseBody
    public Map select(int page, int rows) {
        return bannerService.select(page, rows);
    }

    @RequestMapping("insert")
    @ResponseBody
    public Map insert(Banner banner, MultipartFile addBanner, HttpSession session) throws IOException {
        //获取文件上传目录
        //此时在webapp目录下
        String realPath = session.getServletContext().getRealPath("/");

        String dir = realPath + "banner";
        File file = new File(dir);
        if (!file.exists()) {
            file.mkdir();
        }
        //重命名
        String originalFilename = addBanner.getOriginalFilename();
        //extension是后缀名
        String extension = FilenameUtils.getExtension(originalFilename);
        String newName = UUID.randomUUID().toString();
        newName = newName + "." + extension;
        //上传
        File file1 = null;
        try {
            file1 = new File(dir, newName);
            addBanner.transferTo(file1);
        } catch (IOException e) {
            e.printStackTrace();
        }
        banner.setImgPath(newName);
        Map map = new HashMap();
        bannerService.insert(banner);
        map.put("flag", true);
        return map;
    }

    @RequestMapping("delete")
    @ResponseBody
    public Map delete(int id) {
        Map map = new HashMap();
        System.out.println(id);
        bannerService.delete(id);
        map.put("flag", true);
        return map;
    }


    @RequestMapping("update")
    @ResponseBody
    public Map update(Banner banner) {
        Map map = new HashMap();
        System.out.println(banner);
        bannerService.update(banner);
        return map;
    }
}
