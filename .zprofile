# /etc/zprofile and ~/.zprofile are run for login shells

# Source /etc/profile like other shells using sh emulation mode
_src_etc_profile() {
	[[ "$OSTYPE" = *cygwin* ]] && . /etc/zprofile
	emulate -L sh
	[[ "$OSTYPE" != *cygwin* && -f /etc/profile ]] && . /etc/profile
}
_src_etc_profile
unset -f _src_etc_profile

# Locale environment from ~/.i18n
[[ -f "$HOME/.i18n" ]] && . "$HOME/.i18n"
[[ "$OSTYPE" = *cygwin* ]] && export LANG LC_COLLATE LC_CTYPE LC_TIME
export TIME_STYLE=long-iso

# Disable GNU extensions
#export POSIXLY_CORRECT=y
#export POSIX_ME_HARDER=y

# Do NOT set TZ with GNU libc
[[ "$OSTYPE" = *gnu* ]] && unset TZ

# Cygwin environment - add winsymlinks if needed to create shortcuts
[[ "$OSTYPE" = *cygwin* ]] && export CYGWIN=nodosfilewarning

# Make sure some widely used variables are set
export USER=${USER:-$USERNAME}
export HOSTNAME=${HOSTNAME:-$HOST}
export MAIL=${MAIL:-/var/mail/$USERNAME}

# Java
[[ -z "$JAVA_HOME" && -d /etc/alternatives/java_sdk ]] && export JAVA_HOME=/etc/alternatives/java_sdk
[[ -z "$JAVA_HOME" && -d /etc/alternatives/jre ]] && export JAVA_HOME=/etc/alternatives/jre
[[ -n "$JAVA_HOME" ]] && export JAVACMD="$JAVA_HOME/bin/java"

# Path. Trust the admin to set it up properly
[[ -d "$HOME/bin" ]] && export PATH="$PATH:$HOME/bin"
[[ -d "$HOME/.local/bin" ]] && export PATH="$PATH:$HOME/.local/bin"

# Library path. Set LD_LIBRARY_PATH only if you REALLY know what you are doing
#export LD_LIBRARY_PATH=/usr/local/lib

# Manual path. You may use /etc/man.conf instead of MANPATH on some systems
[[ -n "$MANPATH" && -d "$HOME/man" ]] && export MANPATH="$MANPATH:$HOME/man"

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

# Remove duplicate directories
typeset -U path manpath

# Default umask
umask 022

#
# Miscellaneous user preferences
#
export BROWSER=firefox
export EDITOR=vi
export FCEDIT=vi
export VISUAL=vi
export WINEDITOR=vi
[[ -x "`whence less`" ]] && export PAGER=less || export PAGER=more
export LESS=-CiMqs
export LESSCHARSET=utf-8
export LESSHISTFILE=-
export LIBVIRT_DEFAULT_URI=qemu:///system
export MORE=-c
export PG=-cn
export READNULLCMD=$PAGER
# export IRCNICK=
# export IRCSERVER=
