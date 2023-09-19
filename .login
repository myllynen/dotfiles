# ~/.login

# Don't bother further without a real TERM
if ( $?TERM == 1 && { eval 'if ( $TERM == dumb ) exit 1' } && $?TMUX == 0 ) then

# Use --clear option for additional security
foreach key ( ed25519 rsa )
	if ( -x "`which keychain`" && -f "${HOME}/.ssh/id_${key}" ) then
		keychain --nogui --nocolor "${HOME}/.ssh/id_${key}" >& /dev/null
		source "${HOME}/.keychain/${HOST}-csh" >& /dev/null
	endif
end

echo "Your home directory is ${HOME}"
echo "Your current shell is $0"

if ( -x "`which mesg`" ) then
	mesg y >& /dev/null
endif

if ( -x "`which uptime`" ) then
	uptime
endif

# Real TERM check endif
endif
