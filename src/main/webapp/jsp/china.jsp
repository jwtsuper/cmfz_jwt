<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" isELIgnored="false" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>China</title>
    <!-- 引入 echarts.js -->
    <script src="../js/jquery.min.js"></script>
    <script src="../js/echarts.min.js"></script>
    <script src="../js/china.js"></script>
</head>
<body>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="statistics_china" style="width: 600px;height:400px;"></div>


<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('statistics_china'));

    function randomData() {
        return Math.round(Math.random() * 1000);
    }

    option = {
        title: {
            text: 'cmfz用户分布',
            subtext: 'by_jwt',
            left: 'center'
        },
        tooltip: {
            trigger: 'item'
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: ['男', '女']
        },
        visualMap: {
            min: 0,
            max: 2500,
            left: 'left',
            top: 'bottom',
            text: ['高', '低'],           // 文本，默认为数值文本
            calculable: true
        },
        toolbox: {
            show: true,
            orient: 'vertical',
            left: 'right',
            top: 'center',
            feature: {
                mark: {show: true},
                dataView: {show: true, readOnly: false},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        series: [
            {
                name: '男',
                type: 'map',
                mapType: 'china',
                roam: false,
                label: {
                    normal: {
                        show: false
                    },
                    emphasis: {
                        show: true
                    }
                },
                data: []
            },
            {
                name: '女',
                type: 'map',
                mapType: 'china',
                label: {
                    normal: {
                        show: false
                    },
                    emphasis: {
                        show: true
                    }
                },
                data: []
            }
        ]
    };


    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
    $(function () {
        $.post("${pageContext.request.contextPath}/echarts/male", function (data) {
            console.log(data);
            myChart.setOption({
                series: [{
                    // 根据名字对应到相应的系列
                    name: '男',
                    data: data.male
                }]
            });
        }, "json");

        $.post("${pageContext.request.contextPath}/echarts/female", function (data) {
            console.log(data);
            myChart.setOption({
                series: [{
                    // 根据名字对应到相应的系列
                    name: '女',
                    data: data.female
                }]
            });
        }, "json");
    });

</script>
</body>
</html>