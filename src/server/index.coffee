express = require "express"
mongoose = require "mongoose"
connectMongo = require "connect-mongo"

# Setup exress
app = express()
api = express()

# Do some parsing
api.use express.bodyParser()
api.use express.cookieParser()

# Setup sessions
mongoSession = connectMongo express
api.use express.session
    store: new mongoSession
        url: "mongodb://localhost/node-image-manager"
    secret: "1234567890QWERTY"
    cookie:
        maxAge: 1000 * 60

# Setup mongoose connection
mongoose.connect "mongodb://localhost/node-image-manager"

# Setup the api

# User resource
api.get "/users", require("./resources/users").findAll
api.get "/users/:id", require("./resources/users").findOne
api.post "/users", require("./resources/users").create
api.put "/users/:id", require("./resources/users").update
api.delete "/users/:id", require("./resources/users").delete

# Mount the api
app.use "/api", api

# Serve static files
app.use express.static require("path").normalize __dirname + "/../../static"

console.log "Listening on port 3141"
app.listen 3141

# GET /resources
# GET /resources/:id
# POST /resources
# PUT /resources/:id
# DELETE /resources/:id