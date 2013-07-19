# Setup Ace Editor
$('#editor').height($(window).height() - $('header').height())
cw.editor = ace.edit('editor')
cw.editor.setTheme('ace/theme/monokai')
cw.editor.getSession().setMode('ace/mode/markdown')

# Format ordered lists to use numbers for the top level, letters for the
# second and Roman numerals for the third.
formatLists = ->
    # Get all the ordered lists in the viewer
    dom.viewer.find('ol').each(->
        t = $(this)
        # Find out how many levels of parent lists there are above this one
        level = t.parents().filter('ol, ul').length
        # Assign their type based on this
        type = ['1', 'a', 'i'][level % 3]

        t.attr(type: type)
    )

save_message = (doc) ->
    if doc is ''
        ['', false]
    else
        is_connected = cw.client.isAuthenticated()
        is_named = dom.filename.val() isnt ''

        if is_connected and is_named
            ["All changes saved to Dropbox", false]
        else
            warning = true

            connect_msg = if is_connected then '' else "connect to Dropbox"
            name_msg = if is_named then '' else "name this document"
            connective = if not is_connected and not is_named then ' and ' else ''

            [
                "Warning: changes are not being saved. Please " +
                connect_msg + connective + name_msg +
                " to save your work.",
                true
            ]

# Callback for when the document changes
cw.update = (delta) ->
    doc = cw.editor.getValue()
    # Re-render Markdown and update viewer
    dom.viewer.html(marked(doc))
    # Format ordered lists
    formatLists()
    # Re-render equations
    MathJax.Hub.Queue(['Typeset', MathJax.Hub, 'viewer'])

    localStorage.currentDoc = JSON.stringify({
        name: dom.filename.val()
        contents: doc
    })

    # Update the status message to inform the user about whether or not the
    # document has been saved
    [msg, warning] = save_message(doc)
    dom.save_message.css({color: if warning then '#a00' else '#aaa'})
    dom.save_message.text(msg)

# Only render the document at most once a second
delay = 1000

throttled = _.throttle(cw.update, delay)

cw.editor.on('change', throttled)
