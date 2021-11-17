#!/bin/sh

# This creates a new image folder and opens it in 
# VS Code, if you have it installed

cp -r images/frontend images/new

if command -v code &> /dev/null; then
    code images/new/Dockerfile
fi