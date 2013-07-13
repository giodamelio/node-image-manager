var express = require("express");
var url = require("url");
var swagger = require("swagger-node-express");

var app = express();
app.use(express.bodyParser());
app.use("/", express.static(__dirname + "/static"));

swagger.configureSwaggerPaths("", "/api", "");
swagger.setAppHandler(app);

var helloWorldModel = {
    "models": {
        "HelloWorld": {
            "id": "HelloWorld",
            "properties": {
                "name": {
                    "type": "string",
                    "required": true
                }
            }
        }
    }
};

var helloWorld = {
    "spec": {
        "description" : "Say Hello World!",
        "path" : "/helloworld/{name}",
        "notes" : "Says hello world!",
        "summary" : "Says hello world to you!",
        "method": "GET",
        "params" : [
            swagger.pathParam("name", "Your name.", "string")
        ],
        "responseClass" : "HelloWorld",
        "errorResponses" : [
            swagger.errors.notFound("helloWorld")
        ],
        "nickname" : "helloWorld"
    },
    "action": function (req,res) {
        if (!req.params.name) {
            throw swagger.errors.invalid("name");
        }
        res.send(JSON.stringify({message: "Hello " + req.params.name}));
    }
};

swagger.addModels(helloWorldModel)
    .addGet(helloWorld);

console.log("Listening on 'http://localhost:3141'");
swagger.configure("http://localhost:3141", "0.1");
app.listen(3141);
