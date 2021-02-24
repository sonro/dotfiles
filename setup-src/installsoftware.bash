install_software() {
	if [[ "$#" -ne 1 ]]; then
		echo "function 'install_software' has parameters: server"
		return 1;
	fi
	
	local server="$1"

	source "$DOTFILE_DIR/setup-src/nixversion.bash"
	local os="$(nix_version)"

	echo "Installing software"
	install_basic_packages "$os"

	if [[ "$server" == false ]]; then
		install_development_packages "$os"
		setup_node
		setup_composer
		setup_php_cs_fixer
		setup_rust
		setup_scriptbin
	fi

	return 0
}

install_basic_packages() {
	if [[ "$#" -ne 1 ]]; then
		echo "function 'install_basic_packages' has parameters: os"
		return 1;
	fi

	local os="$1"

	case "$os" in
		Mac)
			echo "implement install_basic_pacakges for mac"
			;;
		Ubuntu)
			install_basic_packages_ubuntu
			;;
		*)
			echo "Unknown nix environment, skipping software install"
			return 0;
			;;
	esac
}

install_development_packages() {
	if [[ "$#" -ne 1 ]]; then
		echo "function 'install_development_packages' has parameters: os"
		return 1;
	fi

	local os="$1"

	case "$os" in
		Mac)
			echo "implement install_development_pacakges for mac"
			;;
		Ubuntu)
			install_development_packages_ubuntu
			;;
		*)
			echo "Unknown nix environment, skipping software install"
			return 0;
			;;
	esac
}

install_basic_packages_ubuntu() {
	sudo apt update && sudo apt install -y \
		curl \
		git \
		tmux
}

install_development_packages_ubuntu() {
	sudo apt install -y \
		php \
		php-xml \
		php-dom \
		php-curl \
		php-mysql
}


setup_composer() {
	curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
	sudo php \
		/tmp/composer-setup.php \
		--install-dir=/usr/local/bin \
		--filename=composer
}

setup_scriptbin() {
	git clone "git@github.com:sonro/scriptbin.git" "$HOME/xDev/bin"
}

setup_rust() {
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
		| sh -s -- -y --no-modify-path
}

setup_php_cs_fixer() {
	if command -v php-cs-fixer &> /dev/null; then
		return 0
	fi
	
	echo "Installing Php CS Fixer"
	composer global require friendsofphp/php-cs-fixer &> /dev/null

	return 0
}

setup_node() {
	if command -v node &> /dev/null; then
		return 0
	fi

	local nvn_dir="$HOME/.nvm"

	echo "Installing Node Version Manager"

	mkdir -p "$nvn_dir"

	curl -o- \
		https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh \
		| bash &> /dev/null

	# load nvm to use now
	[ -s "$nvn_dir/nvm.sh" ] && \. "$nvn_dir/nvm.sh" 

	echo "Installing NodeJs and NPM"
	nvm install --lts &> /dev/null

	return 0
}

