mongoose = require "mongoose"
bcrypt = require "bcrypt"

User = require "./models/users"

exports.login = (req, res) ->
    req.authenticate "basic", (err, authenticated) ->
        if err then throw err
        res.send
            authenticated: req.isAuthenticated()

exports.logout = (req, res) ->
    req.logout()
    req.session.destroy()
    res.send 
        authenticated: req.isAuthenticated()

exports.register = (req, res) ->
    bcrypt.genSalt 10, (err, salt) ->
        if err then throw err
        bcrypt.hash req.body.username, salt, (err, hash) ->
            if err then throw err
            user = new User
                username: req.body.username
                password_hash: hash
            user.save (err, user) ->
                if err then throw err
                res.send 200, user

exports.me = (req, res) ->
    res.send 
        authenticated: req.isAuthenticated()

exports.validatePassword = (username, password, successCallback, failureCallback) =>
    User.findOne username: username, "username password_hash", (err, user) ->
        if err then throw err
        bcrypt.compare password, user.password_hash, (err, res) ->
            if err then throw err
            if user.username == username
                successCallback()
            else
                failureCallback()
