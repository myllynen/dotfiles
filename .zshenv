# /etc/zshenv and ~/.zshenv are sourced on all invocations of the shell

# Stay in total control of shell initialization,
# source system settings only from ~/.zprofile.
setopt NO_GLOBAL_RCS

# Erase any possible traces of an inferior shell invoking us
unset BASH BASH_VERSION

# Make sure complete environment is available when needed
[[ -t 0 && -o interactive && ! -o login && -n $TERM ]] && . "${HOME}/.zprofile"
