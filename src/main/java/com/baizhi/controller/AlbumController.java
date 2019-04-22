package com.baizhi.controller;

import com.baizhi.entity.Album;
import com.baizhi.service.AlbumService;
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
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("album")
public class AlbumController {

    @Autowired
    private AlbumService albumService;

    @RequestMapping("select")
    @ResponseBody
    public List<Album> select() {
        return albumService.select();
    }

    @RequestMapping("insert")
    @ResponseBody
    public Map insert(Album album, MultipartFile add, HttpSession session) throws IOException {
        //获取文件上传目录
        //此时在webapp目录下
        String realPath = session.getServletContext().getRealPath("/");

        String dir = realPath + "album";
        File file = new File(dir);
        if (!file.exists()) {
            file.mkdir();
        }
        //重命名
        String originalFilename = add.getOriginalFilename();
        //extension是后缀名
        String extension = FilenameUtils.getExtension(originalFilename);
        String newName = UUID.randomUUID().toString();
        newName = newName + "." + extension;
        //上传
        File file1 = null;
        try {
            file1 = new File(dir, newName);
            add.transferTo(file1);
        } catch (IOException e) {
            e.printStackTrace();
        }

        String s = UUID.randomUUID().toString();
        album.setImgPath(newName);
        album.setId(s);
        Map map = new HashMap();
        System.out.println(album + "--------------------");
        albumService.insert(album);
        map.put("flag", true);
        return map;
    }
}
