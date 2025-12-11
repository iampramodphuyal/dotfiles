#! /bin/bash

FILE_PATH="$HOME/Pictures/Screenshots/"

set_path(){
echo "var: $1"
}

case "$1" in 
    --path)
        set_path()
    ;;
esac
