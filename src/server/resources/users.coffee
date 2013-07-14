mongoose = require "mongoose"

User = require "../models/users"

exports.findAll = (req, res) ->
    query = User.find()
    query.select "username dateCreated admin"
    query.exec (err, users) ->
        if err then throw err
        console.log users
        if users and users.length > 0
            # Found some users
            res.send 200, users
        else
            # No users found
            res.send 409,
                error: "no users found"

exports.findOne = (req, res) ->
    query = User.findById req.params.id
    query.select "username dateCreated admin"
    query.exec (err, user) ->
        if err then throw err
        if user
            # Found a matching user
            res.send 200, user
        else
            # No user found
            res.send 409,
                error: "user not found"

exports.create = (req, res) ->
    user = new User
        username: req.body.username
    user.save (err, user) ->
        if err then throw err
        res.send 200, user

exports.update = (req, res) ->
    User.findById req.params.id, (err, user) ->
        if err then throw err
        user.username = req.body.username
        user.save (err, user) ->
            if err then throw err
            res.send 200, user

exports.delete = (req, res) ->
    User.findByIdAndRemove req.params.id, (err) ->
        if err then throw err
        res.send 200

