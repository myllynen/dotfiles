# /etc/zlogin and ~/.zlogin are sourced in login shells

# Don't bother further without a real TERM
[[ -z "$TERM" || "$TERM" = "dumb" ]] && return

# Use --clear option for additional security
[[ -x "`whence keychain`" && -f "${HOME}/.ssh/id_rsa" ]] && \
keychain --nogui --nocolor "${HOME}/.ssh/id_rsa" > /dev/null 2>&1 && \
[[ -f "${HOME}/.keychain/${HOSTNAME}-sh" ]] && \
. "${HOME}/.keychain/${HOSTNAME}-sh"

echo "Your home directory is ${HOME}"
echo "Your current shell is $0"

[[ -x "`whence mesg`" ]] && mesg y > /dev/null 2>&1

[[ -x "`whence uptime`" ]] && uptime
