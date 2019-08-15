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
alias grep='grep --color=auto'
alias ls='ls -a --color=auto'
alias ll='ls -la --color=auto'
alias v='nvim'
alias vv='sudo nvim'
alias wget='wget --hsts-file=/tmp/wget-hsts'
alias c='cat'

# SYSTEM
alias df='df -h'
alias updatedb='sudo updatedb'
alias lb='lsblk -p'
alias mt='sudo mount'
alias dmt='sudo umount'
# alias pwff='sudo poweroff'
# alias rebt='sudo reboot'

# XBPS
alias xbps='sudo xbps-install'
alias query='xbps-query'
alias recall='sudo xbps-reconfigure'
alias remove='sudo xbps-remove'

