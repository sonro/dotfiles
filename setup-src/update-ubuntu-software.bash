update_basic_ubuntu() {
	sudo apt update && 
		sudo apt upgrade -y &&
		sudo apt autoremove -y
}

update_dev_ubuntu() {
	echo "Updating ubuntu dev packages"
}

update_php_ubuntu() {
	if [[ "$#" -ne 3 ]]; then
		echo "function 'update_php_ubuntu' has parameters: current_version latest_version dotfile_dir"
		return 1;
	fi

    local current="$1"
    local latest="$2"
	local dotfile_dir="$3"

	echo "Updating PHP to $latest"
	sudo apt install -y "php$latest"

	source "$dotfile_dir/setup-src/install-ubuntu-software.bash"
	install_php_extentions_ubuntu "$latest"

	if [[ "$current" != "$latest" ]]; then
		echo "Removing php$current"
		sudo apt remove -y "php$current-*"
		sudo apt remove -y "php$current"
	fi
}