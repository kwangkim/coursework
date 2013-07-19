cw.Toolbar = Backbone.View.extend
    tagName: 'nav'

    events:
        'click #dropbox': 'connect'
        'click #open': 'open'
        'click #save': 'save'
        'click #export': 'export'
        'click #settings': 'settings'

    initialize: ->
        @render()
        @$el.appendTo('header > .right')

    render: ->
        @$el.html(JST.toolbar())
        this

    connect: -> cw.auth()

    open: ->
        cw.browser.show()

    # Save the current document to Dropbox.
    save: ->
        if not cw.client?
            alert 'Please connect to Dropbox to save documents.'
            return

        filename = dom.filename.val()

        if not filename
            alert 'Please name this document before saving.'
            return

        filename += '.md'

        cw.client.writeFile filename, cw.editor.getValue(), (error, stat) ->
            if error
                alert 'Error: could not save file.'
                console.log error
                return

            alert "File saved as #{filename}."

    settings: ->
        cw.settings.show()

cw.toolbar = new cw.Toolbar()

