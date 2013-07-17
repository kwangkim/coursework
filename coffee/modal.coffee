cw.Modal = Backbone.View.extend
    id: 'modal'
    events:
        'click .close': 'close'

    title: 'default'
    content: -> ''
    load: ->

    template: JST.modal()

    initialize: ->
        @load()
        @$el.appendTo('body')
        @render()

    close: ->
        @$el.fadeOut('fast')
        dom.shade.hide()

    render: ->
        @$el.html(@template)
        @$('h2').text(@title)
        @$('.content').html(@content())

        this

    show: ->
        dom.shade.show()
        @$el.centre().fadeIn('fast')
