<%@page contentType="text/html; UTF-8" pageEncoding="UTF-8" isELIgnored="false" language="java" %>
<script>
    $(function () {

        var tb = [{
            iconCls: 'icon-add',
            text: '添加',
            handler: function () {
                //alert('编辑按钮')
                $('#dd_banner').dialog('open');

            }
        }, '-', {
            iconCls: 'icon-edit',
            text: '修改',
            handler: function () {
                alert('帮助按钮')
            }
        }, '-', {
            iconCls: 'icon-delete',
            text: '删除',
            handler: function () {
                //alert('帮助按钮')
                $('#dg_banner').edatagrid("destroyRow");


            }
        }, '-', {
            iconCls: 'icon-save',
            text: '保存',
            handler: function () {
                //alert('帮助按钮')
                $('#dg_banner').edatagrid('saveRow');

            }
        }];

        $('#dg_banner').edatagrid({
            method: 'post',
            url: '${pageContext.request.contextPath}/banner/select',
            saveUrl: '${pageContext.request.contextPath}/banner/update',
            //updateUrl:'${pageContext.request.contextPath}/banner/update',
            destroyUrl: '${pageContext.request.contextPath}/banner/delete',
            fit: true,
            //自动保存
            autoSave: true,
            fitColumns: true,
            pagination: true,
            pageSize: 2,
            pageList: [2, 4, 6, 8, 10],
            columns: [[

                {field: 'title', title: '标题', width: 100},
                {
                    field: 'status', title: '状态', width: 100, editor: {
                        type: 'text',
                        options: {required: true}
                    }
                },
                {field: 'createDate', title: '日期', width: 100},
                {field: 'imgPath', title: '路径', width: 100}
            ]],
            toolbar: tb,


            view: detailview,
            //rowIndex:行的索引
            //rowData ：行数据
            detailFormatter: function (rowIndex, rowData) {

                return '<table><tr>' +
                    '<td rowspan=2 style="border:0"><img src="${pageContext.request.contextPath}/' + rowData.imgPath + '" style="height:50px;"></td>' +
                    '<td style="border:0">' +
                    '<p>描述: ' + rowData.title + '</p>' +
                    '<p>Status: ' + rowData.status + '</p>' +
                    '</td>' +
                    '</tr></table>';
            }
        });
    })

    function addBanner() {
        // call 'submit' method of form plugin to submit the form
        $('#ff').form('submit', {
            url: '${pageContext.request.contextPath}/banner/insert',
            onSubmit: function () {
                // do some check
                // return false to prevent submit;
            },
            success: function (data) {
                data = JSON.parse(data)
                if (data.flag) {
                    console.log(1111111111)
                    $('#dd_banner').dialog("close");
                    $('#dg_banner').edatagrid("load")

                }
            }
        });

    }

</script>
<table id="dg_banner"></table>
<div id="dd_banner" class="easyui-dialog" title="My Dialog" style="width:400px;height:200px;"
     data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,
            buttons:[{
				text:'保存',
				handler:function(){
				    addBanner();
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
            <label for="addDate">添加时间:</label>
            <input id="addDate" class="easyui-validatebox" type="date" name="createDate"/>
        </div>
        <input class="easyui-filebox" name="addBanner" style="width:150px">

    </form>
</div>
