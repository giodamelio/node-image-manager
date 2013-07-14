module.exports = (grunt) ->
    # Project configuration.
    grunt.initConfig
        pkg: grunt.file.readJSON("package.json")

    grunt.loadNpmTasks ["grunt-contrib-coffee", "grunt-contrib-watch", "grunt-browserify"]
    
    # Default task(s).
    grunt.registerTask "default", []