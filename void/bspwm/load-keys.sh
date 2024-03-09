#!/bin/sh
#
# configure keys on keyboard to custom values

# set the base keyborad layout to br-abnt2
setxkbmap br -variant abnt2

xmodmap -e "clear lock"
xmodmap -e "keysym Menu = Super_L"
xmodmap -e "keycode 97 = slash question exclam"
xmodmap -e "keycode 108 = Alt_L"
xmodmap -e "keysym Caps_Lock = Escape"
xmodmap -e "keysym ccedilla = bar backslash"
xmodmap -e "keysym Print = Prior"
xmodmap -e "keysym Pause = Next"
xmodmap -e "keysym Insert = Return"

# xset r enables the new values' repetition
xset r 108
xset r 34
xset r 66
xset r 64

