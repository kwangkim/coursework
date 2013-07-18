# Coursework

## What is this?

Coursework is a text editor for writing technical documents, using Markdown for simple markup, and LaTeX for typesetting mathematical equations.

## What does it do?

It basically just ties together [Ace Editor][], [Marked][] and [MathJax][] and adds a couple of buttons.

## How do I use it?

Type code in the editor on the left, see results in realtime in the viewer on the right. To save files you'll need to connect to Dropbox. You can use it [online][] or run a local copy.

One caveat if you're using the hosted version: the Dropbox API requires HTTPS URLs, which GitHub Pages doesn't support, so you'll need to put an `s` in the URL if you want to connect to Dropbox. This will give you a security warning.

## How do I get it?

### Download a build

Download [this][], extract it, run a server (`python -m SimpleHTTPServer` or something), then open the URL you're serving in the browser.

### Build from scratch

Make sure you have Git and Node installed and are on some sort of Unix, then run:

    git clone https://github.com/lavelle/coursework.git
    cd coursework
    setup.sh

The app will *not* work from `file://` URLs, so you must run a server. To start the inbuilt server run `grunt connect`. This will serve at `http://localhost:8000/`. If you change the port or hostname the Dropbox API calls won't work.

If this is an insurmountable problem file an issue and I'll add a new URL to the app's config. The only other valid URL right now is `http://localhost/coursework/`, in case you're serving your `~/code` out of Apache or something.

## Why is this?

I wanted to move to an all-digital solution for taking notes in lectures. I have to write lots of equations down, so I needed something for typesetting maths, but I also wanted a clean syntax for regular markup. LaTeX and Markdown fill these roles respectively, but I couldn't find anything that let you use both, and had a realtime preview.

## Credits
- [Ace Editor][]
- [MathJax][]
- [Marked][]
- [Highlight.js][]
- [Dropbox.js][]
- [Normalize.css][]
- [Font Awesome][]
- [Backbone][]
- [Underscore][]
- [jQuery][]

[online]: http://lavelle.github.io/coursework
[this]: https://github.com/lavelle/coursework/archive/gh-pages.zip

[ace editor]:    http://ace.ajax.org/
[marked]:        https://github.com/chjj/marked
[mathjax]:       http://www.mathjax.org/
[highlight.js]:  https://github.com/isagalaev/highlight.js
[dropbox.js]:    https://github.com/dropbox/dropbox-js
[normalize.css]: http://necolas.github.io/normalize.css/
[font awesome]:  http://fortawesome.github.io/Font-Awesome/
[Backbone]:      http://backbonejs.org/
[Underscore]:    http://underscorejs.org/
[jquery]:        http://jquery.com/

## Changelog

### 0.0.2

- Added basic support for browsing and opening files.
- Switched from Sass to Stylus
- Fixed some layout bugs

### 0.0.1

- Initial release

## License

MIT licensed

Copyright (c) 2013 Giles Lavelle
