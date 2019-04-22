package com.baizhi.entity;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import tk.mybatis.mapper.annotation.KeySql;

import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Data
@Table(name = "user")
public class User {
    @Id
    @KeySql(useGeneratedKeys = true)
    private Integer id;
    private String name;
    private String dharma;
    private Integer sex;
    private String province;
    private String city;
    private String sign;
    private Integer status = 0;
    private String phone;
    private String password;
    private String salt;
    private String headImg;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date createDate;
    private Integer masterId;

}
