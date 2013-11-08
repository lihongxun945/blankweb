exec = require("child_process").exec
module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'
        assets: 'assets'
        js_root: '<%= assets %>/js'
        coffee_root: '<%= assets %>/coffee'
        css_root: '<%= assets %>/css'
        less_root: '<%= assets %>/less'
        less:
            development:
                src: '<%= less_root %>/entry.less'
                dest: '<%= css_root %>/app.css'
            production:
                options:
                    compress: true
                src: '<%= less_root%>/entry.less'
                dest: '<%= css_root%>/app.min.css'
        coffee:
            compile:
                expand: true
                cwd: '<%= coffee_root%>'
                src: ['**/*.coffee']
                dest: '<%= js_root %>'
                ext: '.js'

        requirejs:
            development:
                options:
                    baseUrl: "<%= js_root %>"
                    name: "almond"
                    optimize: "none"
                    include: 'entry'
                    insertRequire: ['entry']
                    mainConfigFile: "<%= js_root%>/requirejs-config.js"
                    out: "<%= js_root %>/app.js"
                    wrap: true
            production:
                options:
                    baseUrl: "<%= js_root %>"
                    name: "almond"
                    include: 'entry'
                    insertRequire: ['entry']
                    optimize: "uglify2"
                    mainConfigFile: "<%= js_root %>/requirejs-config.js"
                    out: "<%= js_root %>/app.min.js"
                    wrap: true
        qunit:
            all: ['<%= js_root %>/tests/**/*.html']
        watch:
            options:
                livereload: true
            css:
                files: ['<%= less_root %>/**/*.less']
                tasks: ['less:development']
            html:
                files: ['**/*.html']
            js:
                files: ['<%= coffee_root%>/**/*.coffee']
                tasks: ['coffee']
                #tasks: ['coffee', 'requirejs:development']

    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-less'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-requirejs'
    grunt.loadNpmTasks 'grunt-contrib-qunit'

    grunt.registerTask 'glue', 'create sprite', ->
        done = this.async()
        child = exec 'cd assets && glue icon --less --css less --img sprite', (e)-> done()

    grunt.registerTask 'default', ['less:development', 'coffee', 'qunit', 'requirejs:development', 'glue']
    grunt.registerTask 'production', ['less:production', 'coffee', 'qunit', 'requirejs:production', 'glue']
    grunt.registerTask 'test', ['qunit']
