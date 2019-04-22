package com.baizhi.controller;

import com.alibaba.fastjson.JSONObject;
import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import io.goeasy.GoEasy;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("select")
    public List<User> select() {

        return userService.selectAll();
    }

    @RequestMapping("insert")
    public Map insert(User user, HttpSession session, MultipartFile userfile) {
        //获取文件上传目录
        //此时在webapp目录下
        String realPath = session.getServletContext().getRealPath("/");

        String dir = realPath + "user";
        File file = new File(dir);
        if (!file.exists()) {
            file.mkdir();
        }
        //重命名
        String originalFilename = userfile.getOriginalFilename();
        //extension是后缀名
        String extension = FilenameUtils.getExtension(originalFilename);
        String newName = UUID.randomUUID().toString();
        newName = newName + "." + extension;
        //上传
        File file1 = null;
        try {
            file1 = new File(dir, newName);
            userfile.transferTo(file1);
        } catch (IOException e) {
            e.printStackTrace();
        }
        user.setHeadImg(newName);
        userService.insert(user);
        Map count = userService.selectActiveCount();
        String s = JSONObject.toJSONString(count);
        //不要用https协议
        GoEasy goEasy = new GoEasy("http://rest-hangzhou.goeasy.io", "BC-fdbdb55257834c07bb017622f587572f");
        goEasy.publish("useractive", s);
        Map map = new HashMap();
        map.put("flag", true);
        return map;
    }
}
