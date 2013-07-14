restify = require "restify"
connect = require "connect"
mongoose = require "mongoose"

# Get the mongo connection
mongoose.connect "mongodb://localhost/node-image-manager"

# Make the restify server
server = restify.createServer
    name: "node-image-manager",

# Check the users authorization
server.use restify.authorizationParser()
server.use (req, res, next) ->
    #console.log req.authorization
    next()

# The user resource
server.post "/users/register", require("./resources/users").register

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
