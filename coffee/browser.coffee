cw.Browser = cw.Modal.extend
    title: 'Open an existing file'

    tagName: 'div'
    className: 'browser'

    render: ->
        cw.Modal.prototype.render.call(this)
        @$('.content')
            .append(JST.browser())
            .append(new cw.FileListView(@entries).render().el)
        this

    entries: []

    load: ->
        cw.client.readdir('/', (error, entries) =>
            if error
                console.log(error)
                return

            @entries = ({name: e} for e in entries)

            @render()
        )

