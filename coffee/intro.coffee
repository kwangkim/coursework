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

# Set options for Markdown rendering
marked.setOptions
    # Enable SmartyPants for nice quotes and dashes
    smartypants: on
    # Enable the GFM line break behaviour
    breaks: on
    # Ignore inline HTML -- it's not needed for writing prose and <script>
    # tags break things
    sanitize: yes
    # Enable smarter list behaviour
    smartLists: yes
    # Add the callback for syntax highlighting
    highlight: (code, lang) ->
        hljs.highlightAuto(code).value
