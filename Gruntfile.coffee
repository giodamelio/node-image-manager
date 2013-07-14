module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON("package.json")

        coffee:
            server:
                files: [
                    expand: true
                    cwd: "./src/server/"
                    src: ["**/*.coffee"]
                    dest: "./lib/server/"
                    ext: ".js"
                ]
            client:
                files: [
                        expand: true
                        cwd: "./src/client/"
                        src: ["**/*.coffee"]
                        dest: "./lib/client/"
                        ext: ".js"
                    ]
        watch:
            server:
                files: "./src/server/**/*.coffee"
                tasks: ["coffee:server"]
            client:
                files: "./static/**/*"
                options:
                    livereload: true
            browserify:
                files: "./src/client/**/*.coffee" 
                tasks: ["coffee:client", "browserify:client"]
        browserify:
            client:
                src: ["./lib/client/**/*.js"]
                dest: "./static/bundle.js"
        nodemon:
            server:
                options:
                    file: "./lib/server/index.js"
                    watchedExtensions: ["js"]
                    watchedFolders: ["./lib/server"]
        concurrent:
            tasks: ["nodemon", "watch"]
            options:
                logConcurrentOutput: true

    grunt.loadNpmTasks "grunt-contrib-coffee"
    grunt.loadNpmTasks "grunt-contrib-watch"
    grunt.loadNpmTasks "grunt-browserify"
    grunt.loadNpmTasks "grunt-nodemon"
    grunt.loadNpmTasks "grunt-concurrent"
        
    grunt.registerTask "default", ["concurrent"]

