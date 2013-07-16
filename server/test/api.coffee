request = require "request"

describe "/users", ->
    it "should say hello world", (done) ->
        request "http://localhost:3141/api/me", (err, res, body) ->
            console.log body
            done()