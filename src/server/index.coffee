express = require "express"

# Setup exress
app = express()

app.use express.bodyParser()
app.use express.cookieParser()
app.use express.session secret: "1234567890QWERTY"

# Serve static files
app.use express.static require("path").normalize __dirname + "/../../static"

console.log "Listening on port 3141"
app.listen 3141
