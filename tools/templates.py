#!/usr/bin/env python

# Script for compiling HTML templates into JSTs (JavaScript files that store)
# the HTML as a string in a global object to be inserted into the DOM when
# needed

# A list of pairs of the form (file, templates), where file is the name of
# a HTML file to generate a JST for, and templates is a list of template names,
# without the .html extension
builds = [
    ('index', 'modal,toolbar,settings')
]

template_path = 'templates/%s.html'
jst_path = 'js/templates/%s.js'

def build():
    for config in builds:
        name = config[0]
        templates = config[1].split(',')
        output = "window.JST = {};\n\n"

        for template in templates:
            if template:
                path = template_path % template
                content = open(path).read().replace('"', '\\"').replace("\n", "")
                content = """window.JST["%s"] = "%s";\n""" % (template, content)
                output += content

        out = open(jst_path % name, 'w')
        out.write(output)
        out.close()


if __name__ == '__main__':
    build()
