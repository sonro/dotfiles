# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
	source "$HOME/.bashrc"
fi

# language tool vendor bins
if [ -d "$HOME/.config/composer/vendor/bin" ]; then
	PATH="$HOME/.config/composer/vendor/bin:$PATH"
fi 
if [ -d "$HOME/.cargo/bin" ]; then
	PATH="$HOME/.cargo/bin:$PATH"
fi 
if [ -d "$HOME/.symfony/bin" ] ; then
    PATH="$HOME/.symfony/bin:$PATH"
fi
if [ -d "$HOME/.zig/bin" ] ; then
    PATH="$HOME/.zig/bin:$PATH"
fi

# set PATH so it includes user's private bins if they exist
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/xDev/bin" ] ; then
    PATH="$HOME/xDev/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH

export GPG_TTY=$(tty)

export PHP_CS_FIXER_IGNORE_ENV=1

# Attach to SSH agent once
if [ -z ${SSH_AGENT_PID+x} ]; then
	eval $(ssh-agent)
fi
