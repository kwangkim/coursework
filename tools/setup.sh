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

echo "Compiling templates."
tools/templates.py

echo "Compiling CoffeeScript/Sass"
make compile

echo "Done. Make sure to run a local server to view Coursework in the browser."
