File = Backbone.Model.extend
    defaults:
        name: ''

FileList = Backbone.Collection.extend
    model: File

cw.Browser = cw.Modal.extend
    title: 'Open an existing file'

    content: -> JST.browser(entries: @entries)

    entries: []

    load: ->
        # @listenTo @entries, 'change', @render
        cw.client.readdir('/', (error, entries) =>
            if error
                console.log(error)
                return

            @entries = entries

            @render()
        )
