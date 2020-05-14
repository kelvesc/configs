# Catch the hostname
HOSTNAME=$(cat /etc/hostname)
export HOSTNAME

# Append $HOME/bin to PATH variable
PATH=$PATH:$HOME/bin
export PATH

# Set XDG paths
XDG_CONFIG_HOME=$HOME/.config
XDG_USER_CONFIG_DIR=$XDG_CONFIG_HOME
XDG_DATA_HOME=$HOME/.local/share
XDG_CACHE_HOME=$HOME/.cache
XDG_RUNTIME_DIR=$HOME/tmp
XDG_CONFIG_DIRS=/etc/xdg:$XDG_USER_CONFIG_DIR
XDG_DATA_DIRS=/usr/share:/usr/local/share:$XDG_DATA_HOME

# Set inputrc path
INPUTRC=/etc/inputrc

## Set the temporally directory
sudo mount -t tmpfs -o size=200M,mode=1777 tmps $HOME/tmp
if [ $? -eq 0 ];then
	TMPDIR=$HOME/tmp
else
	TMPDIR=/tmp
fi

## Path to X Authority logs
XAUTHORITY=$TMPDIR/Xauthority

## Set the socket to URxvtd
if [ -z "$RXVT_SOCKET" ] && [ -n "$TMPDIR" ]; then
	RXVT_SOCKET=$TMPDIR/urxvt-"$HOSTNAME"
else
	RXVT_SOCKET=/tmp/urxvt-"$HOSTNAME"
fi

## Set the socket to BSPWM
if [ -z "$BSPWM_SOCKET" ] && [ -n "$TMPDIR" ]; then
    BSPWM_SOCKET=$TMPDIR/bspwm-vt$(fgconsole)-$HOSTNAME-socket
fi

# For UIs which use SDL and occasionally don't respect xrandr settings
if [ $(which xrand) ]; then
    export SDL_VIDEO_FULLSCREEN_HEAD=1
fi

# Default editor
if [ $(which nvim) ]; then
    EDITOR=/usr/bin/nvim
fi

# Set less default flags, history file and size
LESSHISTFILE=$TMPDIR/lesshst
LESSHISTSIZE=100
LESS='-i -R'

export TMPDIR
export XAUTHORITY
export XDG_CONFIG_HOME
export XDG_USER_CONFIG_DIR
export XDG_CONFIG_DIRS
export XDG_DATA_HOME
export XDG_DATA_DIRS
export XDG_CACHE_HOME
export BSPWM_SOCKET
export RXVT_SOCKET
export EDITOR
export LESS
export LESSHISTFILE
export LESSHISTSIZE

# Start mpd, with kill option to terminate other running instances
#[ ! -s ~/.config/mpd/mpd.pid ] && \
#mpd --kill 2> $HOME/.cache/mpderror.$(date '+%y%m%d') &

# Finally starts the X session with bspwm
[[ $(fgconsole 2> /dev/null) == 1 ]] && \
BSPCLOG=$(mktemp -q -t bspwm.XXXXXX) && \
startx /usr/bin/bspwm -c $XDG_CONFIG_HOME/bspwm/bspwmrc 2> "$BSPCLOG"

# Start URxvt deamon (decrese memory consumption for multiple terminals)
urxvtd -q -o -f &

