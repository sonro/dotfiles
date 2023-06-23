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
	install_zig_linux
	install_node_linux
	install_rust_utils
}

install_composer_linux() {
	echo "Installing composer"

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

	echo "Installing personal scripts"

	if [[ ! -d "$bin" || "$fresh" == true ]]; then
		rm -rf "$bin"
		git clone "https://github.com/sonro/scriptbin.git" "$bin"
	fi
}

install_rust_linux() {
	echo "Installing Rust"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
		| sh -s -- -y --no-modify-path
}

install_zig_linux() {
	local cwd=$(pwd)
	local local_bin = "$HOME/.local/bin"
	local local_sore = "$HOME/xDev/sore"

	echo "Installing Zig Version Manager"

	mkdir -p "$local_bin"
	cd "$local_bin"

	curl https://raw.githubusercontent.com/tristanisham/zvm/master/install.sh \
		| bash

	cd $cwd

	echo "Installing latest Zig"
	
	eval "$local_bin/zvm" i master

	echo "Installing Zig Langauge Server"

	mkdir -p "$local_sore"

	git clone https://github.com/zigtools/zls "$local_sore/zls"

	cd "$local_sore/zls"

	eval "$HOME/.zlm/bin/zig" build -Doptimize=ReleaseSafe

	cd $cwd
}

install_node_linux() {
	if command -v node &> /dev/null; then
		return 0
	fi

	local nvm_dir="$HOME/.nvm"

	echo "Installing Node Version Manager"

	mkdir -p "$nvm_dir"

	curl -o- \
		https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh \
		| bash &> /dev/null

	# load nvm to use now
	[ -s "$nvm_dir/nvm.sh" ] && \. "$nvm_dir/nvm.sh" 

	echo "Installing NodeJs and NPM"
	nvm install --lts &> /dev/null

	return 0
}

install_rust_utils() {
	local cargo="$HOME/.cargo/bin/cargo"

	echo "Installing rust utilities"

	eval $cargo install cargo-update
	eval $cargo install cargo-whatfeatures
	eval $cargo install cargo-edit
	eval $cargo install cargo-asm
	eval $cargo install watchexec-cli
	eval $cargo install just
	eval $cargo install sd
	eval $cargo install difftastic
	eval $cargo install fd-find
	eval $cargo install ripgrep
	eval $cargo install grex
	eval $cargo install exa
	eval $cargo install --locked bat
	eval $cargo install --locked bottom
}

