<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset='utf-8'/>

<link rel="stylesheet" href="http://fullcalendar.io/js/fullcalendar-2.1.1/fullcalendar.min.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>
<script src="http://fullcalendar.io/js/fullcalendar-2.1.1/lib/moment.min.js"></script>
<script src="http://fullcalendar.io/js/fullcalendar-2.1.1/fullcalendar.min.js"></script>
<script>
    $(document).ready(function () {
        $(calendar).fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            editable: true,
            events: {
                url: "${pageContext.request.contextPath}/getEvents",
                error: function () {
                    $('#script-warning').show();
                }
            }
        });
    });
</script>
<script>
    $(function () {
        var dialog, form,

                title = $("#title"),
                description = $("#description"),
                start = $("#start"),
                end = $("#end"),
                allFields = $([]).add(title).add(description).add(start).add(end),
                tips = $(".validateTips");

        function updateTips(t) {
            tips
                    .text(t)
                    .addClass("ui-state-highlight");
            setTimeout(function () {
                tips.removeClass("ui-state-highlight", 1500);
            }, 500);
        }

        function checkLength(o, n, min, max) {
            if (o.val().length > max || o.val().length < min) {
                o.addClass("ui-state-error");
                updateTips("Length of " + n + " must be between " +
                        min + " and " + max + ".");
                return false;
            } else {
                return true;
            }
        }

        function checkRegexp(o, regexp, n) {
            if (!( regexp.test(o.val()) )) {
                o.addClass("ui-state-error");
                updateTips(n);
                return false;
            } else {
                return true;
            }
        }

        function addEvent() {
            var valid = true;
            allFields.removeClass("ui-state-error");

            valid = valid && checkLength(title, "title", 3, 200);
            valid = valid && checkLength(description, "description", 6, 400);
            valid = valid && checkRegexp(start, /^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$/i, "Start date should be in yyyy-MM-dd HH:mm:ss format.");
            valid = valid && checkRegexp(end, /^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$/i, "End date should be in yyyy-MM-dd HH:mm:ss format.");

            if (valid) {
                $.getJSON("${pageContext.request.contextPath}/addEvent",
                        {
                            start: start.val(),
                            end: end.val(),
                            description: description.val(),
                            title: title.val()
                        },
                        function (data) {
                           $(calendar).fullCalendar( 'refetchEvents' )
                        });

                dialog.dialog("close");
            }
            return valid;
        }

        dialog = $("#dialog-form").dialog({
            autoOpen: false,
            height: 600,
            width: 350,
            modal: true,
            buttons: {
                "Create new event": addEvent,
                Cancel: function () {
                    dialog.dialog("close");
                }
            },
            close: function () {
                form[ 0 ].reset();
                allFields.removeClass("ui-state-error");
            }
        });

        form = dialog.find("form").on("submit", function (event) {
            event.preventDefault();
            addEvent();
        });

        $("#create-event").button().on("click", function () {
            dialog.dialog("open");
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

    #calendar, .container {
        max-width: 900px;
        margin: 40px auto;
        padding: 0 10px;
    }

    label, input {
        display: block;
    }

    input.text {
        margin-bottom: 12px;
        width: 95%;
        padding: .4em;
    }

    fieldset {
        padding: 0;
        border: 0;
        margin-top: 25px;
    }

    .ui-dialog .ui-state-error {
        padding: .3em;
    }

    .validateTips {
        border: 1px solid transparent;
        padding: 0.3em;
    }
</style>
</head>
<body>

<div class="container" style="padding-top: 10px">
    <h1>Calendar Service</h1>
    <button id="create-event">Create new event</button>
</div>

<div id='script-warning'>
    <code>/getEvents</code> must be running.
</div>

<div id='calendar'></div>

<div id="dialog-form" title="Create new event">
    <p class="validateTips">All form fields are required.</p>

    <form>
        <fieldset>
            <label for="title">Title</label>
            <input type="text" name="title" id="title" value="Some event" class="text ui-widget-content ui-corner-all">
            <label for="description">Description</label>
            <input type="text" name="description" id="description" value=""
                   class="text ui-widget-content ui-corner-all">
            <label for="start">Start</label>
            <input type="text" name="start" id="start" value="" class="text ui-widget-content ui-corner-all">
            <label for="end">End</label>
            <input type="text" name="end" id="end" value="" class="text ui-widget-content ui-corner-all">

            <!-- Allow form submission with keyboard without duplicating the dialog button -->
            <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
        </fieldset>
    </form>
</div>

</body>
</html>
