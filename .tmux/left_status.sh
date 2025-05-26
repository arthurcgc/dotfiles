#!/bin/bash

function my_func() {
    # source .tmux/venv/bin/activate
    python3 .tmux/tmux_python_script.py
}

function main() {
    # Comment out any function you do not need. 
    my_func
}

# Calling the main function which will call the other functions.
main
