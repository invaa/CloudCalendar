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

        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            editable: true,
            eventLimit: true, // allow "more" link when too many events
            events: {
                url: "${pageContext.request.contextPath}/getEvents",
                error: function () {
                    $('#script-warning').show();
                }
            },
            loading: function (bool) {
                $('#loading').toggle(bool);
            }

        });

        $("#add-attender").click(function() {
            attender = $("#current-attender").val();

            //TODO: validate email, remove duplicates

            if (attender != "") {
                $('#attenders').append('<option value="'
                        + attender
                        + '">'
                        + attender
                        + '</option>');
            }
        });

        $("#remove-attender").click(function() {
            $("#attenders :selected").remove();
        });
    });

</script>
<script>
    $(function () {
        var dialog, form,

                attenders = $("#attenders"),
                swatch = $("#swatch"),
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
                //1. JSON add
                $.getJSON("${pageContext.request.contextPath}/addEvent",
                        {
                            start: start.val(),
                            end: end.val(),
                            description: description.val(),
                            title: title.val(),
                            attenders: $("select#attenders option").map(function() {return $(this).val();}).get(),
                            color: swatch.css("background-color")
                        },
                        function (data) {

                            //2.update calendar
                            $(calendar).fullCalendar( 'refetchEvents' )
                        })
                        .done(function () {

                        })
                        .fail(function () {
                        })
                        .complete(function () {
                        });

                dialog.dialog("close");
            }
            return valid;
        }

        dialog = $("#dialog-form").dialog({
            autoOpen: false,
            height: 600,
            width: 800,
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

    #loading {
        display: none;
        position: absolute;
        top: 10px;
        right: 10px;
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

    div#users-contain {
        width: 350px;
        margin: 20px 0;
    }

    div#users-contain table {
        margin: 1em 0;
        border-collapse: collapse;
        width: 100%;
    }

    div#users-contain table td, div#users-contain table th {
        border: 1px solid #eee;
        padding: .6em 10px;
        text-align: left;
    }

    .ui-dialog .ui-state-error {
        padding: .3em;
    }

    .validateTips {
        border: 1px solid transparent;
        padding: 0.3em;
    }
</style>

<!-- Color picker -->
<style>
    #red, #green, #blue {
        float: left;
        clear: left;
        width: 300px;
        margin: 15px;
    }
    #swatch {
        width: 120px;
        height: 100px;
        margin-top: 18px;
        margin-left: 350px;
        background-image: none;
    }
    #red .ui-slider-range { background: #ef2929; }
    #red .ui-slider-handle { border-color: #ef2929; }
    #green .ui-slider-range { background: #8ae234; }
    #green .ui-slider-handle { border-color: #8ae234; }
    #blue .ui-slider-range { background: #729fcf; }
    #blue .ui-slider-handle { border-color: #729fcf; }
</style>
<script>
    function hexFromRGB(r, g, b) {
        var hex = [
            r.toString( 16 ),
            g.toString( 16 ),
            b.toString( 16 )
        ];
        $.each( hex, function( nr, val ) {
            if ( val.length === 1 ) {
                hex[ nr ] = "0" + val;
            }
        });
        return hex.join( "" ).toUpperCase();
    }
    function refreshSwatch() {
        var red = $( "#red" ).slider( "value" ),
                green = $( "#green" ).slider( "value" ),
                blue = $( "#blue" ).slider( "value" ),
                hex = hexFromRGB( red, green, blue );
        $( "#swatch" ).css( "background-color", "#" + hex );
    }
    $(function() {
        $( "#red, #green, #blue" ).slider({
            orientation: "horizontal",
            range: "min",
            max: 255,
            value: 127,
            slide: refreshSwatch,
            change: refreshSwatch
        });
        $( "#red" ).slider( "value", 255 );
        $( "#green" ).slider( "value", 140 );
        $( "#blue" ).slider( "value", 60 );
    });
</script>
</head>
<body>

<div class="container" style="padding-top: 10px">
    <h1>Calendar Service</h1>
    <button id="create-event">Create new event</button>
</div>

<div id='script-warning'>
    <code>/getEvents</code> must be running.
</div>

<div id='loading'>loading...</div>

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

            <div id="red"></div>
            <div id="green"></div>
            <div id="blue"></div>

            <div id="swatch" class="ui-widget-content ui-corner-all"></div>

            <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
        </fieldset>

        <label for="current-attender">Attender to be added:</label>
        <input type="text" name="current-attender" id="current-attender" value="" class="text ui-widget-content ui-corner-all">
        <div>
            <select size="3" id="attenders" name="attenders">

            </select>
        </div>
        <button id="add-attender">Add</button>
        <button id="remove-attender">Remove</button>

    </form>
</div>

</body>
</html>
