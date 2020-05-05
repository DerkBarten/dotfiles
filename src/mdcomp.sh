#!/bin/bash
FILE=$1
if [ -z $1 ]; then
    echo "Please specify a md file"
    exit 1
fi

PDF_FILE=$(echo $FILE | sed 's/\.md$/\.pdf/g')
COMPILE="pandoc -f markdown -t latex -o $PDF_FILE $FILE"

$COMPILE
cat $PDF_FILE | zathura - &
rm $PDF_FILE
