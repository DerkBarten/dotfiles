#!/bin/sh

B='#00000000'  # blank
C='#c6dbec22'  # clear ish
D='#285577A0'  # default
T='#c6dbecA0'  # text
W='#c6dbec22'  # wrong
V='#c6dbec22'  # verifying

i3lock              \
--insidevercolor=$C   \
--ringvercolor=$V     \
\
--insidewrongcolor=$C \
--ringwrongcolor=$W   \
\
--insidecolor=$B      \
--ringcolor=$D        \
--linecolor=$B        \
--separatorcolor=$D   \
\
--textcolor=$T        \
--timecolor=$T        \
--datecolor=$T        \
--keyhlcolor=$W       \
--bshlcolor=$W        \
\
--screen 0            \
--blur 5              \
--clock               \
--indicator           \
--timestr="%H:%M:%S"  \
--datestr="%A, %m %Y" \

# --veriftext="Drinking verification can..."
#--wrongtext="Nope!" \
# --textsize=20
# --modsize=10
#--timefont=comic-sans \
# --datefont=monofur
# etc
