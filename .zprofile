# /etc/zprofile and ~/.zprofile are run for login shells

# Don't bother if sourced already
[[ -n "$TIME_STYLE" ]] && return

# Source /etc/profile like other shells using sh emulation mode
_src_etc_profile() {
	[[ "$OSTYPE" = *cygwin* ]] && . /etc/zprofile
	emulate -L sh
	[[ "$OSTYPE" != *cygwin* && -f /etc/profile ]] && . /etc/profile
}
_src_etc_profile
unset -f _src_etc_profile

# Default umask
umask 027

# Disable GNU extensions
#export POSIXLY_CORRECT=y
#export POSIX_ME_HARDER=y

# Cygwin environment - add winsymlinks if needed to create shortcuts
[[ "$OSTYPE" = *cygwin* ]] && export CYGWIN=nodosfilewarning

# Locale environment from ~/.i18n
[[ -f "$HOME/.i18n" ]] && . "$HOME/.i18n"
for cat in LANG LANGUAGE LC_ADDRESS LC_COLLATE LC_CTYPE LC_MEASUREMENT \
		LC_MESSAGES LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE LC_TIME; do
	[[ -n ${(P)cat} ]] && export $cat || unset $cat
done
[[ -n "$LOCPATH" ]] && export LOCPATH || unset LOCPATH
export TIME_STYLE=long-iso

# Timezone
#[[ "$OSTYPE" = *gnu* ]] && export TZ=:/etc/localtime

# Make sure some widely used variables are set
export USER=${USER:-$USERNAME}
export HOSTNAME=${HOSTNAME:-$HOST}
export MAIL=${MAIL:-/var/mail/$USERNAME}

# Library path. Set LD_LIBRARY_PATH only if you REALLY know what you are doing
#export LD_LIBRARY_PATH=/usr/local/lib

# Java
[[ -z "$JAVA_HOME" && -d /etc/alternatives/java_sdk ]] && export JAVA_HOME=/etc/alternatives/java_sdk
[[ -z "$JAVA_HOME" && -d /etc/alternatives/jre ]] && export JAVA_HOME=/etc/alternatives/jre
[[ -n "$JAVA_HOME" ]] && export JAVACMD="$JAVA_HOME/bin/java"

# Python
#export -U PYTHONPATH="$HOME/.local/lib/python3.9/site-packages${PYTHONPATH:+:$PYTHONPATH}"

# Path
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/bin" ]] && export PATH="$HOME/bin:$PATH"

# Manual path. You may use /etc/man.conf instead of MANPATH on some systems
[[ -n "$MANPATH" && -d "$HOME/.local/share/man" ]] && export MANPATH="$HOME/.local/share/man/$MANPATH"
[[ -n "$MANPATH" && -d "$HOME/man" ]] && export MANPATH="$HOME/man:$MANPATH"

# Clean up paths, save :: in MANPATH
path=($^path(N^M))
[[ -n "$MANPATH" ]] && export MANPATH=${${MANPATH//::/:/:}/%:/:/}
[[ -n "$MANPATH" ]] && manpath=($^manpath(N^M))
# Remove duplicate and trailing slashes
setopt EXTENDED_GLOB
path=(${${path//\/##/\/}%/})
[[ -n "$MANPATH" ]] && export MANPATH=${${${MANPATH//\/##/\/}//\/:/:}%/}
unsetopt EXTENDED_GLOB
[[ -n "$MANPATH" ]] && export MANPATH=${${MANPATH//:\/:/::}/%\/}

typeset -U path manpath
[[ -z "$MANPATH" ]] && unset MANPATH

#
# Miscellaneous user preferences
#
export BROWSER=firefox
export EDITOR=vi
export FCEDIT=vi
export VISUAL=vi
export WINEDITOR=vi
[[ -n "${commands[less]}" ]] && export PAGER=less || export PAGER=more
export LESS=-CiMqRs
export LESSHISTFILE=-
export LIBVIRT_DEFAULT_URI=qemu:///system
export MORE=-c
export PG=-cn
export READNULLCMD=$PAGER
export SYSTEMD_LESS=$LESS
#export IRCNICK=
#export IRCSERVER=
