$(document).ready ->
    # list = new FileList [{name: 'test'}]

    modal = new cw.Modal()
    modal.$el.appendTo('body')
    modal.render()

    toolbar = new cw.Toolbar()
    toolbar.$el.appendTo('header > .right')
    toolbar.render()

    elements = [
        'viewer',
        'dropbox', 'open', 'save',
        'message', 'modal', 'save-message',
        'filename'
    ]

    # Cache references to some DOM elements
    window.dom[el.replace('-', '_')] = $('#' + el) for el in elements

    window.dom.window = $ window
    window.dom.shade = $ '.shade'

    # Load the sample document and insert it into the editor
    $.get('sample.md', (text) -> cw.editor.setValue(text))

    # Generate the initial document preview
    cw.update()
