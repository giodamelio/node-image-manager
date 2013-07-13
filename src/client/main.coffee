$(document).ready ->
    $("#sayHello").click ->
        $.ajax 
            url: "/api/hello/" + encodeURIComponent($("#name").val())
            headers:
               "Authorization": "Basic " + btoa($("#username").val() + ":" + $("#password").val())
            success: (data) ->
                $("#response").val JSON.stringify data