install_basic_ubuntu() {
	sudo apt update && sudo apt upgrade -y && sudo apt install -y \
		curl \
		git \
		tmux
	
	sudo apt autoremove -y
}

install_dev_ubuntu() {
	install_essential_ubuntu
	install_c_ubuntu
	install_lib_ubuntu
	install_neovim_ubuntu

	local php_version="8.2"
	install_php_ubuntu "$php_version"
	install_php_extensions_ubuntu "$php_version"
}

install_essential_ubuntu() {
	echo "Installing dev build-essential"
	sudo apt install -y build-essential
	echo "Installing clang"
	sudo apt install -y clang
	echo "Installing pkg-config"
	sudo apt install -y pkg-config
}

install_lib_ubuntu() {
	echo "Installing libraries"
	sudo apt install -y \
		libssl-dev \
		libgit2-dev \
		libssh-dev
}

install_c_ubuntu() {
	echo "Installing lldb"
	sudo apt install -y lldb
	echo "Installing gdb"
	sudo apt install -y gdb
	echo "Installing valgrind"
	sudo apt install -y valgrind
}

install_neovim_ubuntu() {
	echo "Installing neovim"
	sudo add-apt-repository -y ppa:neovim-ppa/stable
	sudo apt-get update
	sudo apt install -y neovim
}

install_php_ubuntu() {
	if [[ "$#" -ne 1 ]]; then
		echo "function 'install_php_ubuntu' has parameters: version"
		return 1;
	fi

    local version="$1"

	echo "Installing PHP"
	sudo apt install -y software-properties-common
	sudo add-apt-repository -y ppa:ondrej/php
	sudo apt update
	sudo apt install -y "php$version"
}

install_php_extensions_ubuntu() {
	if [[ "$#" -ne 1 ]]; then
		echo "function 'install_php_extensions_ubuntu' has parameters: version"
		return 1;
	fi

    local version="$1"

	local extensions=("xml", "curl", "mysql", "dom", "xdebug")

	for ext in "${extensions[@]}"; do
		local package="php$version-$ext"
		echo "Installing PHP extension $package"

		sudo apt install -y $(echo $package | sed 's/,//g')
	done
}

# not currently used
install_phpfpm_for_apache_ubuntu() {
	sudo apt install -y \
		php8.0-fpm libapache-mod-fcgid
	sudo a2enmod proxy_fcgi setenvif
	sudo a2enconf php8.0-fpm
	sudo systemctl restart apache2
}
