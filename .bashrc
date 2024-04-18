# ~/.bashrc

# Don't bother if sourced already
type -p mktar && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
fi

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
	[[ -n ${!cat} ]] && export $cat || unset $cat
done
[[ -n "$LOCPATH" ]] && export LOCPATH || unset LOCPATH
export TIME_STYLE=long-iso

# Timezone
#[[ "$OSTYPE" = *gnu* ]] && export TZ=:/etc/localtime

# Make sure some widely used variables are set
export USERNAME=${USERNAME:-$USER}
export LOGNAME=${LOGNAME:-$USER}
export HOST=${HOST:-$HOSTNAME}
export MAIL=${MAIL:-/var/mail/$USER}

# Library path. Set LD_LIBRARY_PATH only if you REALLY know what you are doing
#export LD_LIBRARY_PATH=/usr/local/lib

# Java
[[ -z "$JAVA_HOME" && -d /etc/alternatives/java_sdk ]] && export JAVA_HOME=/etc/alternatives/java_sdk
[[ -z "$JAVA_HOME" && -d /etc/alternatives/jre ]] && export JAVA_HOME=/etc/alternatives/jre
[[ -n "$JAVA_HOME" ]] && export JAVACMD="$JAVA_HOME/bin/java"

# Python
#export PYTHONPATH="$HOME/.local/lib/python3.9/site-packages${PYTHONPATH:+:$PYTHONPATH}"

# Path
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/bin" ]] && export PATH="$HOME/bin:$PATH"

# Manual path. You may use /etc/man.conf instead of MANPATH on some systems
[[ -n "$MANPATH" && -d "$HOME/.local/share/man" ]] && export MANPATH="$HOME/.local/share/man/$MANPATH"
[[ -n "$MANPATH" && -d "$HOME/man" ]] && export MANPATH="$HOME/man:$MANPATH"

#
# Miscellaneous user preferences
#
export BROWSER=firefox
export EDITOR=vi
export FCEDIT=vi
export VISUAL=vi
export WINEDITOR=vi
type -P less > /dev/null && export PAGER=less || export PAGER=more
export LESS=-CiMqRs
export LESSHISTFILE=-
export LIBVIRT_DEFAULT_URI=qemu:///system
export MORE=-c
export PG=-cn
export READNULLCMD=$PAGER
export SYSTEMD_LESS=$LESS
#export IRCNICK=
#export IRCSERVER=



# csh compatibility
function setenv () { export "$1"="$2"; }

# Set prompt
if [ $UID -ne 0 ]
then
	PS1='\[\033[32m\]\u@\h:\[\033[00m\]\w\$ '
else
	PS1='\[\033[31m\]\u@\h:\[\033[00m\]\w# '
fi

# Options
GLOBIGNORE=.:..
HISTCONTROL=ignoredups
shopt -s cdable_vars cdspell checkjobs checkwinsize cmdhist dirspell
shopt -s histappend hostcomplete huponexit lithist mailwarn progcomp

# History settings
HISTFILE="$HOME/.bash_history"
HISTSIZE=8000
HISTFILESIZE=9000

# Set terminal type - set only if you have problems
#export TERM=vt100

# Use full bytes for characters
tty -s > /dev/null 2>&1 && stty cs8 || :

# Limits
#ulimit -c 0
DIRSTACKSIZE=64
LISTMAX=0

# Watch for some friends
#watch=(notme)
#WATCHFMT='%n %a %l from %m at %T'
#LOGCHECK=60

# Mail check interval
MAILCHECK=60

# Don't logout automagically
TMOUT=0

# Aliases
alias cd~='cd ~'
alias ind='indent -kr -nbbo -bl -bli0 -bls -nce -cli4 -nut -c0 -cd0 -cp0'
alias l='ls -l'
alias la='ls -al'
alias lale='ls -al | $PAGER'
alias lh='last | head'
alias ll='ls -l'
alias lsd='ls -ld [^.]*/'
alias grep='grep --color=tty'
alias reset="printf '\033\143'"
alias wget='wget --hsts-file=/dev/null'
alias systemctl='systemctl -l -n 50'
alias journalctl='journalctl -l -n 50'
alias lbigrpms='rpm -qa --qf "%{size}\t%{name}\n" | sort -nr | $PAGER'
type -P vim > /dev/null && alias vi='vim -u ~/.vimrc'
alias vim="vim -u ~/.vimrc"
alias bc='bc -l ~/.bcrc'

