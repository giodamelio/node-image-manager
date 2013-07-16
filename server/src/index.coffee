express = require "express"
mongoose = require "mongoose"
connectMongo = require "connect-mongo"
connectAuth = require "connect-auth"

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
        maxAge: 1000 * 60 * 5

# Setup mongoose connection
mongoose.connect "mongodb://localhost/node-image-manager"

# Setup the api

# Authenticate the user
api.use connectAuth
    strategies:
        connectAuth.Basic validatePassword: require("./auth").validatePassword

# Setup login, logout and register
api.post "/login", require("./auth").login
api.post "/logout", require("./auth").logout
api.post "/register", require("./auth").register
api.get "/me", require("./auth").me

# User resource
api.get "/users", require("./resources/users").findAll
api.get "/users/:id", require("./resources/users").findOne
api.post "/users", require("./resources/users").create
api.put "/users/:id", require("./resources/users").update
api.delete "/users/:id", require("./resources/users").delete

# Mount the api
app.use "/api", api

# Serve static files
app.use express.static require("path").normalize __dirname + "/../../client"

console.log "Listening on port 3141"
app.listen 3141

# GET /resources
# GET /resources/:id
# POST /resources
# PUT /resources/:id
# DELETE /resources/:id