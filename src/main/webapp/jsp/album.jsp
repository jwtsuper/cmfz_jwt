<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; UTF-8" pageEncoding="UTF-8" isELIgnored="false" language="java" %>
<script>
    $(function () {


        var tb = [{
            iconCls: 'icon-search',
            text: '专辑详情',
            handler: function () {
                // alert('编辑按钮')
                console.log("aaaaaaaaaaaa")

                var isSelect = $('#tt_album').treegrid("getSelected")

                if (isSelect != null) {

                    if (isSelect.size == null) {
                        $('#dd_album').dialog('open');
                        console.log(isSelect)
                        $("#albumId").val(isSelect.id)
                        $("#albumTitle").val(isSelect.title)
                        $("#albumAmount").val(isSelect.amount)
                        $("#albumPath").val(isSelect.imgPath)
                        $("#albumSource").val(isSelect.score)
                        $("#albumAuthor").val(isSelect.author)
                        $("#albumBoardcast").val(isSelect.boardCast)
                        $("#albumDate").val(isSelect.publishDate)
                        $("#albumBrief").val(isSelect.brief)
                    } else {
                        alert("请选择专辑")
                    }

                } else {


                    alert("请选择专辑")

                }


            }
        }, '-', {
            iconCls: 'icon-add',
            text: '添加专辑',
            handler: function () {
                /* alert('帮助按钮')*/
                $('#add_album').dialog('open');
            }
        }, '-', {
            iconCls: 'icon-add',
            text: '添加音频',
            handler: function () {
                //alert('帮助按钮')


                var row = $('#tt_album').treegrid('getSelected');
                if (row != null) {
                    if (row.size == null) {
                        $('#dd_chapter').dialog('open');

                    } else {
                        alert("请选择专辑")
                    }
                } else {
                    alert("请选择专辑")
                }
            }
        }, '-', {
            iconCls: 'icon-save',
            text: '下载',
            handler: function () {
                //alert('帮助按钮')
                var isSelect = $('#tt_album').treegrid("getSelected")
                var downLoadPath = isSelect.downLoadPath
                var title = isSelect.title
                window.location.href = "${pageContext.request.contextPath}/chapter/download?title=" + title + "&downLoadPath=" + downLoadPath;


            }
        }, '-', {
            iconCls: 'icon-save',
            text: '导出表格',
            handler: function () {


                window.location.href = "${pageContext.request.contextPath}/poi/poi";


            }
        }];

        $('#tt_album').treegrid({
            //后台Controller查询所有专辑以及对应的章节集合
            method: 'post',
            url: '${pageContext.request.contextPath}/album/select',
            idField: 'id',//用来标识标识树节点   主干树与分支树节点  ID不能有相同  并且使用相同的字段  否则ID冲突
            treeField: 'title',//用来定义树节点   树形表格上要展示的信息   注意使用相同的字段 用来展示对应节点名称
            toolbar: tb,
            onClickRow: function (row) {

            },
            fit: true,
            fitColumns: true,
            columns: [[
                {field: 'title', title: '名字', width: 180},
                {field: 'downLoadPath', title: '下载路径', width: 180},
                {field: 'size', title: '章节大小', width: 60},
                {field: 'duraton', title: '章节的时长', width: 80}
            ]]
        });

    })

    function addAlbum() {
        // call 'submit' method of form plugin to submit the form

        $('#ff').form('submit', {
            url: '${pageContext.request.contextPath}/album/insert',
            onSubmit: function () {
                // do some check
                // return false to prevent submit;
            },
            success: function (data) {
                data = JSON.parse(data)
                if (data.flag) {
                    console.log(1111111111)
                    $('#add_album').dialog("close");
                    $('#ff').form("clear");
                    $('#tt_album').treegrid("load")

                }
            }
        });

    }


    function addChapter() {
        // call 'submit' method of form plugin to submit the form
        //拿到选中行的专辑id
        var row = $('#tt_album').treegrid('getSelected');
        $("#forAlbumId").val(row.id)

        $('#chapter').form('submit', {
            url: '${pageContext.request.contextPath}/chapter/addChapter',
            onSubmit: function () {
                // do some check
                // return false to prevent submit;
            },
            success: function (data) {
                data = JSON.parse(data)
                if (data.flag) {
                    console.log(1111111111)
                    $('#dd_chapter').dialog("close");
                    $('#chapter').form("clear");
                    $('#tt_album').treegrid("load")

                }
            }
        });

    }
</script>
<table id="tt_album" style="width:600px;height:400px"></table>

<div id="dd_album" class="easyui-dialog" title="专辑详情" style="width:400px;height:200px;"
     data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true">

    标题<input type="text" id="albumTitle"><br>
    数量<input type="text" id="albumAmount"><br>
    图片路径<input type="text" id="albumPath"><br>
    星级<input type="text" id="albumSource"><br>
    作者<input type="text" id="albumAuthor"><br>
    播音员<input type="text" id="albumBoardcast"><br>
    日期<input type="date" id="albumDate"><br>
    描述<input type="text" id="albumBrief"><br>
</div>

<div id="add_album" class="easyui-dialog" title="添加专辑" style="width:400px;height:200px;"
     data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,
            buttons:[{
				text:'保存',
				handler:function(){
				    addAlbum();
				}
			},{
				text:'关闭',
				handler:function(){}
			}]">

    <form id="ff" method="post" enctype="multipart/form-data">
        <div>
            <label for="addTitle">标题:</label>
            <input id="addTitle" class="easyui-validatebox" type="text" name="title" data-options="required:true"/>
        </div>
        <div>
            <label for="addscore">星级:</label>
            <input id="addscore" class="easyui-validatebox" type="text" name="score"/>
        </div>
        <div>
            <label for="addauthor">作者:</label>
            <input id="addauthor" class="easyui-validatebox" type="text" name="author"/>
        </div>
        <div>
            <label for="a1">播音员:</label>
            <input id="a1" class="easyui-validatebox" type="text" name="boardCast"/>
        </div>
        <div>
            <label for="addbrief">描述:</label>
            <input id="addbrief" class="easyui-validatebox" type="text" name="brief"/>
        </div>

        <div>
            <label for="addDate">添加时间:</label>
            <input id="addDate" class="easyui-validatebox" type="date" name="publishDate"/>
        </div>
        <input class="easyui-filebox" name="add" style="width:150px">
    </form>
</div>


<div id="dd_chapter" class="easyui-dialog" title="添加章节" style="width:400px;height:200px;"
     data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,
            buttons:[{
				text:'保存',
				handler:function(){
				    addChapter();
				}
			},{
				text:'重置',
				handler:function(){
				$('#chapter').form('reset');
				}
			}]">

    <form id="chapter" method="post" enctype="multipart/form-data">
        <div>
            <label for="chTitle">标题:</label>
            <input id="chTitle" class="easyui-validatebox" type="text" name="title" data-options="required:true"/>
        </div>
        <div>
            <label for="chDate">添加时间:</label>
            <input id="chDate" class="easyui-validatebox" type="date" name="tpublicshDate"/>
        </div>
        <%-- <div>
           <label for="al">添加时间:</label>
           <select id="al" name="albumId">
                 <c:forEach items="${sessionScope.list}" var="s">
                   <option value="${s.id}">${s.title}</option>
                 </c:forEach>
           </select>
         </div>--%>
        <div hidden>
            <label for="forAlbumId">标题:</label>
            <input id="forAlbumId" class="easyui-validatebox" type="text" name="albumId"/>
        </div>
        <input class="easyui-filebox" name="audio" style="width:150px">

    </form>
</div>