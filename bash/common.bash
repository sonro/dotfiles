PATH="$HOME/.config/composer/vendor/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
export PATH

export GPG_TTY=$(tty)

# Attach to SSH agent once
if [ -z ${SSH_AGENT_PID+x} ]; then
	eval $(ssh-agent)
fi
