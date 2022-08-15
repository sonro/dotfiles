vim_command() {
	if [[ "$#" -ne 3 ]]; then
		echo "function 'vim_command' has parameters: server dotfile_dir command"
		return 1;
	fi
	
	local server="$1"
	local dotfile_dir="$2"
	local command="$3"

	if [[ "$server" == true ]]; then
		vim -es -u "$dotfile_dir/vim/vimrc" -i NONE -c "$command" -c "qa" || :
	else
		nvim -es -u "$dotfile_dir/nvim/config/init.vim" \
			-i NONE -c "$command" -c "qa" || :
	fi

	return 0
}
