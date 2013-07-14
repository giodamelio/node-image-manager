mongoose = require "mongoose"

helpers = require "../../../shared/helpers"
password = require "./password"

userSchema = mongoose.Schema
    username: String,
    password: String,
    dateCreated: Date
User = mongoose.model "User", userSchema
    
exports.register = (req, res, next) ->
    # Decode and split the username and password
    auth = helpers.base64Auth.decode req.body.auth

    # Validate the info
    User.findOne username: auth[0], (err, user) ->
        if user
            res.send 409,
                error: "User already exsists"
            next()

        # Hash the password with bcrypt before storing in the database
        password.cryptPassword auth[1], (err, hash) ->
            user = new User
                username: auth[0]
                password: hash
                dateCreated: Date.now()
                admin: false

            user.save (err) ->
                if (err) then console.log err

            res.send 201,
                username: user.username
                dateCreated: user.dateCreated
                
            next()