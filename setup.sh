#! /bin/bash

echo "This script requires you to have Node.js, npm and Sass installed."
echo "If you run those programs with sudo, you'll to run this script with sudo too."
echo "If you've done all of that, we can proceed."
echo "Run the script? (y/n)"
read answer

if [ $answer != "y" ]; then
    echo "Exiting."
    exit
fi

echo "This script will globally install Bower and Grunt"
echo "Proceed? (y/n)"
read answer

if [ $answer = "y" ]; then
    echo "Installing global npm modules."
    npm install -g bower grunt-cli
else
    echo "Exiting."
    exit
fi

if [[ echo $? = "3" ]]; then
    echo "npm install failed. You need to be root."
    echo "Try running sudo tools/setup.sh"
fi

echo "Installing local npm modules."
npm install

echo "Installing client-side third-party dependencies."
bower install

echo "Building Coursework."
grunt coffee sass jst

echo "Done. Make sure to run a local server to view Coursework in the browser."
