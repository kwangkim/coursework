#! /bin/bash

echo "This script will globally install Bower, Dependant and CoffeeScript."
echo "Proceed? (y/n)"
read answer

if [ $answer = "y" ]; then
    echo "Installing global NPM modules."
    npm install -g bower dependant coffee-script
else
    echo "Exiting."
    exit
fi

echo "Installing third-party dependencies."
bower install
# Hopefully these will be in Bower soon and these lines can be removed
bower install mathjax/MathJax
bower install https://cdnjs.cloudflare.com/ajax/libs/dropbox.js/0.9.2/dropbox.min.js

echo "Compiling templates."
tools/templates.py

echo "Compiling CoffeeScript/Sass"
make compile

echo "Done. Make sure to run a local server to view Coursework in the browser."
