restify = require "restify"
connect = require "connect"

server = restify.createServer
    name: "node-image-manager",

respond = (req, res, next) ->
    res.send {hello: req.params.name}

server.get "/hello/:name", respond

app = connect()
app.use connect.logger()
app.use connect.bodyParser()
app.use connect.query()
app.use connect.cookieParser()

# Mount the api
app.use "/api", (req, res) ->
    server.server.emit "request", req, res

# Serve static content
app.use connect.static __dirname + "/static"

console.log "Listening on port 3141..."
app.listen 3141
