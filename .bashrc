# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Shell Options
shopt -s checkwinsize
shopt -s autocd
shopt -s cdspell
shopt -s no_empty_cmd_completion
shopt -s histappend

HISTCONTROL=ignoreboth

PS1='[\u@\h \W]\$ '
#PS1='\W \[$(tput setaf 200)\]~`echo -e "\U1557"` \[$(tput sgr0)\]\$ '
PS2='~>'
PS3='>>'

# ALIASES
#TODO: put aliases in a separeted file
#       some do this with functions too
#       I found this a bit unecessary, but there may be some benefits to it
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
alias c='cat'
alias b='bat'
alias l='ls --color=auto'
alias la='ls --color=auto -a'
alias ll='ls --color=auto -al'
alias lo='ls --color=auto -alo'
alias grep='grep --color=auto'
alias wget='wget --hsts-file=/tmp/wget-hsts'
alias sauce='source ~/.bashrc; echo "${HOME}/.bashrc loaded"'
alias term='echo $TERM'
alias keys='setxkbmap -layout br'
alias load-keys='source ~/.config/bspwm/load-keys.sh'

# SYSTEM
alias df='df -h'
alias updatedb='sudo updatedb'
alias lb='lsblk -p'
alias mt='sudo mount'
alias umt='sudo umount'
alias pwroff='sudo poweroff'
alias reboot='sudo reboot'
alias halt='sudo halt'
alias zzz='sudo zzz'
alias ZZZ='sudo ZZZ'

# XBPS
alias xinstall='sudo xbps-install'
alias xquery='xbps-query'
alias xreconf='sudo xbps-reconfigure'
alias xremove='sudo xbps-remove'

# functions
#edit(){} # fast wait to edit bashrc and nvim.init
clean(){
        if [[ -f ${PSD}/Makefile ]]; then
                make clean
        else
                echo "$(tput setaf 200)ERROR$(tput sgr0): No Makefile found"
        fi
}

# TODO: make this function receive some argumments
random_seed(){
        tr -dc _A-Za-z0-9 < /dev/urandom | head -c${1:-7}
        echo ""
}

