if [ -d "$HOME/.config/composer/vendor/bin" ]; then
	PATH="$HOME/.config/composer/vendor/bin:$PATH"
fi 
if [ -d "$HOME/.cargo/bin" ]; then
	PATH="$HOME/.cargo/bin:$PATH"
fi 
if [ -d "$HOME/.symfony/bin" ] ; then
    PATH="$HOME/.symfony/bin:$PATH"
fi

export PATH

export GPG_TTY=$(tty)

export PHP_CS_FIXER_IGNORE_ENV=1

# Attach to SSH agent once
if [ -z ${SSH_AGENT_PID+x} ]; then
	eval $(ssh-agent)
fi
