<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" isELIgnored="false" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>ECharts</title>
    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="http://cdn-hangzhou.goeasy.io/goeasy.js"></script>
</head>
<body>

<script type="text/javascript">

    var goEasy = new GoEasy({
        appkey: "BC-fdbdb55257834c07bb017622f587572f"
    });

    goEasy.subscribe({
        channel: "useractive",
        onMessage: function (message) {
            alert("Channel:" + message.channel + " content:" + message.content);
        }
    });

</script>
</body>
</html>