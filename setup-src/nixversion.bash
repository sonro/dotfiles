nix_version() {
	case "$(uname -s)" in

		Darwin)
			echo 'Mac'
			;;

		Linux)
			if [ -f /etc/os-release ]; then
				awk -F = '/^NAME=/ {print $2}' /etc/os-release | tr -d '"'
			else
				echo "Unknown"
			fi
			;;

		CYGWIN*|MINGW32*|MSYS*|MINGW*)
			echo 'Win'
			;;

		*)
			echo 'Unknown' 
			;;
	esac
}
