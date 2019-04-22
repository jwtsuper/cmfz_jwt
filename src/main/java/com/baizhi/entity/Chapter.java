package com.baizhi.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelIgnore;
import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Data
@Table(name = "chapter")
public class Chapter {
    @Id
    @KeySql(useGeneratedKeys = true)
    @ExcelIgnore
    private Integer id;
    @Excel(name = "章节标题")
    private String title;
    @Excel(name = "章节大小")
    private String size;
    //时长
    @Excel(name = "章节时长")
    private String duraton;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyy-MM-dd")
    @Excel(name = "章节发布日期", exportFormat = "yyyy-MM-dd")
    private Date tpublicshDate;
    @ExcelIgnore
    private String albumId;
    @Excel(name = "章节路径")
    private String downLoadPath;


}
