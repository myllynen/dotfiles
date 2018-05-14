# ~/.bash_profile

# Do .bashrc so that common settings are always set
[[ -f "${HOME}/.bashrc" ]] && . "${HOME}/.bashrc" || :

# Don't bother further without a real TERM
[[ -z "$TERM" || "$TERM" = "dumb" ]] && return

# Use --clear option for additional security
[[ -x "`which keychain 2>/dev/null`" && -f "${HOME}/.ssh/id_rsa" ]] && \
keychain --nogui --nocolor "${HOME}/.ssh/id_rsa" > /dev/null 2>&1 && \
[[ -f "${HOME}/.keychain/${HOSTNAME}-sh" ]] && \
. "${HOME}/.keychain/${HOSTNAME}-sh"

echo "Your home directory is ${HOME}"
echo "Your current shell is $0"

[[ -x "`which mesg 2>/dev/null`" ]] && mesg y > /dev/null 2>&1

[[ -x "`which uptime 2>/dev/null`" ]] && uptime
