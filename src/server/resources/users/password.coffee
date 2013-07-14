bcrypt = require("bcrypt")

exports.cryptPassword = (password, callback) ->
    bcrypt.genSalt 10, (err, salt) ->
        unless err
            bcrypt.hash password, salt, (err, hash) ->
                callback err, hash

exports.comparePassword = (password, userPassword, callback) ->
    bcrypt.compare password, userPassword, (err, isPasswordMatch) ->
        if err
            callback err
        else
            callback null, isPasswordMatch
