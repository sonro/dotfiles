# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
. "$HOME/.bashrc"
fi

# set PATH so it includes user's private bins if they exist
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/xDev/bin" ] ; then
    PATH="$HOME/x/Dev/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export GPG_TTY=$(tty)
export EDITOR=vi
export VISUAL=vi

if [ -f "$HOME/.dotfiles/bash/common.bash" ]; then
	source "$HOME/.dotfiles/bash/common.bash" ; #LOADCHECK
fi 
