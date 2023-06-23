update_dev_linux() {
	if [[ "$#" -ne 1 ]]; then
		echo "function 'update_dev_linux' has parameters: dotfile_dir"
		return 1;
	fi

	local dotfile_dir="$1"

	eval "$dotfile_dir/bin/php-update"
	update_rust_linux
	update_rust_utils_linux
	update_zig_linux
	update_composer_linux
	update_composer_utils_linux
}

update_composer_linux() {
	echo "Updating composer"
	sudo composer selfupdate
}

update_composer_utils_linux() {
	echo "Updating composer packages"
	composer global update
}

update_rust_linux() {
	echo "Updating rust"
	rustup update
}

update_zig_linux() {
	local cwd=$(pwd)

	echo "Updating Zig"
	zvm i master

	echo "Updating ZLS"

	cd "$HOME/xDev/sore/zls"

	git pull
	zig build -Doptimize=ReleaseSafe

	cd "$cwd"
}

update_rust_utils_linux() {
	echo "Updating rust packages"
	cargo install-update -a
}
