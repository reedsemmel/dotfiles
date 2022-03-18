umask 022

# Add some common paths

if [ -d "/usr/local/go/bin" ] ; then
    PATH="/usr/local/go/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Environment
export PATH
export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTCONTROL=ignoreboth:erasedups
export GLOBIGNORE=".:.."
export EDITOR="vim"
export VISUAL="vim"
type -P dircolors >/dev/null && eval "$(dircolors -b)"

# Our bashrc does nothing for non-interactive shells
. $HOME/.bashrc

# Source a machine-local profile if applicable
if [ -r $HOME/.bash.d/profile ] ; then
    . $HOME/.bash.d/profile
fi

# Start up our window manager if we log in through agetty on tty1.
if [ -z "$DISPLAY" ] && [ $(tty) == "/dev/tty1" ] ; then
    exec startx
fi

# Make it so in login shells, our first exit code is 0
true
