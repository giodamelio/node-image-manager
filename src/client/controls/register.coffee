helpers = require "../../shared/helpers"

module.exports = Register = can.Control
    init: (element, options) ->
        console.log "Login control init"

    # Validate the password by length
    # password must be between 8-64 charcter in length
    "#registerPassword keyup": (element, event) ->
        element = $(element)
        if element.val().length < 8 or element.val().length > 63
            element.parent().addClass "invalid"
            element.parent().removeClass "valid"
        else
            element.parent().addClass "valid"
            element.parent().removeClass "invalid"

    # Confirm the password
    # The passwords must match
    "#registerPasswordConfirm keyup": (element, event) ->
        element = $(element)
        if element.val() != $("#registerPassword").val()
            element.parent().addClass "invalid"
            element.parent().removeClass "valid"
        else
            element.parent().addClass "valid"
            element.parent().removeClass "invalid"

    # Submit the data
    # Makes a new user
    "#registerSubmit click": (element, event) ->
        $.ajax 
            url: "/api/users/register"
            type: "POST"
            global: false
            data:
                auth: helpers.base64Auth.encode $("#registerUsername").val(), $("#registerPassword").val()
        .done (data, status) ->
            console.log status, JSON.stringify data
        .fail (xhr, status, error) ->
            console.log xhr.status, JSON.stringify xhr.responseJSON
