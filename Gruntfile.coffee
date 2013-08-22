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
                dest: '<%= css_root%>/app.css'
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
                    name: "entry"
                    optimize: "none"
                    mainConfigFile: "<%= js_root%>/requirejs-config.js"
                    out: "<%= js_root %>/app.js"
            production:
                options:
                    baseUrl: "<%= js_root %>"
                    name: "entry"
                    optimize: "uglify2"
                    mainConfigFile: "<%= js_root %>/requirejs-config.js"
                    out: "<%= js_root %>/app.min.js"
        qunit:
            all: ['<%= js_root %>/tests/**/*.html']
        watch:
            css:
                options:
                    livereload: true
                files: ['<%= less_root %>/**/*.less']
                tasks: ['less:development']
            html:
                options:
                    livereload: true
                    port: 35728
                files: ['**/*.html']
            js:
                options:
                    livereload: true
                    port: 35727
                files: ['<%= coffee_root%>/**/*.coffee']
                tasks: ['coffee', 'requirejs:development']

    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-less'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-requirejs'
    grunt.loadNpmTasks 'grunt-contrib-qunit'

    grunt.registerTask 'default', ['less:development', 'coffee', 'qunit', 'requirejs:development']
    grunt.registerTask 'production', ['less:production', 'coffee', 'qunit', 'requirejs:production']
    grunt.registerTask 'test', ['qunit']
