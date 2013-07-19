$(document).ready ->
    elements = [
        'viewer', 'message', 'save-message', 'filename'
    ]

    # Cache references to some DOM elements
    window.dom[el.replace('-', '_')] = $('#' + el) for el in elements

    window.dom.window = $ window
    window.dom.shade = $ '.shade'

    # Try and restore the document the user was previously editing
    restore = ->
        return null unless window.localStorage and localStorage.currentDoc
        try
            return JSON.parse(localStorage.currentDoc)
        catch e
            return null

    doc = restore()

    # If there's a valid document, load it into the editor
    if doc
        cw.editor.setValue(doc.contents)
        dom.filename.val(doc.name)
    # If there's no previous document or it's invalid, load the sample document
    # and insert it into the editor
    else
        $.get('sample.md', (text) -> cw.editor.setValue(text))

    # Trigger a change in the settings model to apply the defaults on page load
    cw.settings.model.trigger('change:markdown.* change:latex.*')

    # Generate the initial document preview
    cw.update()
