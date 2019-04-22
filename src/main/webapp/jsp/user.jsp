<%@page contentType="text/html; UTF-8" pageEncoding="UTF-8" isELIgnored="false" language="java" %>
<script>
    $(function () {

        var tb = [{
            iconCls: 'icon-add',
            text: '添加',
            handler: function () {
                //alert('编辑按钮')
                $('#dd_user').dialog('open');

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
                $('#dg_user').edatagrid("destroyRow");


            }
        }, '-', {
            iconCls: 'icon-save',
            text: '保存',
            handler: function () {
                //alert('帮助按钮')
                $('#dg_user').edatagrid('saveRow');

            }
        }];

        $('#dg_user').edatagrid({
            method: 'post',
            url: '${pageContext.request.contextPath}/user/select',
            saveUrl: '${pageContext.request.contextPath}/user/update',
            //updateUrl:'${pageContext.request.contextPath}/user/update',
            destroyUrl: '${pageContext.request.contextPath}/user/delete',
            fit: true,
            //自动保存
            autoSave: true,
            fitColumns: true,
            pagination: true,
            pageSize: 2,
            pageList: [2, 4, 6, 8, 10],
            columns: [[

                {field: 'name', title: '姓名', width: 100},
                {
                    field: 'status', title: '状态', width: 100, editor: {
                        type: 'text',
                        options: {required: true}
                    }, formatter: function (value, rowData, rowIndex) {
                        if (value == 0) {
                            return "激活";
                        } else {
                            return "冻结";
                        }
                    }
                },
                {field: 'province', title: '省份', width: 100},
                {field: 'city', title: '城市', width: 100},
                {
                    field: 'sex', title: '性别', width: 100, formatter: function (value, rowData, rowIndex) {
                        if (value == 1) {
                            return "男";
                        } else {
                            return "女";
                        }
                    }
                }
            ]],
            toolbar: tb,


            view: detailview,
            //rowIndex:行的索引
            //rowData ：行数据
            detailFormatter: function (rowIndex, rowData) {

                return '<table><tr>' +
                    '<td rowspan=2 style="border:0"><img src="${pageContext.request.contextPath}/user/' + rowData.headImg + '" style="height:50px;"></td>' +
                    '<td style="border:0">' +
                    '<p>描述: ' + rowData.name + '</p>' +
                    '<p>Status: ' + rowData.sign + '</p>' +
                    '</td>' +
                    '</tr></table>';
            }
        });
    })

    function addUser() {
        // call 'submit' method of form plugin to submit the form
        $('#ff_user').form('submit', {
            url: '${pageContext.request.contextPath}/user/insert',
            onSubmit: function () {
                // do some check
                // return false to prevent submit;
            },
            success: function (data) {
                data = JSON.parse(data)
                if (data.flag) {
                    console.log(1111111111)
                    $('#dd_user').dialog("close");
                    $('#ff_user').form("clear");
                    $('#dg_user').edatagrid("load")

                }
            }
        });

    }

</script>
<table id="dg_user"></table>
<div id="dd_user" class="easyui-dialog" title="My Dialog" style="width:400px;height:200px;"
     data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,
            buttons:[{
				text:'保存',
				handler:function(){
				    addUser();
				}
			},{
				text:'关闭',
				handler:function(){}
			}]">

    <form id="ff_user" method="post" enctype="multipart/form-data">
        <div>
            <label for="username">标题:姓名</label>
            <input id="username" class="easyui-validatebox" type="text" name="name" data-options="required:true"/>
        </div>
        <div>
            <label for="userpwd">标题:密码</label>
            <input id="userpwd" class="easyui-validatebox" type="text" name="password" data-options="required:true"/>
        </div>
        <div>
            <label for="userprovince">标题:省</label>
            <input id="userprovince" class="easyui-validatebox" type="text" name="province"
                   data-options="required:true"/>
        </div>
        <div>
            <label for="usercity">标题:市</label>
            <input id="usercity" class="easyui-validatebox" type="text" name="city" data-options="required:true"/>
        </div>
        <div>
            <label for="usersex">标题:市</label>
            <select id="usersex" name="sex">
                <option value="1">男</option>
                <option value="0">女</option>
            </select>
        </div>
        <div>
            <label for="usersign">标题:签名</label>
            <input id="usersign" class="easyui-validatebox" type="text" name="sign" data-options="required:true"/>
        </div>
        <div>
            <label for="createDate">添加时间:</label>
            <input id="createDate" class="easyui-validatebox" type="date" name="createDate"/>
        </div>
        <input class="easyui-filebox" name="userfile" style="width:150px">

    </form>
</div>
