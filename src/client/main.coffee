$(document).ready ->
    $("#sayHello").click ->
        $.getJSON "/api/hello/" + encodeURIComponent($("#name").val()), (data) ->
            $("#response").val JSON.stringify data