$(document).ready ->
    elements = [
        'viewer', 'message', 'save-message', 'filename'
    ]

    # Cache references to some DOM elements
    window.dom[el.replace('-', '_')] = $('#' + el) for el in elements

    window.dom.window = $ window
    window.dom.shade = $ '.shade'

    # Load the sample document and insert it into the editor
    $.get('sample.md', (text) -> cw.editor.setValue(text))

    # Trigger a change in the settings model to apply the defaults on page load
    cw.settings.model.trigger('change:markdown.* change:latex.*')

    # Generate the initial document preview
    cw.update()
