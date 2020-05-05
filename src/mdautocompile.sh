#!/bin/bash
FILE=$1
if [ -z $1 ]; then
    echo "Please specify a md file"
    exit 1
fi

#function compile_and_show(){
#    pandoc -f markdown -t latex -o $PDF_FILE $FILE
#    echo "Created file"
#    zathura $PDF_FILE
#}

PDF_FILE=$(echo $FILE | sed 's/\.md$/\.pdf/g')
COMPILE="pandoc -f markdown -t latex --pdf-engine=xelatex -o $PDF_FILE $FILE"

$COMPILE
zathura $PDF_FILE & disown

#while true; do
echo "Watching $FILE"

function watch(){
    echo $FILE | entr -s "$COMPILE"
}

watch
#done
