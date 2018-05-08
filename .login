# ~/.login

# Use --clear option for additional security
if ( -x "`which keychain`" && -f "${HOME}/.ssh/id_rsa" ) then
  keychain --nogui --nocolor "${HOME}/.ssh/id_rsa" >& /dev/null
  source "${HOME}/.keychain/${HOST}-csh" >& /dev/null
endif

echo "Your home directory is ${HOME}"
echo "Your current shell is $0"

if ( -x "`which mesg`" ) then
  mesg y >& /dev/null
endif

if ( -x "`which uptime`" ) then
  uptime
endif

# Handy with Cygwin allowing to add "Cygwin here" to Windows Explorer
#if ( "${OSTYPE}" == 'cygwin' && $#argv == 1 ) then
#  cd "${@}" && shift || :
#endif
