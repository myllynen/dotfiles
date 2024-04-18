# /etc/zshenv and ~/.zshenv are sourced on all invocations of the shell

# Stay in total control of shell initialization,
# source system settings only from ~/.zprofile.
setopt NO_GLOBAL_RCS

# Ensure SHELL is always correctly set
[[ $SHELL =~ zsh ]] || export SHELL="${commands[zsh]}"

# Erase possible traces of an inferior shell invoking us
unset BASH BASH_VERSION

# Ensure shell profile is initialized only once
[[ -z "$TIME_STYLE" ]] && . "${HOME}/.zprofile"
