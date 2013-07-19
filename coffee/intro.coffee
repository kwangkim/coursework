# Object to store cached DOM elements
window.dom = {}

# Global namespace
window.cw = {}

(($) ->
    $.fn.centre = ->
        this.css(left: (dom.window.width() - this.width()) / 2)
        this
)(jQuery)

# Display a message to the user.
window.alert = (text) ->
    dom.message
        .text(text).centre().fadeIn('fast').delay(2000).fadeOut('slow')

# Set any final Markdown rendering options that can't be changed by the user
# here -- optional ones go in settings.coffee
marked.setOptions
    # Ignore inline HTML -- it's not needed for writing prose and <script>
    # tags break things
    sanitize: yes
    # Add the callback for syntax highlighting
    highlight: (code, lang) ->
        hljs.highlightAuto(code).value
