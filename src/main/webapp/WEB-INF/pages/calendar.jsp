<%--
  Created by IntelliJ IDEA.
  User: a.zamkovyi
  Date: 08.10.2014
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="http://fullcalendar.io/js/fullcalendar-2.1.1/fullcalendar.min.css">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
    <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="http://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>
    <script src="http://fullcalendar.io/js/fullcalendar-2.1.1/lib/moment.min.js"></script>
    <script src="http://fullcalendar.io/js/fullcalendar-2.1.1/fullcalendar.min.js"></script>

    <script>
        $(document).ready(function()  {
            $("#calendar").fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month, agendaWeek, agendaDay'
                },
                editable: true,
                events: {
                    url: "${pageContext.request.contextPath}/getEvents",
                    error: function () {
                        $("#script-warning").show();
                    }
                }
            });
        });
    </script>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
            font-size: 14px;
        }

        #script-warning {
            display: none;
            background: #eee;
            border-bottom: 1px solid #ddd;
            padding: 0 10px;
            line-height: 40px;
            text-align: center;
            font-weight: bold;
            font-size: 12px;
            color: red;
        }

        #calendar, #container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 10px;
        }

    </style>

    <title>Google Cloud Calendar</title>
</head>
<body>

<div id="container">
    <h1>Google Cloud Calendar</h1>
</div>

<div id="script-warning">
    <code>/getEvents</code> must be running
</div>

<div id="calendar">

</div>


</body>
</html>
