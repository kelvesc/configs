#!/bin/sh
#
# set up part of the desktop environment

if [ $(which xset) ]; then
    xset +dpms
    xset dpms 0 0 300
fi

# disable monitors outputs that are not in use
# $ xrandr # (without arguments) to see all monitors outputs
if [ $(which xrandr) ]; then
    xrandr --output DVI-D-1 --off
    xrandr --output VGA-1 --off
    xrandr --output DP-1 --off
fi

pgrep -u "${USER}" -x polybar || \
        polybar bar -r 2>&1 1> $(mktemp -t bar.log.XXX) &

