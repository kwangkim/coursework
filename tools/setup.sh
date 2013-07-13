#! /bin/bash

# Install Volo for package managing
npm install -g volo
# Install libraries
volo install
# Tidy up libraries
make clean

mkdir css js
# Compile CoffeeScript and Sass
make compile
