express = require "express" 
restful = require "node-restful"
mongoose = restful.mongoose
app = express()

app.use express.bodyParser()
app.use express.query() 

mongoose.connect "mongodb://localhost/node-image-manager"

Computer = restful.model "Computer", mongoose.Schema
    name: String,
    ram: Number,
    awesome: Boolean
Computer.methods ["get", "post", "put", "delete"]
Computer.register app, "/computers"

app.listen 3141
