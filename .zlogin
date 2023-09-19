# /etc/zlogin and ~/.zlogin are sourced in login shells

# Don't bother further without a real TERM
[[ -z "$TERM" || "$TERM" = "dumb" || -n "$TMUX" ]] && return

# Use --clear option for additional security
for key in ed25519 rsa; do
	[[ -n "${commands[keychain]}" && -f "${HOME}/.ssh/id_${key}" ]] && \
	keychain --nogui --nocolor "${HOME}/.ssh/id_${key}" > /dev/null 2>&1 && \
	[[ -f "${HOME}/.keychain/${HOSTNAME}-sh" ]] && \
	. "${HOME}/.keychain/${HOSTNAME}-sh"
done

echo "Your home directory is ${HOME}"
echo "Your current shell is $0"

[[ -n "${commands[mesg]}" ]] && mesg y > /dev/null 2>&1

[[ -n "${commands[uptime]}" ]] && uptime
