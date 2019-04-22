<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" isELIgnored="false" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>ECharts</title>
    <!-- 引入 echarts.js -->
    <script src="../js/jquery.min.js"></script>
    <script src="../js/echarts.min.js"></script>
</head>
<body>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="main" style="width: 600px;height:400px;"></div>


<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    $.ajax({

        url: '${pageContext.request.contextPath}/echarts/userActive',
        dataType: 'JSON',
        success: function (data) {
            // 指定图表的配置项和数据
            console.log(data)
            var option = {
                title: {
                    text: '持名法州App活跃用户',
                    subtext: 'jwt制作'
                },
                tooltip: {},
                legend: {
                    data: ['用户数量']
                },
                xAxis: {
                    data: data.xAxisData
                },
                yAxis: {},
                series: [{
                    name: '用户数量',
                    type: 'bar',
                    data: data.seriesData
                }]
            };

            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
        }
    })

</script>
</body>
</html>