cw.Settings = cw.Modal.extend
    className: 'settings'

    render: ->
        cw.Modal.prototype.render.call(this)
        @$('.content').html(JST.settings())

    title: 'Settings'
