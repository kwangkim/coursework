#! /bin/bash

echo "This script will globally install Bower, Dependant and CoffeeScript."
echo "Proceed? (y/n)"
read answer

if [ $answer = "y" ]; then
    echo "Installing global npm modules."
    npm install -g bower dependant coffee-script
else
    echo "Exiting."
    exit
fi

if [ echo $? == "3" ]; then
    echo "npm install failed. You need to be root."
    echo "Try running sudo tools/setup.sh"
fi

echo "Installing local npm modules."
npm install

echo "Installing client-side third-party dependencies."
bower install
# Hopefully these will be in the Bower registry soon and this line can be removed
bower install mathjax/MathJax lavelle/dropbox

echo "Compiling templates."
tools/templates.py

echo "Compiling CoffeeScript/Sass"
make compile

echo "Done. Make sure to run a local server to view Coursework in the browser."
