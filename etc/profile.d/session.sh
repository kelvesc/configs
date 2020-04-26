# Catch the hostname
HOSTNAME=$(cat /etc/hostname)
export HOSTNAME

# Append an extra directory to the PATH variable
PATH=$PATH:$HOME/bin
export PATH

# Set XDG Paths
XDG_CONFIG_HOME=$HOME/.config
XDG_DATA_HOME=$HOME/.local/share
XDG_CACHE_HOME=$HOME/.cache
XDG_RUNTIME_DIR=$HOME/tmp

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
if [ -n "$TMPDIR" ];then
	XAUTHORITY=$TMPDIR/Xauthority
else
	XAUTHORITY=/tmp/Xauthority

fi

## Set the socket to URxvtd
if [ -z "$RXVT_SOCKET" ] && [ -n "$TMPDIR" ]; then
	RXVT_SOCKET=$TMPDIR/urxvt-"$HOSTNAME"

else
	RXVT_SOCKET=/tmp/urxvt-"$HOSTNAME"
fi
## Set the socket to BSPWM
if [ -z "$BSPWM_SOCKET" ] && [ -n "$TMPDIR" ]; then
	BSPWM_SOCKET=$TMPDIR/
fi

# Default editor
EDITOR=/usr/bin/nvim

# Set less history size to zero and flags
LESSHISTFILE=$TMPDIR/lesshst
LESSHISTSIZE=0
LESS='-i -R'


export TMPDIR
export XAUTHORITY
export XDG_CONFIG_HOME
export XDG_DATA_HOME
export XDG_CACHE_HOME
export RXVT_SOCKET
export EDITOR
export LESS
export LESSHISTFILE
export LESSHISTSIZE

# Start mpd, with kill option to terminate other running instances
#[ ! -s ~/.config/mpd/mpd.pid ] && mpd --kill 2> $HOME/.cache/mpderror.$(date '+%y%m%d') &

# Finally starts the X session with bspwm
BSPCLOG=$(mktemp -q -t bspwm.XXXXXX)
startx /usr/bin/bspwm -c $XDG_CONFIG_HOME/bspwm/bspwmrc 2> "$BSPCLOG" #$(mktemp -q -t bspwm.XXXXXX) & # /dev/null &

# Start URxvt deamon, to decrese the mem consumption of multiple terminals
urxvtd -q -o -f &

