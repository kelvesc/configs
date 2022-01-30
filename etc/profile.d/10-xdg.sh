
# Mount a separeted tmpfs into place
#        sudo mount -t tmpfs -o size=200M,mode=1777 tmps $HOME/.tmp && \
if [ -d $HOME/.tmp ]; then
	export TMPDIR=$HOME/.tmp
else
	export TMPDIR=/tmp
fi


# Set XDG paths
export XDG_RUNTIME_DIR=${TMPDIR}
export XDG_CONFIG_HOME=$HOME/.config
export XDG_USER_CONFIG_DIR=$XDG_CONFIG_HOME
export XDG_CONFIG_DIRS=/etc/xdg:$XDG_USER_CONFIG_DIR
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_DATA_DIRS=/usr/share:/usr/local/share:$XDG_DATA_HOME

#export TMPDIR
#export XDG_CONFIG_HOME
#export XDG_USER_CONFIG_DIR
#export XDG_CONFIG_DIRS
#export XDG_DATA_HOME
#export XDG_DATA_DIRS
#export XDG_CACHE_HOME

