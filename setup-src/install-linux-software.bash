install_dev_linux() {
	if [[ "$#" -ne 1 ]]; then
		echo "function 'install_dev_linux' has parameters: fresh"
		return 1;
	fi

	local fresh="$1"

	install_composer_linux
	install_php_cs_fixer_linux
	install_my_scripts_linux "$fresh"
	install_rust_linux
	install_node_linux
}

install_composer_linux() {
	curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
	sudo php \
		/tmp/composer-setup.php \
		--install-dir=/usr/local/bin \
		--filename=composer
}

#TODO check PATH is updated to use composer global stuff
install_php_cs_fixer_linux() {
	if command -v php-cs-fixer &> /dev/null; then
		return 0
	fi
	
	echo "Installing Php CS Fixer"
	composer global require friendsofphp/php-cs-fixer &> /dev/null

	return 0
}

install_my_scripts_linux() {
	if [[ "$#" -ne 1 ]]; then
		echo "function 'install_my_scripts_linux' has parameters: fresh"
		return 1;
	fi

	local fresh="$1"

	local bin="$HOME/xDev/bin"

	mkdir -p "$HOME/xDev"

	if [[ ! -d "$bin" || "$fresh" == true ]]; then
		rm -rf "$bin"
		git clone "https://github.com/sonro/scriptbin.git" "$bin"
	fi
}

install_rust_linux() {
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
		| sh -s -- -y --no-modify-path
}

install_node_linux() {
	if command -v node &> /dev/null; then
		return 0
	fi

	local nvm_dir="$HOME/.nvm"

	echo "Installing Node Version Manager"

	mkdir -p "$nvm_dir"

	curl -o- \
		https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh \
		| bash &> /dev/null

	# load nvm to use now
	[ -s "$nvm_dir/nvm.sh" ] && \. "$nvm_dir/nvm.sh" 

	echo "Installing NodeJs and NPM"
	nvm install --lts &> /dev/null

	return 0
}

