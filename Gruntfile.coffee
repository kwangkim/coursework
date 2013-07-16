coffees = ['intro', 'client', 'modal', 'editor', 'toolbar', 'main']

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'

    coffee:
      compile:
        files:
          'js/all.js': ("coffee/#{coffee}.coffee" for coffee in coffees)

    sass:
      dist:
        files:
          'css/style.css': 'sass/style.sass'

    clean: ['js/*.js', 'css/*.css']

    watch:
      scripts:
        files: ['sass/*.sass', 'coffee/*.coffee']
        tasks: ['default']

    jst:
      compile:
        files:
          'js/templates/index.js': ['templates/*.html']
      options:
        processName: (filename) -> filename.replace(/templates\/|\.html/gi, '')

    connect:
      server:
        options:
          keepalive: true



  contribs = ['coffee', 'sass', 'watch', 'connect', 'clean', 'jst']

  for task in contribs
    grunt.loadNpmTasks "grunt-contrib-#{task}"

  grunt.registerTask 'default', ['sass', 'coffee']
