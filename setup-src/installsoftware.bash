install_software() {
	if [[ "$#" -ne 2 ]]; then
		echo "function 'install_software' has parameters: server dotfile_dir"
		return 1;
	fi
	
	local server="$1"
	local dotfile_dir="$2"

	source "$dotfile_dir/setup-src/nixversion.bash"
	local os="$(nix_version)"

	echo "Installing software"
	install_basic "$os"

	if [[ "$server" == false ]]; then
		install_dev "$os"
	fi

	return 0
}

install_basic() {
	if [[ "$#" -ne 1 ]]; then
		echo "function 'install_basic' has parameters: os"
		return 1;
	fi

	local os="$1"

	case "$os" in
		Mac)
			echo "implement install_basic_pacakges for mac"
			;;
		Ubuntu)
			source "$dotfile_dir/setup-src/install-ubuntu-software.bash"
			install_basic_ubuntu
			;;
		*)
			echo "Unknown nix environment, skipping software install"
			return 0;
			;;
	esac
}

install_dev() {
	if [[ "$#" -ne 1 ]]; then
		echo "function 'install_dev' has parameters: os"
		return 1;
	fi

	local os="$1"

	case "$os" in
		Mac)
			echo "implement install_development_pacakges for mac"
			;;
		Ubuntu)
			source "$dotfile_dir/setup-src/install-linux-software.bash"
			install_dev_ubuntu
			install_dev_linux
			;;
		*)
			echo "Unknown nix environment, skipping software install"
			return 0;
			;;
	esac
}