# Always play it safe when super-user
if [ $UID -eq 0 ]
then
	alias cp='cp -i'
	alias mv='mv -i'
	alias rm='rm -i'
fi

# Get rid of some stupid aliases/options which might be set
unset SSH_ASKPASS

# ls(1) colors and other options
eval `dircolors --sh 2> /dev/null`
[[ -z "$LS_COLORS" ]] && export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
case "$OSTYPE"
in
	*gnu*|*linux*|*cygwin*)
		alias ls='ls -h --literal --show-control-chars --color=auto'
		;;
	*darwin*|*freebsd*)
		alias ls='ls -G -h'
		export CLICOLOR=yes
		# GNU ls(1) style colors
		export LSCOLORS="ExGxFxdxCxDxDxCxCxExEx"
		# Expect xterm to support colors
		[[ "$TERM" = "xterm" ]] && export TERM=xterm-color
		;;
	*netbsd*|*openbsd*|*solaris*)
		alias ls='ls -F -h'
		;;
	*)
		alias ls='ls -F'
		;;
esac

# less
type -P lesspipe.sh > /dev/null && export LESSOPEN="| lesspipe.sh %s"

# Functions

# Helper
function istext () {
	[[ $# -eq 0 ]] && echo "Usage: $FUNCNAME <file> [message]" 1>&2 && return 1
	local rc
	file "$1" | grep text > /dev/null 2>&1 && return 0
	rc=$?
	if [[ -n "$2" ]]
	then
		echo "$2 $1: not a text file" 1>&2
	else
		echo "$FUNCNAME: $1: not a text file" 1>&2
	fi
	return $rc
}

function lstar () { _lstar lstar "$@"; }
function untar () { _lstar untar "$@"; }
function _lstar () {
	[[ $# -lt 2 ]] && echo "Usage: $1 <archive> [file(s)]" 1>&2 && return 1
	local f="$2" filter flags=tf
	[[ "$1" = "untar" ]] && flags="xf" && [[ ! -w . || ! -x . ]] && echo "$1: permission denied: `pwd`" 1>&2 && return 1
	shift ; shift
	case "$f"
	in
		*.tar.gz|*.tar.[zZ]|*.tgz|*.TGZ)
			filter=gzip
			;;
		*.tar.bz2|*.tbz2|*.tbz)
			filter=bzip2
			;;
		*.tar.xz|*.txz)
			filter=xz
			;;
		*.tar.zst|*.tar.zstd)
			filter=zstd
			;;
	esac
	if [[ -n "$filter" ]]
	then
		nice "$filter" -dc "$f" | nice tar "$flags" - "$@"
	else
		nice tar "$flags" "$f" "$@"
	fi
}

function mktar     () { _mktar mktar     "$@"; }
function mktargz   () { _mktar mktargz   "$@"; }
function mktarbz2  () { _mktar mktarbz2  "$@"; }
function mktarxz   () { _mktar mktarxz   "$@"; }
function mktarzstd () { _mktar mktarzstd "$@"; }
function _mktar () {
	[[ $# -ne 2 ]] && echo "Usage: $1 <directory>" 1>&2 && return 1
	[[ ! -d "$2" ]] && echo "$1: no such directory: $2" 1>&2 && return 1
	[[ ! -x "$2" ]] && echo "$1: permission denied: $2" 1>&2 && return 1
	[[ ! -w "$2"/.. || ! -x "$2"/.. ]] && echo "$1: permission denied: $2/.." 1>&2 && return 1
	local dir filter location
	location="`pwd`"
	cd "$2"
	dir="`basename "\`pwd\`"`"
	if [[ "$dir" = "/" ]]
	then
		echo "$1: I will not process /" 1>&2
		cd "$location" ; location=
		return 1
	fi
	cd ..
	case "$1"
	in
		mktar)
			filter=/bin/true
			;;
		mktargz)
			filter=gzip
			;;
		mktarbz2)
			filter=bzip2
			;;
		mktarxz)
			filter=xz
			flags=q
			;;
		mktarzstd)
			filter=zstd
			flags="q --rm"
			;;
	esac
	nice tar cf "$dir.tar" "$dir"
	nice "$filter" -9$flags "$dir.tar" || rm -f "$dir.tar"
	cd "$location" ; location=
}

function dud () {
	local flags
	case "$OSTYPE"
	in
		*darwin*|*freebsd*|*gnu*|*linux*|*netbsd*|*openbsd*|*solaris*|*cygwin*)
			flags=sh
			;;
		*)
			flags=s
			;;
	esac
	du -$flags */ .
}

