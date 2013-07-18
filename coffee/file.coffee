File = Backbone.Model.extend
    defaults:
        name: 'file'
        extension: '.md'

    fullname: -> "#{@get('name')}.#{@get('extension')}"

    initialize: ->
        parts = @get('fullname').split('.')
        @set('name', parts[0])
        @set('extension', parts[1])


cw.FileList = Backbone.Collection.extend
    model: File

cw.FileView = Backbone.View.extend
    tagName: 'li'

    events:
        'click i': 'open'

    render: ->
        @$el.html(JST.file(@model.attributes))
        this

    open: ->
        cw.client.readFile(@model.fullname(), (error, data) ->
            if error
                console.log(error)
                return

            cw.editor.setValue(data)
            cw.browser.close()
        )

cw.FileListView = Backbone.View.extend
    tagName: 'ul'
    className: 'filelist'

    initialize: (entries) ->
        @collection = new cw.FileList(entries)
        @render()

    render: ->
        @$el.empty()
        _.each(@collection.models, ((file) =>
            view = new cw.FileView(model: file)
            @$el.append(view.render().el)
        ), this)

        this
