# Source files. Order matters.
coffees = ['intro', 'client', 'modal', 'browser', 'settings', 'editor', 'toolbar', 'main']

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'

      my_target:
        files:
          'build/js/vendor.js': [
            'vendor/jquery/jquery.js'
            'vendor/underscore/underscore.js'
            'vendor/backbone/backbone.js'
            'vendor/marked/lib/marked.js'
            'vendor/dropbox/dropbox.js'
            'vendor/highlightjs/highlight.pack.js'
          ]

    coffee:
      compile:
        files:
          'js/all.js': ("coffee/#{coffee}.coffee" for coffee in coffees)

    sass:
      dist:
        files:
          'css/style.css': 'sass/style.sass'

    clean: ['js/*.js', 'css/*.css', 'build']

    watch:
      scripts:
        files: ['sass/*.sass', 'coffee/*.coffee', 'templates/*.html']
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

    copy:
      main:
        files: [
          expand: true
          src: [
            # App stuff
            'index.html'
            'js/**'
            'css/**'
            'sample.md'

            # Vendor stuff
            # LaTeX don't come cheap
            'vendor/MathJax/MathJax.js'
            'vendor/MathJax/config/TeX-AMS-MML_HTMLorMML.js'
            'vendor/MathJax/extensions/MathMenu.js'
            'vendor/MathJax/extensions/MathZoom.js'
            'vendor/MathJax/images/MenuArrow-15.png'
            'vendor/MathJax/jax/output/HTML-CSS/jax.js'
            'vendor/MathJax/jax/output/HTML-CSS/fonts/STIX/fontdata.js'
            'vendor/MathJax/jax/output/HTML-CSS/fonts/STIX/fontdata-1.0.js'

            # Ace stuff
            'vendor/ace-builds/src/ace.js'
            'vendor/ace-builds/src/theme-monokai.js'
            'vendor/ace-builds/src/mode-markdown.js'

            # CSS and fonts
            'vendor/font-awesome/css/font-awesome.min.css'
            'vendor/font-awesome/font/*'
            'vendor/normalize-css/normalize.css'
            'vendor/highlightjs/styles/github.css'
          ]
          dest: 'build'
        ]

  contribs = ['coffee', 'sass', 'watch', 'connect', 'clean', 'jst', 'copy', 'uglify']

  for task in contribs
    grunt.loadNpmTasks "grunt-contrib-#{task}"

  grunt.registerTask 'default', ['sass', 'coffee', 'jst']
  grunt.registerTask 'build', ['default', 'copy', 'uglify']