function lbig () {
	'ls' -lF "$@" | sort -rn -k5 | grep -v total | $PAGER
}

function dos2mac  () { _x2y dos2mac  "$@"; }
function dos2unix () { _x2y dos2unix "$@"; }
function mac2dos  () { _x2y mac2dos  "$@"; }
function mac2unix () { _x2y mac2unix "$@"; }
function unix2dos () { _x2y unix2dos "$@"; }
function unix2mac () { _x2y unix2mac "$@"; }
function _x2y () {
	[[ $# -ne 2 ]] && echo "Usage: $1 <file>" 1>&2 && return 1
	[[ ! -w . || ! -x . ]] && echo "$1: permission denied: `pwd`" 1>&2 && return 1
	istext "$2" "$1: skipping" || return 1
	local rand="$RANDOM"
	case "$1"
	in
		dos2mac)
			tr -d '\n' < "$2" > "$1.$$.$rand"
			;;
		dos2unix)
			tr -d '\r' < "$2" > "$1.$$.$rand"
			;;
		mac2dos)
			awk 'BEGIN{RS="\r";ORS="\r\n"}{print $0}' < "$2" > "$1.$$.$rand"
			;;
		mac2unix)
			tr '\r' '\n' < "$2" > "$1.$$.$rand"
			;;
		unix2dos)
			awk -- '{printf("%s\r\n",$0);}' < "$2" > "$1.$$.$rand"
			;;
		unix2mac)
			tr '\n' '\r' < "$2" > "$1.$$.$rand"
			;;
	esac
	diff "$2" "$1.$$.$rand" > /dev/null 2>&1
	if [[ $? -eq 1 ]]
	then
		cat "$1.$$.$rand" > "$2"
	fi
	rm -f "$1.$$.$rand"
}

function jpg2pdf () {
	mv "$1" "${1/.JPG/.jpg}" > /dev/null 2>&1
	f="${1/.JPG/.jpg}"
	convert -strip -auto-orient -quality 50% -resize 50% "$f" "${f/.jpg/-tmp.jpg}"
	convert "${f/.jpg/-tmp.jpg}" "${f/.jpg/.pdf}"
	rm -f "${f/.jpg/-tmp.jpg}"
}

