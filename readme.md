# Coursework

## What is this?

Coursework is a text editor for writing technical documents, using Markdown for simple markup, and LaTeX for typesetting mathematical equations.

## What does it do?

It basically just ties together [Ace Editor][], [Marked][] and [MathJax][] and adds a couple of buttons.

## How do I use this?

Type code in the editor on the left, see results in realtime in the viewer on the right. To save files you'll need to connect to Dropbox. You can use it [online][] or run a local copy.

## How do I get it?

### Download a build

Coming soon

### Build from scratch

Assuming you have Git, Node, Sass and CoffeeScript and are using some sort of Unix:

    # Get the code
    git clone https://github.com/lavelle/coursework.git
    cd coursework

    # Install Volo for package managing
    [sudo] npm install -g volo

    volo install     # Install libraries
    make clean       # Tidy up libraries
    make compile     # Compile CoffeeScript and Sass
    open index.html  # Use it (use 'see' instead of 'open' on Debian-based systems)

## Why is this?

I wanted to move to an all-digital solution for taking notes in lectures. I have to write lots of equations down, so I needed something for typesetting maths, but I also wanted a clean syntax for regular markup. LaTeX and Markdown fill these roles respectively, but I couldn't find anything that let you use both, and had a realtime preview.

Written using CoffeeScript and Sass for bonus hipster points.

## Credits
- [Ace Editor][]
- [MathJax][]
- [Marked][]
- [Highlight.js][]
- [Dropbox.js][]
- [Normalize.css][]
- [Font Awesome][]
- [Require.js][]
- [Backbone][]
- [Underscore][]
- [jQuery][]

[online]: http://lavelle.github.io/coursework

[ace editor]:    http://ace.ajax.org/
[marked]:        https://github.com/chjj/marked
[mathjax]:       http://www.mathjax.org/
[highlight.js]:  https://github.com/isagalaev/highlight.js
[dropbox.js]:    https://github.com/dropbox/dropbox-js
[normalize.css]: http://necolas.github.io/normalize.css/
[font awesome]:  http://fortawesome.github.io/Font-Awesome/
[require.js]:    http://requirejs.org/
[Backbone]:      http://backbonejs.org/
[Underscore]:    http://underscorejs.org/
[jquery]:        http://jquery.com/

## License

MIT licensed

Copyright (c) 2013 Giles Lavelle
