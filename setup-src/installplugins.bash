install_plugins() {
	if [[ "$#" -ne 3 ]]; then
		echo "function 'install_files' has parameters: server dotfile_dir fresh"
		return 1;
	fi
	
	local server="$1"
	local dotfile_dir="$2"
	local fresh="$3"

	install_vimplug "$server" "$dotfile_dir" "$fresh"

	install_vim_plugins "$server" "$dotfile_dir" "$fresh"

	install_tmux_plugins "$fresh"
}

install_vimplug() {
	if [[ "$#" -ne 3 ]]; then
		echo "function 'install_vimplug' has parameters: server dotfile_dir fresh"
		return 1;
	fi
	
	local server="$1"
	local dotfile_dir="$2"
	local fresh="$3"

	local vim_plug_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

	# set loaction of vim-plug install
	local plug_local_file
	if [[ "$server" == true ]]; then
		plug_local_file="$dotfile_dir/vim/home/autoload/plug.vim"
	else
		plug_local_file="$HOME/.local/share/nvim/site/autoload/plug.vim"
	fi

	# install vim-plug
	if [[ ! -f "$plug_local_file" || "$fresh" == true ]]; then
		echo "Installing VimPlug"
		curl -fLo "$plug_local_file" --create-dirs "$vim_plug_url"
	fi

	return 0
}

install_vim_plugins() {
	if [[ "$#" -ne 3 ]]; then
		echo "function 'install_vim_plugins' has parameters: server dotfile_dir fresh"
		return 1;
	fi
	
	local server="$1"
	local dotfile_dir="$2"
	local fresh="$3"

	# install vim plugins
	echo "Installing Vim Plugins"
	local command="PlugInstall"
	vim_command "$server" "$dotfile_dir" "$command"

	if [[ "$server" == false ]]; then
		local phpactor_link="/usr/local/bin/phpactor"

		if [[ ! -f "$phpactor_link" || "$fresh" == true ]]; then
			rm -f "$phpactor_link"
			sudo ln -s \
				"$dotfile_dir/nvim/config/plugged/phpactor/bin/phpactor" \
				"$phpactor_link"
		fi
	fi

	return 0
}

install_tmux_plugins() {
	if [[ "$#" -ne 1 ]]; then
		echo "function 'install_tmux_plugins' has parameter: fresh"
		return 1;
	fi
	
	local fresh="$1"

	# install tmux plugin manager
	local tpm_dir="$HOME/.tmux/plugins/tpm"
	if [[ ! -d "$tpm_dir" || "$fresh" == true ]]; then
		echo "Installing Tmux Plugins"
		rm -rf "$tpm_dir"
		mkdir -p "$HOME/.tmux/plugins"
		git clone "https://github.com/tmux-plugins/tpm" "$tpm_dir"
		eval "$tpm_dir/bin/install_plugins"
	fi

	return 0
}
