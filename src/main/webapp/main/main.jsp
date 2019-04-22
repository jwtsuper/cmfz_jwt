﻿<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>持名法州主页</title>
    <link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../themes/IconExtension.css">
    <link rel="stylesheet" type="text/css" href="../themes/icon.css">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/datagrid-detailview.js"></script>
    <script type="text/javascript" src="../js/jquery.edatagrid.js"></script>
    <script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
    <script src="../js/echarts.min.js"></script>
    <script src="../js/china.js"></script>
    <script type="text/javascript" src="http(s)://<CDN Host>/goeasy.js"></script>
    <script type="text/javascript">
        <!--菜单处理-->
        $(function () {
            $.ajax({
                type: 'get',
                url: '${pageContext.request.contextPath}/menu/select.do',
                dataType: 'JSON',
                success: function (data) {
                    //data是响应回来的数据 是一个list集合 存储着若个menu对象
                    //data中有一个属性是list集合 需要二次遍历
                    console.log(data);
                    //第一个参数是要遍历的集合对象，函数中第一个参数是遍历的下标 注意：两次遍历的下标名字不要相同  第二个参数是每次遍历出来的对象
                    $.each(data, function (index1, first) {
                        //console.log(first.title)
                        var c = "<div align='center'>";
                        $.each(first.children, function (index2, second) {
                            //console.log(second.title)
                            //js中无法直接传递一个json对象   需要将json对象转化为json字符串再进行传输
                            var child = JSON.stringify(second);
                            c += "<p><a class='easyui-linkbutton' onclick='addTabs(" + child + ")'>" + second.title + "</a></p>";
                        })
                        c += "</div>";
                        $('#aa').accordion('add', {
                            title: first.title,
                            iconCls: first.iconCls,
                            content: c,
                            selected: false
                        });
                    })
                }
            })
        })

        function addTabs(second) {
            //alert()
            // add a new tab panel
            console.log(second)
            var isExists = $('#tt').tabs('exists', second.title);
            console.log(second.jspUrl)
            if (!isExists) {
                $('#tt').tabs('add', {
                    title: second.title,
                    href: '${pageContext.request.contextPath}' + second.jspUrl,
                    iconCls: second.iconCls,
                    closable: true,
                    tools: [{
                        iconCls: 'icon-mini-refresh',
                        handler: function () {
                            alert('refresh');
                        }
                    }]
                });
            } else {
                $('#tt').tabs('select', second.title);
            }

        }
    </script>

</head>
<body class="easyui-layout">
<div data-options="region:'north',split:true" style="height:60px;background-color:  #5C160C">
    <div style="font-size: 24px;color: #FAF7F7;font-family: 楷体;font-weight: 900;width: 500px;float:left;padding-left: 20px;padding-top: 10px">
        持名法州后台管理系统
    </div>
    <div style="font-size: 16px;color: #FAF7F7;font-family: 楷体;width: 300px;float:right;padding-top:15px">欢迎您:xxxxx
        &nbsp;<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改密码</a>&nbsp;&nbsp;<a href="#"
                                                                                                              class="easyui-linkbutton"
                                                                                                              data-options="iconCls:'icon-01'">退出系统</a>
    </div>
</div>
<div data-options="region:'south',split:true" style="height: 40px;background: #5C160C">
    <div style="text-align: center;font-size:15px; color: #FAF7F7;font-family: 楷体">&copy;百知教育 htf@zparkhr.com.cn</div>
</div>

<div data-options="region:'west',title:'导航菜单',split:true" style="width:220px;">
    <div id="aa" class="easyui-accordion" data-options="fit:true">

    </div>
</div>
<div data-options="region:'center'">
    <div id="tt" class="easyui-tabs" data-options="fit:true,narrow:true,pill:true">
        <div title="主页" data-options="iconCls:'icon-neighbourhood',"
             style="background-image:url(image/shouye.jpg);background-repeat: no-repeat;background-size:100% 100%;"></div>
    </div>
</div>
</body>
</html>