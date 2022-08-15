update_software() {
	if [[ "$#" -ne 2 ]]; then
		echo "function 'update_software' has parameters: server dotfile_dir"
		return 1;
	fi
	
	local server="$1"
	local dotfile_dir="$2"

	source "$dotfile_dir/setup-src/nixversion.bash"
	local os="$(nix_version)"

	echo "Updating software"
	update_basic "$os" "$dotfile_dir"

	if [[ "$server" == false ]]; then
		update_dev "$os" "$dotfile_dir"
	fi

	return 0
}

update_basic() {
	if [[ "$#" -ne 2 ]]; then
		echo "function 'update_basic' has parameters: os dotfile_dir"
		return 1;
	fi

	local os="$1"
	local dotfile_dir="$2"

	case "$os" in
		Mac)
			echo "implement update_basic_pacakges for mac"
			;;
		Ubuntu)
			source "$dotfile_dir/setup-src/update-ubuntu-software.bash"
			update_basic_ubuntu
			;;
		*)
			echo "Unknown nix environment, skipping software update"
			return 0;
			;;
	esac
}

update_dev() {
	if [[ "$#" -ne 2 ]]; then
		echo "function 'update_dev' has parameters: os dotfile_dir"
		return 1;
	fi

	local os="$1"
	local dotfile_dir="$2"

	case "$os" in
		Mac)
			echo "implement update_development_pacakges for mac"
			;;
		Ubuntu)
			source "$dotfile_dir/setup-src/update-linux-software.bash"
			update_dev_ubuntu
			update_dev_linux "$dotfile_dir"
			;;
		*)
			echo "Unknown nix environment, skipping software update"
			return 0;
			;;
	esac
}

