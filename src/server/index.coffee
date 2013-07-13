restify = require "restify"
connect = require "connect"

server = restify.createServer
    name: "node-image-manager",
server.use restify.authorizationParser()
server.use (req, res, next) ->
    console.log req.authorization
    next()

respond = (req, res, next) ->
    res.send {hello: req.params.name}

server.get "/hello/:name", respond

app = connect()
app.use connect.bodyParser()
app.use connect.query()
app.use connect.cookieParser()

# Mount the api
app.use "/api", (req, res) ->
    server.server.emit "request", req, res

# Serve static content
app.use connect.static require("path").normalize __dirname + "/../../static"

console.log "Listening on port 3141..."
app.listen 3141
