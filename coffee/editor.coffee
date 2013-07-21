# Setup Ace Editor
$w = $(window)
$e = $('#editor')
$v = $('#viewer')
$h = $('header')
$r = $('#resizer')

cw.editor = ace.edit('editor')
cw.editor.setTheme('ace/theme/monokai')

session = cw.editor.getSession()
session.setMode('ace/mode/markdown')
session.setUseWrapMode(true)

# Constants
min_width = 250
half_min = min_width / 2
resizer_width = 10
half_rw = resizer_width / 2
viewer_padding = 30
twice_vp = viewer_padding * 2
header_height = 50
ratio = 0.5

# Make the resize bar draggable
$r.draggable
    # Constrain to horizontal movement
    axis: 'x'
    # Keep the cursor in the middle
    cursorAt:
        left: half_rw
    # Don't let it leave the page
    containment: 'document'
    # Callback for the drag event
    drag: (e) ->
        # Cache window dimensions
        width = $w.width()
        height = $w.height()

        # Do nothing if either panel is at the minimum width
        if e.clientX < min_width or e.clientX > width - min_width
            return false

        pos =
            top: header_height
            left: e.clientX - half_rw

        # Update the dimensions of the panels
        $e.width(pos.left)
        $v.width(width - pos.left - 60)
            .height(height)
            .offset(pos)

        # Tell Ace about the resize so it can recalculate internal element sizes
        cw.editor.resize(false)

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

$e.on('dragenter', ->
    return false
)

$e.on('dragexit', ->
    return false
)

$e.on('dragover', ->
    return false
)

$e.on('drop', (event) ->
    console.log(event)
    file = event.originalEvent.dataTransfer.files[0]

    if file? and ['md', 'tex'].indexOf(file.name.split('.').pop()) isnt -1
        reader = new FileReader()

        reader.onload = (event) ->
            cw.editor.setValue(event.target.result)
            dom.filename.val(file.name.split('.')[0])

        reader.readAsText(file)
    return false
)

# Only render the document at most once a second
delay = 1000

# Create a new throttled function limited to the delay
throttled = _.throttle(cw.update, delay)

# Bind it to the editor change
cw.editor.on('change', throttled)

width = Math.max($w.width() * ratio, min_width)
height = $w.height()

for panel in [$e, $v]
    panel.width(width).height(height)

pos =
    top: header_height
    left: width

$r.offset(pos).height(height)
$v.offset(pos)
