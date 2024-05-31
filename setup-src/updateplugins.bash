update_plugins() {
	if [[ "$#" -ne 2 ]]; then
		echo "function 'update_plugins' has parameters: server dotfile_dir"
		return 1;
	fi
	
	local server="$1"
	local dotfile_dir="$2"

	# update_vim_plugins "$server" "$dotfile_dir"

	update_tmux_plugins
}

update_vim_plugins() {
	if [[ "$#" -ne 2 ]]; then
		echo "function 'update_vim_plugins' has parameters: server dotfile_dir"
		return 1;
	fi
	
	local server="$1"
	local dotfile_dir="$2"

	source "$dotfile_dir/setup-src/vimcommand.bash"

	echo "Updating VimPlug"
	local command="PlugUpgrade"
	vim_command "$server" "$dotfile_dir" "$command"

	echo "Upgrading Vimplug plugins"
	local command="PlugUpdate"
	vim_command "$server" "$dotfile_dir" "$command"

	return 0
}

update_tmux_plugins() {
	if [[ "$#" -ne 0 ]]; then
		echo "function 'update_tmux_plugins' has no parameters"
		return 1;
	fi

	local tpm_dir="$HOME/.tmux/plugins/tpm"
	echo "Updating Tmux Plugins"
	eval "$tpm_dir/bin/update_plugins all"

	return 0
}
