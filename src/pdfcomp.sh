#!/bin/bash
FOLDER=$1

echo $(find $FOLDER -name "*.tex") $(find $FOLDER -name "*.bib") | sed 's/ /\n/g' | entr bash -c 'bibtex -terse main; pdflatex -shell-escape main.tex; bibtex main'
