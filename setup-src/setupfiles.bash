setup_files() {
	if [[ "$#" -ne 3 ]]; then
		echo "function 'setup_files' has parameters: server dotfile_dir fresh"
		return 1;
	fi
	
	local server="$1"
	local dotfile_dir="$2"
	local fresh="$3"

	echo "Setting up files"

	setup_bash_files "$dotfile_dir" "$fresh"

	setup_tmux_files "$dotfile_dir" "$fresh"

	setup_git_files "$dotfile_dir" "$fresh"

	setup_vim_files "$server" "$dotfile_dir" "$fresh"

	setup_dev_files "$server"
}

setup_bash_files() {
	if [[ "$#" -ne 2 ]]; then
		echo "function 'setup_bash_files' has parameters: dotfile_dir fresh"
		return 1;
	fi

	local dotfile_dir="$1"
	local fresh="$2"

	if [ ! -f "$HOME/.bashrc" ]; then
		cp "$dotfile_dir/bash/bashrc.tmp.bash" "$HOME/.bashrc"
	fi

	if [[ ! -f "$HOME/.bash_profile" || "$fresh" == true ]]; then
		cp "$dotfile_dir/bash/bash_profile.tmp.bash" "$HOME/.bash_profile"
	elif ! grep -Fq "#LOADCHECK" "$HOME/.bash_profile"; then
		cat "$dotfile_dir/bash/bashloader" >> "$HOME/.bash_profile"
	fi
}

setup_tmux_files() {
	if [[ "$#" -ne 2 ]]; then
		echo "function 'setup_tmux_files' has parameters: dotfile_dir fresh"
		return 1;
	fi

	local dotfile_dir="$1"
	local fresh="$2"

	if [[ ! -f "$HOME/.tmux.conf" || "$fresh" == true ]]; then
		rm -f "$HOME/.tmux.conf"
		ln -s "$dotfile_dir/tmux/tmux.conf" "$HOME/.tmux.conf"
	fi
}

setup_git_files() {
	if [[ "$#" -ne 2 ]]; then
		echo "function 'setup_git_files' has parameters: dotfile_dir fresh"
		return 1;
	fi

	local dotfile_dir="$1"
	local fresh="$2"

	if [[ ! -f "$HOME/.gitconfig" || "$fresh" == true ]]; then
		rm -f "$HOME/.gitconfig"
		ln -s "$dotfile_dir/git/gitconfig" "$HOME/.gitconfig"
	fi
}

setup_vim_files() {
	if [[ "$#" -ne 3 ]]; then
		echo "function 'setup_vim_files' has parameters: server dotfile_dir fresh"
		return 1;
	fi
	
	local server="$1"
	local dotfile_dir="$2"
	local fresh="$3"
	
	if [[ "$server" == true ]]; then
		if [[ ! -d "$HOME/.vim" || "$fresh" == true ]]; then
			rm -rf "$HOME/.vim"
			rm -rf "$HOME/.vimrc"
			ln -s "$dotfile_dir/vim/home" "$HOME/.vim"
			cp "$dotfile_dir/vim/vimrc" "$HOME/.vimrc"
		fi
	else
		if [[ ! -d "$HOME/.config/nvim" || "$fresh" == true ]]; then
			rm -rf "$HOME/.config/nvim"
			mkdir -p "$HOME/.config"
			ln -s "$dotfile_dir/nvim/config" "$HOME/.config/nvim"
		fi
	fi
}

setup_dev_files() {
	if [[ "$#" -ne 1 ]]; then
		echo "function 'setup_dev_files' has parameters: server"
		return 1;
	fi
	
	local server="$1"

	# create xDev directory
	if [[ "$server" == false ]]; then
		mkdir -p "$HOME/xDev"
	fi

	return 0
}

