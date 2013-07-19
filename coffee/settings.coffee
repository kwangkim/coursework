cw.Settings = Backbone.DeepModel.extend
    defaults:
        editor:
            color_scheme: 'monokai'

        # Options for Markdown rendering
        markdown:
            # Enable SmartyPants for nice quotes and dashes
            smartypants: true
            # Enable the GFM line break behaviour
            breaks: on
            # Enable smarter list behaviour
            smartLists: yes

        latex:
            delimiters:
                start: '$'
                end: '$'

    initialize: ->
        @bind('change:markdown.*', @set_markdown)
        @bind('change:latex.*', @set_latex)

    set_markdown: ->
        marked.setOptions(@get('markdown'))

        # Render the page again using the new settings
        cw.update()


    set_latex: ->
        delims = @get('latex.delimiters')
        MathJax.Hub.Config
            tex2jax:
                inlineMath: [[delims.start, delims.end], ['\\(', '\\)']]



cw.SettingsView = cw.Modal.extend
    id: 'settings'
    title: 'Settings'
    model: cw.Settings

    save: ->
        @model.set
            'editor.color_scheme':    @$('#scheme').val()
            'markdown.smartypants':   @$('#smartypants').prop('checked')
            'latex.delimiters.start': @$('#delim-start').val()
            'latex.delimiters.end':   @$('#delim-end').val()

    initialize: ->
        cw.Modal.prototype.initialize.call(this)

        events =
            'click #save': 'save'

        @events = _.extend(@events, events)

        @$('#scheme').val(@model.get('editor').color_scheme)
        @$('#smartypants').prop('checked', @model.get('markdown').smartypants)
        @$('#delim-start').val(@model.get('latex').delimiters.start)
        @$('#delim-end').val(@model.get('latex').delimiters.end)

    render: ->
        cw.Modal.prototype.render.call(this)
        @$('.content').html(JST.settings())

cw.settings = new cw.SettingsView(model: new cw.Settings())
