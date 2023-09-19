# ~/.bash_profile

# Ensure SHELL is always correctly set
[[ "${SHELL}" == *bash* ]] || export SHELL="$0"

# Do .bashrc so that common settings are always set
[[ -f "${HOME}/.bashrc" ]] && . "${HOME}/.bashrc" || :

# Don't bother further without a real TERM
[[ -z "$TERM" || "$TERM" = "dumb" || -n "$TMUX" ]] && return

# Use --clear option for additional security
for key in ed25519 rsa; do
	type -P keychain > /dev/null && [[ -f "${HOME}/.ssh/id_${key}" ]] && \
	keychain --nogui --nocolor "${HOME}/.ssh/id_${key}" > /dev/null 2>&1 && \
	[[ -f "${HOME}/.keychain/${HOSTNAME}-sh" ]] && \
	. "${HOME}/.keychain/${HOSTNAME}-sh"
done

echo "Your home directory is ${HOME}"
echo "Your current shell is $0"

type -P mesg > /dev/null && mesg y > /dev/null 2>&1

type -P uptime > /dev/null && uptime
