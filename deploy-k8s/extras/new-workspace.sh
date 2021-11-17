#!/bin/sh

# This creates a new workspace file and opens it in 
# VS Code, if you have it installed

cp workspaces/ben.yaml workspaces/new.yaml

if command -v code &> /dev/null; then
    code workspaces/new.yaml
fi