umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

. $HOME/.bashrc

export GIT_PS1_SHOWDIRTYSTATE=1
type -P dircolors >/dev/null && eval "$(dircolors -b)"

# Start up our window manager if we log in through agetty on tty1.
if [ -z "$DISPLAY" ] && [ $(tty) == "/dev/tty1" ]; then
    exec startx
fi

