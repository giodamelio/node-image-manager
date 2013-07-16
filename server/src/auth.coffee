mongoose = require "mongoose"

User = require "./models/users"

exports.login = (req, res) ->
    req.authenticate "basic", (err, authenticated) ->
        if err then throw err
        res.end()

    res.send 
        authenticated: req.isAuthenticated()
    console.log "Login"

exports.logout = (req, res) ->
    req.logout()
    res.send 
        authenticated: req.isAuthenticated()
    console.log "Logout"

exports.register = (req, res) ->
    console.log "Register"

exports.me = (req, res) ->
    console.log "Me"
    res.send 
        authenticated: req.isAuthenticated()

exports.validatePassword = (username, password, successCallback, failureCallback) =>
    if username == "giodamelio" and password == "haha"
        successCallback()
    else
        failureCallback()