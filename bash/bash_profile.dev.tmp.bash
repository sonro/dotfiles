if [ -f "$HOME/.dotfiles/bash/common.bash" ]; then
	source "$HOME/.dotfiles/bash/common.bash" #LOADCHECK
fi 

alias vim="nvim"

export EDITOR=nvim
export VISUAL=nvim
export SONRO_SERVER=false
