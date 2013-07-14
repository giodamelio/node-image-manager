fill = ->
    $("#registerUsername").val "giodamelio"
    $("#registerPassword").val "haha123123"
    $("#registerPasswordConfirm").val "haha123123"

$(document).ready ->
    # Fill in some forms to help with testing
    fill()

    Register = require "./controls/register"
    register = new Register($("#registerContainer"))