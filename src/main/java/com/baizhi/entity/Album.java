package com.baizhi.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelCollection;
import cn.afterturn.easypoi.excel.annotation.ExcelIgnore;
import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Id;
import javax.persistence.Transient;
import java.util.Date;
import java.util.List;

@Data
public class Album {
    @Id
    @ExcelIgnore
    private String id;
    @Excel(name = "专辑标题", needMerge = true)
    private String title;
    @Excel(name = "数量")
    private Integer amount = 0;
    @Excel(name = "图片", type = 2, width = 20, height = 10)
    private String imgPath;
    //星级
    @Excel(name = "星级")
    private Integer score;
    @Excel(name = "作者")
    private String author;
    //播音员
    @Excel(name = "播音员")
    private String boardCast;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyy-MM-dd")
    @Excel(name = "发布日期", exportFormat = "yyyy-MM-dd")
    private Date publishDate;
    //描述
    @Excel(name = "描述")
    private String brief;
    @Transient
    @ExcelCollection(name = "章节")
    private List<Chapter> children;


}