function ps2mps () {
	[[ $# -eq 0 ]] && echo "Usage: $FUNCNAME [--pages N] <infile>" 1>&2 && return 1
	[[ ! -w . || ! -x . ]] && echo "$FUNCNAME: permission denied: `pwd`" 1>&2 && return 1
	local pages=4
	[[ "$1" = "--pages" ]] && pages="$2" && shift 2
	file "$1" | grep PostScript > /dev/null 2>&1
	[[ $? -ne 0 ]] && echo "$FUNCNAME: skipping $1: not a PostScript document" 1>&2 && return 1
	psnup -pa4 -Pa4 -nup "$pages" "$1" "$1.multi.ps"
}

function pdfstrip () {
	gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dFirstPage=1 -dLastPage=1 -sOutputFile="$1".tmp "$1"
	mv "$1".tmp "$1"
}

function pdfpw () {
	[[ ! -r "$1" ]] && echo "Usage: $0 <file.pdf>" 1>&2 && return 1
	local old new
	local enc_opts="-dKeyLength=128 -dEncryptionR=3"
	echo "Enter current PDF password:"
	read -s old
	echo "Enter new PDF password:"
	read -s new
	[[ -z "$new" ]] && enc_opts=
	echo -n "Writing \"new-$1\"... "
	gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -dPassThroughJPEGImages=true ${enc_opts} -sPDFPassword="$old" -sOwnerPassword="$new" -sUserPassword="$new" -sOutputFile="new-$1" "$1" > /dev/null 2>&1
	[[ $? -eq 0 ]] && echo "ok." || (rm -f "new-$1" ; echo "failed.")
}

function txt2pdf () { _txt2p txt2pdf "$@"; }
function txt2ps () { _txt2p txt2ps "$@"; }
function _txt2p () {
	cmd=$0 ; shift
	[[ $# -eq 0 ]] && echo "Usage: $0 <infile>" 1>&2 && return 1
	[[ ! -w . || ! -x . ]] && echo "$0: permission denied: `pwd`" 1>&2 && return 1
	istext "$1" "$0: skipping" || return 1
	local fmt=${cmd/txt2}
	enscript -BhR -f Times-Roman12 -i 4 -M A4 -N n -t "$1" -T 4 -o "$1.ps" "$1" 2>&1 | sed -e "s/ps$/$fmt/"
	[[ $fmt = pdf ]] && ps2pdf "$1.ps" "$1.pdf" && rm -f "$1.ps" || :
}

function rmws () {
	# Remove spaces and tabs from EOLs if exist
	[[ $# -ne 1 ]] && echo "Usage: $FUNCNAME <file>" 1>&2 && return 1
	[[ ! -w . || ! -x . ]] && echo "$FUNCNAME: permission denied: `pwd`" 1>&2 && return 1
	istext "$1" "$FUNCNAME: skipping" || return 1
	grep "[ 	]$" "$1" > /dev/null 2>&1 || return 0
	local rand="$RANDOM"
	sed -e 's/[ 	]*$//g' < "$1" > "$FUNCNAME.$$.$rand"
	cat "$FUNCNAME.$$.$rand" > "$1"
	rm -f "$FUNCNAME.$$.$rand"
}

function tailc () {
	tail -f "$@" | xargs -IL date +"%H:%M:%S L"
}

function pst () {
	local asc ptree="`command -v pstree 2>/dev/null`"
	[[ -n "$ptree" ]] && "$ptree" -A > /dev/null 2>&1 && asc=-A
	[[ -z "$ptree" ]] && ptree="`command -v proctree 2>/dev/null`"
	[[ -z "$ptree" ]] && echo "$FUNCNAME: command not found" 1>&2 && return 1
	[[ $# -eq 0 ]] && "$ptree" $asc || $PAGER || :
	[[ $# -gt 0 ]] && "$ptree" $asc -p "$@" | $PAGER || :
}

function killmy () {
	[[ $# -ne 1 ]] && echo "Usage: $FUNCNAME <process>" 1>&2 && return 1
	local pslist sig proc psargs grepws=" "
	[[ "$OSTYPE" = *aix* ]] && psargs="-o pid,args -U"
	[[ "$OSTYPE" = *cygwin* ]] && psargs=-u && grepws=""
	[[ "$OSTYPE" = *netbsd* ]] && psargs=-xU
	[[ -z "$psargs" ]] && psargs=-U
	echo -n "$FUNCNAME: sending signals:"
	for sig in HUP TERM KILL
	do
		echo -n " $sig"
		pslist=$( ps ${psargs} "`whoami`" | grep "${grepws}$1" | awk '{print $1}' | tr '\n' ' ' )
		for proc in ${pslist}
		do
			kill -"$sig" "$proc" 2> /dev/null
		done
		sleep 1
	done
	echo
}

function killuser () {
	[[ $# -ne 1 ]] && echo "Usage: $FUNCNAME <user>" 1>&2 && return 1
	[[ $UID -ne 0 ]] && [[ "$1" != "`whoami`" ]] && [[ "$OSTYPE" != *cygwin* ]] && echo "$FUNCNAME: permission denied: $1" 1>&2 && return 1
	local pslist sig proc psargs
	[[ "$OSTYPE" = *solaris* || "$OSTYPE" = *aix* || "$OSTYPE" = *irix* ]] && psargs=-fU
	[[ "$OSTYPE" = *cygwin* ]] && psargs=-fu
	[[ -z "$psargs" ]] && psargs="uw -U"
	echo -n "$FUNCNAME: sending signals:"
	for sig in HUP TERM KILL
	do
		echo -n " $sig"
		pslist=$( ps ${psargs} "$1" 2> /dev/null | awk '{print $2}' | tr '\n' ' ' | tr -d '[:alpha:]' )
		for proc in ${pslist}
		do
			kill -"$sig" "$proc" 2> /dev/null
		done
		sleep 1
	done
	echo
}

# Completion control
if [ -f /etc/bash_completion -a -z "$BASH_COMPLETION" ]; then
	. /etc/bash_completion
fi

# Terminal title
case $TERM
in
	cygwin*)
		PROMPT_COMMAND='echo -ne "\033];${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
		;;
	gnome*|putty|*rxvt*|*xterm*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
		;;
	konsole*)
		PROMPT_COMMAND='echo -ne "\033]30;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
		;;
	screen*|tmux*)
		function prompt_command () {
			echo -ne "\033k${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"
			[[ -z "$TERMCAP" ]] && echo -ne '\033]2;'${USER}@${HOSTNAME%%.*}':'${PWD/#$HOME/\~}'\033\\'
		}
		PROMPT_COMMAND=prompt_command
		;;
esac
