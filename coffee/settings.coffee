cw.Settings = Backbone.Model.extend
    defaults:
        editor:
            color_scheme: 'monokai'

        markdown:
            smartypants: true

        latex:
            delimiters:
                start: '$'
                end: '$'



cw.SettingsView = cw.Modal.extend
    id: 'settings'

    model: cw.Settings

    initialize: ->
        cw.Modal.prototype.initialize.call(this)

        @$('#scheme').val(@model.get('editor').color_scheme)
        @$('#smartypants').prop('checked', @model.get('markdown').smartypants)
        @$('#delim-start').val(@model.get('latex').delimiters.start)
        @$('#delim-end').val(@model.get('latex').delimiters.end)

    render: ->
        cw.Modal.prototype.render.call(this)
        @$('.content').html(JST.settings())

    title: 'Settings'
