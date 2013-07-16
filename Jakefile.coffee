fs = require "fs"

watch = require "watch"

# Paths
basePath = "node_modules/.bin/"
coffeePath = basePath + "coffee"
browserifyPath = basePath + "browserify"
nodemonPath = basePath + "nodemon"
mochaPath = basePath + "mocha"

spawn = (cmd, options) ->
    child_process = require "child_process"
    p = child_process.spawn cmd, options
    p.stdout.on "data", (data) ->
        process.stdout.write data.toString()

desc "Default task."
task "default", ->
    jake.Task["watch:all"].execute()

desc "Start the server."
task "server", ->
    console.log "Starting the server..."
    child_process = require "child_process"
    p = child_process.spawn "node", ["server/lib/index.js"]
    # Hacky solution to make the tests run after the server has started
    first = true
    here = @
    p.stdout.on "data", (data) ->
        process.stdout.write data.toString()
        if first
            here.emit "gogogo"
            first = false
    here.on "killkillkill", ->
        p.kill(0)

namespace "coffee", ->
    desc "Compile all the coffeescript."
    task "all", ->
        console.log "Compiling all the coffeescript..."
        jake.Task["coffee:server"].execute()
        jake.Task["coffee:client"].execute()

    desc "Compile the server coffeescript."
    task "server", ->
        console.log "Compiling server coffeescript..."
        spawn coffeePath, ["--compile", "--output", "server/lib/", "server/src/"]

    desc "Compile the client coffeescript."
    task "client", ->
        console.log "Compiling client coffeescript..."
        spawn coffeePath, ["--compile", "--output", "client/lib/", "client/src/"]

namespace "browserify", ->
    desc "Compile the client browserify."
    task "client", ->
        console.log "Compiling client browserify..."
        spawn browserifyPath, ["--outfile", "client/bundle.js", "--entry", "client/lib/main.js"]

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
            watch.watchTree "server/src/", (file, curr, prev) ->
                jake.Task["coffee:server"].execute()
                console.log "Waiting and watching..."

        desc "Watch and auto-compile client coffeescript."
        task "client", async: true, ->
            watch.watchTree "client/src/", (file, curr, prev) ->
                jake.Task["coffee:client"].execute()
                console.log "Waiting and watching..."

    namespace "browserify", ->
        desc "Watch and auto-compile the client browserify."
        task "client", async: true, ->
            watch.watchTree "client/lib/", (file, curr, prev) ->
                jake.Task["browserify:client"].execute()
                console.log "Waiting and watching..."

    desc "Watch and auto-reload the server."
    task "server", ->
        console.log "Watching the server..."
        spawn nodemonPath, ["--watch", "server/lib/", "server/lib/index.js"]

namespace "test", ->
    desc "Run the server tests"
    task "server", ->
        server = jake.Task["server"]
        # Hacky solution to make the tests run after the server has started
        server.on "gogogo", ->
            child_process = require "child_process"
            p = child_process.spawn mochaPath, "--require should --reporter spec --compilers coffee:coffee-script --colors server/test".split " "
            p.stdout.on "data", (data) ->
                process.stdout.write data.toString()
            p.on "exit", ->
                # Kill the server
                server.emit "killkillkill"
        server.execute()
        
