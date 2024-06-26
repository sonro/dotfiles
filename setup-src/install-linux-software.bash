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

install_php_cs_fixer_linux() {
	if command -v php-cs-fixer &> /dev/null; then
		return 0
	fi
	
	echo "Installing Php CS Fixer"
	composer global require friendsofphp/php-cs-fixer --no-interaction

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
	local local_bin="$HOME/.local/bin"
	local local_sore="$HOME/xDev/sore"
	local zls_bin="$local_sore/zls/zig-out/bin/zls"

	mkdir -p "$local_bin"

	if ! builtin type -P zvm &> /dev/null; then
		echo "Installing Zig Version Manager"
  
		curl https://raw.githubusercontent.com/tristanisham/zvm/master/install.sh \
			| bash
	fi

	echo "Installing latest Zig"
	
	eval "$HOME/.zvm/self/zvm" i master

	echo "Installing Zig Langauge Server"

	mkdir -p "$local_sore"

	if [ ! -d "$local_sore/zls" ]; then
		git clone https://github.com/zigtools/zls "$local_sore/zls"
	fi


	cd "$local_sore/zls"
	git pull
	eval "$HOME/.zvm/bin/zig" build -Doptimize=ReleaseSafe

	if [ ! -f "$local_bin/zls" ]; then
		ln -s "$zls_bin" "$local_bin/zls"
	fi

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
	local cargo_dir="$HOME/.cargo/bin"
	local cargo="$cargo_dir/cargo"
	local local_sore="$HOME/xDev/sore"
	local sore_ra="$local_sore/rust-analyzer"
	local cwd=$(pwd)

	echo "Installing rust-analyzer"

	mkdir -p "$local_sore"

	if [ ! -d "$sore_ra" ]; then
		git clone https://github.com/rust-lang/rust-analyzer.git "$sore_ra"
	fi

	cd "$sore_ra"
	git pull
	eval "$cargo" xtask install --server

	cd "$cargo_dir"

	echo "Installing Cargo Binstall"
	curl -L --proto '=https' --tlsv1.2 -sSf \
		https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh \
		| bash
	
	echo "Installing Cargo packages"
	eval "$cargo" binstall --no-confirm --force \
		bat \
		bottom \
		cargo-asm \
		cargo-audit \
		cargo-cache \
		cargo-edit \
		cargo-expand \
		cargo-msrv \
		cargo-semver-checks\
		cargo-update \
		cargo-whatfeatures \
		difftastic \
		exa \
		fd-find \
		grex \
		just \
		ripgrep \
		sd \
		tokei \
		watchexec-cli

	cd "$cwd"
}

