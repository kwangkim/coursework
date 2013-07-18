File = Backbone.Model.extend
    defaults:
        name: 'test'

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
        cw.client.readFile(@model.get('name'), (error, data) ->
            if error
                console.log(error)
                return

            cw.editor.setValue(data)
            cw.browser.close()
        )

cw.FileListView = Backbone.View.extend
    tagName: 'ul'
    className: 'filelist'

    initialize: (e) ->
        console.log(e)
        @collection = new cw.FileList(e)
        @render()

    render: ->
        @$el.empty()
        _.each(@collection.models, ((file) =>
            view = new cw.FileView(model: file)
            @$el.append(view.render().el)
        ), this)

        this
