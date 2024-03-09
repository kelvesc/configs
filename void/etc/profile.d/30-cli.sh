
export HOSTNAME=$(cat /etc/hostname)
export INPUTRC=/etc/inputrc
export PATH=$PATH:$HOME/bin

# less options
export LESSHISTFILE=$(mktemp -q -t lesshst.XXXXXX) #TMPDIR/lesshst
export LESSHISTSIZE=100
export LESS='-I -R'

# [N]VIm 
if [ -f /usr/bin/nvim ];then
        export EDITOR=/usr/bin/nvim
	if ([ -n "$EDITOR" ] && [ -n "$XDG_CONFIG_HOME" ]);then
		export VIM=${XDG_CONFIG_HOME}/nvim/init.vim
	fi
fi
#	else
#		[-f ~/.config/nvim/init.vim ] && export VIM=~/.config/nvim/init.vim
#else if [ -f /usr/bin/vim];then
#	export EDITOR=/usr/bin/vim

#------Exports
#export PATH
#export HOSTNAME
#export LESS
#export LESSHISTFILE
#export LESSHISTSIZE
#export EDITOR
#export VIM
