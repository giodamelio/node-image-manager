fs = require "fs"

watch = require "watch"

# Paths
basePath = "node_modules/.bin/"
coffeePath = basePath + "coffee"
browserifyPath = basePath + "browserify"
nodemonPath = basePath + "nodemon"

spawn = (cmd, options) ->
    child_process = require "child_process"
    p = child_process.spawn cmd, options
    p.stdout.on "data", (data) ->
        process.stdout.write data.toString()

desc "Default task."
task "default", ->
    console.log "Hello World"

desc "Start the server."
task "server", async: true, ->
    console.log "Starting the server..."
    spawn "node", ["lib/server/index.js"]

namespace "coffee", ->
    desc "Compile all the coffeescript."
    task "all", ->
        console.log "Compiling all the coffeescript..."
        jake.Task["coffee:server"].execute()
        jake.Task["coffee:client"].execute()

    desc "Compile the server coffeescript."
    task "server", ->
        console.log "Compiling server coffeescript..."
        spawn coffeePath, ["--compile", "--output", "lib/server/", "src/server/"]

    desc "Compile the client coffeescript."
    task "client", ->
        console.log "Compiling client coffeescript..."
        spawn coffeePath, ["--compile", "--output", "lib/client/", "src/client/"]

namespace "browserify", ->
    desc "Compile the client browserify."
    task "client", ->
        console.log "Compiling client browserify..."
        spawn browserifyPath, ["--outfile", "static/bundle.js", "--entry", "lib/client/main.js"]

namespace "watch", ->
    desc "Watch everything."
    task "all", ->
        jake.Task["watch:coffee:all"].execute()
        jake.Task["watch:browserify:client"].execute()
        jake.Task["watch:server"].execute()

    namespace "coffee", ->
        desc "Watch and auto-compile all the coffeescript."
        task "all", async: true, ->
            jake.Task["watch:coffee:server"].execute()
            jake.Task["watch:coffee:client"].execute()

        desc "Watch and auto-compile server coffeescript."
        task "server", async: true, ->
            watch.watchTree "src/server/", (file, curr, prev) ->
                jake.Task["coffee:server"].execute()
                console.log "Waiting and watching..."

        desc "Watch and auto-compile client coffeescript."
        task "client", async: true, ->
            watch.watchTree "src/client/", (file, curr, prev) ->
                jake.Task["coffee:client"].execute()
                console.log "Waiting and watching..."

    namespace "browserify", ->
        desc "Watch and auto-compile the client browserify."
        task "client", async: true, ->
            watch.watchTree "lib/client/", (file, curr, prev) ->
                jake.Task["browserify:client"].execute()
                console.log "Waiting and watching..."

    desc "Watch and auto-reload the server."
    task "server", ->
        console.log "Watching the server..."
        spawn nodemonPath, ["--watch", "lib/server", "lib/server/index.js"]


