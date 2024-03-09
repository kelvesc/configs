# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTCONTROL=ignoreboth

PS1='[\u@\h \W]\$ '
#PS1='\W \[$(tput setaf 200)\]~`echo -e "\U1557"` \[$(tput sgr0)\]\$ '
PS2='~>'
PS3='>>'

# ALIASES
alias ..='cd ..'
alias conf='cd ${HOME}/.config'
alias devc='cd ${HOME}/c'
alias avr='cd ${HOME}/avr'
alias avc='avr-gcc'
alias e='nvim'
alias eb='nvim ~/.bashrc'
alias ev='nvim ~/.config/nvim/init.vim'
alias v='nvim'
alias vv='sudo nvim'
alias keys='setxkbmap -layout br'
alias load-keys='source ~/.config/bspwm/load-keys.sh'

set BASH_CONFIG='${HOME}/.config/bash.d'
for file in ${BASH_CONFIG}/*;
do
        source ${file};
done;