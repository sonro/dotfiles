install_basic_ubuntu() {
	sudo apt update && sudo apt install -y \
		curl \
		git \
		tmux
}

install_dev_ubuntu() {
	install_php_ubuntu
	install_php_extentions_ubuntu
}

install_php_ubuntu() {
	sudo apt install -y software-properties-common
	sudo add-apt-repository ppa:ondrej/php
	sudo apt update
	sudo apt install -y \
		php8.0
}

install_php_extentions_ubuntu() {
	sudo apt install -y \
		php8.0-xml \
		php8.0-curl \
		php8.0-mysql
}

# not currently used
install_phpfpm_for_apache_ubuntu() {
	sudo apt install -y \
		php8.0-fpm libapache-mod-fcgid
	sudo a2enmod proxy_fcgi setenvif
	sudo a2enconf php8.0-fpm
	sudo systemctl restart apache2
}
