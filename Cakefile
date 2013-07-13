{spawn} = require "child_process"

coffeePath = __dirname + "/node_modules/.bin/coffee"
nodemonPath = __dirname + "/node_modules/.bin/nodemon"
browserifyPath = __dirname + "/node_modules/.bin/browserify"

task "watch", "watch and auto-run the app", (options) ->
    watcher = spawn nodemonPath, ["lib/server/index.js"]
    watcher.stdout.on "data", (data) ->
        process.stdout.write data.toString()

task "coffee:watch", "watch and auto-compile the coffeescript", (options) ->
    watcher = spawn coffeePath, ["-wc", "-o", "lib", "src"]
    watcher.stdout.on "data", (data) ->
        process.stdout.write data.toString()

task "browserify:watch", "watch and auto-build browserify", (options) ->
    browserifyCmd = browserifyPath + " lib/client/main.js -o"
    watcher = spawn nodemonPath, ["-x", browserifyCmd, "static/bundle.js"]
    watcher.stdout.on "data", (data) ->
        process.stdout.write data.toString()

