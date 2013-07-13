module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'

    coffee:
      compile:
        files:
          'js/main.js': 'coffee/main.coffee'

    sass:
      dist:
        files:
          'css/style.css': 'sass/style.sass'

    clean: ['js/main.js', 'css/style.css']

    watch:
      scripts:
        files: ['sass/*.sass', 'coffee/*.coffee']
        tasks: ['default']



  contribs = ['coffee', 'sass', 'watch']

  for task in contribs
    grunt.loadNpmTasks "grunt-contrib-#{task}"

  grunt.registerTask 'default', ['sass', 'coffee']
