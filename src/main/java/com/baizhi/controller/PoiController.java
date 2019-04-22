package com.baizhi.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import com.baizhi.entity.Album;
import com.baizhi.service.AlbumService;
import com.baizhi.service.ChapterService;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("poi")
public class PoiController {

    @Autowired
    private AlbumService albumService;
    @Autowired
    private ChapterService chapterService;

    @RequestMapping("poi")
    public void poi(String id) {
        List<Album> list = albumService.select();

        Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams("专辑详情",
                        "学生"),
                Album.class, list);
        try {
            workbook.write(new FileOutputStream(new File("E:/jwt.xls")));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
