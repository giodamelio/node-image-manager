{spawn} = require "child_process"

coffeePath = __dirname + "/node_modules/.bin/coffee"

task "coffee:watch", "watch and auto-compile the coffeescript", (options) ->
    watcher = spawn coffeePath, ["-wc", "-o", "lib", "src"]
    watcher.stdout.on "data", (data) ->
        process.stdout.write data.toString()
