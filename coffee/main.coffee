$(document).ready ->
    list = new FileList [{name: 'test'}]

    modal = new Modal(model: list)
    modal.$el.appendTo('body')
    modal.render()

    toolbar = new Toolbar()
    toolbar.$el.appendTo('header > .right')
    toolbar.render()

    # Cache references to some DOM elements
    for s in [
        'viewer',
        'dropbox', 'open', 'save',
        'message', 'modal', 'save-message',
        'filename'
    ]
        dom[s.replace('-', '_')] = $ '#' + s
    dom.window = $ window
    dom.shade = $ '.shade'

    # Load the sample document and insert it into the editor
    $.get 'sample.md', (text) -> editor.setValue text

    # Generate the initial document preview
    update()
