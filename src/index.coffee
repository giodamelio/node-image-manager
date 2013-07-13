restify = require "restify"

respond = (req, res, next) ->
    res.send {hello: req.params.name}

server = restify.createServer()
server.get "/hello/:name", respond
server.head "/hello/:name", respond

server.listen 3141, ->
    console.log "%s listening at %s", server.name, server.url
