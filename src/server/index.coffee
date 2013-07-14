express = require "express"
mongoose = require "mongoose"

# Setup exress
app = express()
api = express()

app.use express.bodyParser()
app.use express.cookieParser()
app.use express.session secret: "1234567890QWERTY"

api.get "/", (req, res) ->
    res.send "Hello World!"

# Mount the api
app.use "/api", api

# Serve static files
app.use express.static require("path").normalize __dirname + "/../../static"

console.log "Listening on port 3141"
app.listen 3141
