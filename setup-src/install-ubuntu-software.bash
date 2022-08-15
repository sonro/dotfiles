install_basic_ubuntu() {
	sudo apt update && sudo apt upgrade && sudo apt install -y \
		curl \
		git \
		tmux
	
	sudo apt autoremove -y
}

install_dev_ubuntu() {
	install_neovim_ubuntu

	local php_version="8.1"
	install_php_ubuntu "$php_version"
	install_php_extentions_ubuntu "$php_version"
}

install_neovim_ubuntu() {
	sudo add-apt-repository ppa:neovim-ppa/stable
	sudo apt-get update
	sudo apt install -y neovim
}

install_php_ubuntu() {
	if [[ "$#" -ne 1 ]]; then
		echo "function 'install_php_ubuntu' has parameters: version"
		return 1;
	fi

    local version="$1"

	sudo apt install -y software-properties-common
	sudo add-apt-repository -y ppa:ondrej/php
	sudo apt update
	sudo apt install -y "php$version"
}

install_php_extentions_ubuntu() {
	if [[ "$#" -ne 1 ]]; then
		echo "function 'install_php_extentions_ubuntu' has parameters: version"
		return 1;
	fi

    local version="$1"

	local extensions=("xml", "curl", "mysql", "dom")

	for ext in "${extensions[@]}"; do
		local package="php$version-$ext"

		sudo apt install -y "$package"
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
