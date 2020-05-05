#!/bin/bash

#use sha1, ntlm, sha512



#echo "Dictionary based password generation:"
#MAX_WORD_LENGTH=$(cat $WORDLIST | wc -L)
#WORDLIST_LEN=$(cat $WORDLIST | wc -l)
#let "OPTIONS=$WORDLIST_LEN**$LEN"
#echo "Possible options = $OPTIONS"
#echo "Max word length = $MAX_WORD_LENGTH"


LEN=10
WORDLIST=/usr/share/dict/american-english
for LEN in $(seq 5 10); do
for i in $(seq 0 5); do
    shuf -n $LEN $WORDLIST | tr '\n' ' '; echo
done
done





#echo
#echo "Standard pwd generation:"
#OPTIONS=$(((26*2+9)**$LEN))
#echo "Possible options = $OPTIONS"
#pwgen -n $LEN -N 1

