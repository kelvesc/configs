
# Path to X Authority logs
#XAUTHORITY=~/.tmp/Xautority

# URxvtd socket
if ([ -z "$RXVT_SOCKET" ] && [ -n "$TMPDIR" ]);then
	#(mktemp -q -t urxvt-"$HOSTNAME"-socket.XXXXXX)
	export RXVT_SOCKET=$TMPDIR/urxvt-${USER}at${HOSTNAME}
fi

# BSPWM socket
if ([ -z "$BSPWM_SOCKET" ] && [ -n "$TMPDIR" ]);then
	export BSPWM_SOCKET=$TMPDIR/bspwm-vt$(fgconsole)-$HOSTNAME-socket
	#(mktemp -q -t bspwm-vt"$(fgconsole)"-"$HOSTNAME"-socket.XXXXXX) && \
        export BSPCLOG=$TMPDIR/bspwm.log #(mktemp -q -t bspwm.XXXXXX)
fi

# For UIs which use SDL and occasionally don't respect xrandr settings
#[[ -f /usr/bin/xrand ]] && export SDL_VIDEO_FULLSCREEN_HEAD=1

#from 10_openjdk8.sh
#export JAVA_HOME=${JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/jre}

#export BSPWM_SOCKET
#export RXVT_SOCKET
