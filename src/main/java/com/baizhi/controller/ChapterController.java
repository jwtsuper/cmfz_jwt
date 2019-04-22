package com.baizhi.controller;

import com.baizhi.entity.Album;
import com.baizhi.entity.Chapter;
import com.baizhi.service.AlbumService;
import com.baizhi.service.ChapterService;
import com.baizhi.util.AudioUtil;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("chapter")
public class ChapterController {
    @Autowired
    private AlbumService albumService;
    @Autowired
    private ChapterService chapterService;

    @RequestMapping("addChapter")
    @ResponseBody
    public Map insert(Chapter chapter, HttpSession session, MultipartFile audio) throws IOException {
        //获取文件大小
        long size = audio.getSize();
        //调用方法计算具体大小
        String printSize = getPrintSize(size);
        //获取文件上传目录
        //此时在webapp目录下
        String realPath = session.getServletContext().getRealPath("/");

        String dir = realPath + "audio";
        File file = new File(dir);
        if (!file.exists()) {
            file.mkdir();
        }
        //重命名
        String originalFilename = audio.getOriginalFilename();
        //extension是后缀名
        String extension = FilenameUtils.getExtension(originalFilename);
        String newName = UUID.randomUUID().toString();
        newName = newName + "." + extension;
        //上传
        File file1 = null;
        try {
            file1 = new File(dir, newName);
            audio.transferTo(file1);
        } catch (IOException e) {
            e.printStackTrace();
        }
        //获取时长 是一个long类型的毫秒为单位的数值
        long ls = AudioUtil.getDuration(file1);
        String duration = ls / 60 + "分" + ls % 60 + "秒";
        //为属性赋值
        chapter.setDuraton(duration);
        chapter.setDownLoadPath(newName);
        chapter.setSize(printSize);
        chapterService.insert(chapter);
        Map map = new HashMap();

        map.put("flag", true);
        return map;
    }

    @RequestMapping("be")
    @ResponseBody
    public void selectAlbum(HttpSession session) {
        List<Album> list = albumService.select();
        session.setAttribute("list", list);

    }

    @RequestMapping("download")
    @ResponseBody
    public void download(String title, String downLoadPath, HttpServletResponse resp, HttpSession session) throws Exception {
        //获取文件路径
        String realPath = session.getServletContext().getRealPath("/audio");
        System.out.println(realPath);
        String filePath = realPath + "/" + downLoadPath;
        System.out.println(filePath);
        File file = new File(filePath);
        //修改下载时的名字
        String extension = FilenameUtils.getExtension(downLoadPath);
        String oldName = title + "." + extension;
        //下载
        //设置响应编码 防止中文不显示的问题
        String encode = null;
        try {
            encode = URLEncoder.encode(oldName, "utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        //设置响应头
        resp.setHeader("Content-Disposition", "attachment;fileName=" + encode);
        //设置响应类型 音频格式 可以不加
        resp.setContentType("audio/mpeg");
        ServletOutputStream outputStream = null;
        try {
            outputStream = resp.getOutputStream();
            //需要一个字节数组  fileutils 中封装了对应的方法自动转换成字节数组
            outputStream.write(FileUtils.readFileToByteArray(file));
        } catch (IOException e) {
            e.printStackTrace();
        }


    }

    public static String getPrintSize(long size) {
        //如果字节数少于1024，则直接以B为单位，否则先除于1024，后3位因太少无意义
        if (size < 1024) {
            return String.valueOf(size) + "B";
        } else {
            size = size / 1024;
        }
        //如果原字节数除于1024之后，少于1024，则可以直接以KB作为单位
        //因为还没有到达要使用另一个单位的时候
        //接下去以此类推
        if (size < 1024) {
            return String.valueOf(size) + "KB";
        } else {
            size = size / 1024;
        }
        if (size < 1024) {
            //因为如果以MB为单位的话，要保留最后1位小数，
            //因此，把此数乘以100之后再取余
            size = size * 100;
            return String.valueOf((size / 100)) + "."
                    + String.valueOf((size % 100)) + "MB";
        } else {
            //否则如果要以GB为单位的，先除于1024再作同样的处理
            size = size * 100 / 1024;
            return String.valueOf((size / 100)) + "."
                    + String.valueOf((size % 100)) + "GB";
        }
    }
}
