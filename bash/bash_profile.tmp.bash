# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
	source "$HOME/.bashrc"
fi

# set PATH so it includes user's private bins if they exist
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/xDev/bin" ] ; then
    export PATH="$HOME/xDev/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -f "$HOME/.dotfiles/bash/common.bash" ]; then
	source "$HOME/.dotfiles/bash/common.bash" #LOADCHECK
fi 

export EDITOR=vi
export VISUAL=vi

