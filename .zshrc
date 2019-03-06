# /etc/zshrc and ~/.zshrc are sourced in interactive shells

# Shell functions
setenv () { export "$1"="$2" }	# csh compatibility

# Prompt
if [ $UID -ne 0 ]
then
	PROMPT='%n@%m:%~> '
else
	PROMPT='%n@%m:%~# '
fi
#RPROMPT=''

# Options
setopt \
	NO_ALWAYS_LAST_PROMPT \
	ALWAYS_TO_END \
	APPEND_HISTORY \
	AUTO_CD \
	AUTO_LIST \
	AUTO_NAME_DIRS \
	AUTO_PUSHD \
	NO_AUTO_REMOVE_SLASH \
	NO_BEEP \
	CDABLE_VARS \
	CLOBBER \
	CORRECT_ALL \
	CSH_NULL_GLOB \
	FLOW_CONTROL \
	NO_HIST_BEEP \
	HIST_FIND_NO_DUPS \
	HIST_IGNORE_DUPS \
	HIST_REDUCE_BLANKS \
	HUP \
	KSH_OPTION_PRINT \
	NO_LIST_BEEP \
	NO_LIST_TYPES \
	MAIL_WARNING \
	MARK_DIRS \
	MENU_COMPLETE \
	MULTIOS \
	NO_NOMATCH \
	NOTIFY \
	PRINT_EXIT_VALUE \
	NO_PROMPT_CR \
	PUSHD_IGNORE_DUPS

# Key bindings for Linux/BSD/X11/Solaris
# bindkey -v      # vi key bindings
bindkey -e        # emacs key bindings
bindkey ' '       magic-space
bindkey '\e[1~'   beginning-of-line
bindkey '\e[7~'   beginning-of-line
bindkey '\e[H'    beginning-of-line
bindkey '\eOH'    beginning-of-line
bindkey '\e[214z' beginning-of-line
bindkey '\e[2~'   overwrite-mode
bindkey '\e[L'    overwrite-mode
bindkey '\e[247z' overwrite-mode
bindkey '\e[3~'   delete-char
[[ "$OSTYPE" = *freebsd* || "$OSTYPE" = *solaris* ]] && bindkey '\C-?' delete-char
bindkey '\e[4~'   end-of-line
bindkey '\e[8~'   end-of-line
bindkey '\e[F'    end-of-line
bindkey '\eOF'    end-of-line
bindkey '\e[220z' end-of-line
bindkey '\C-f'    forward-word
bindkey '\e[1;5C' forward-word
bindkey '\e[5C'   forward-word
bindkey '\C-b'    backward-word
bindkey '\e[1;5D' backward-word
bindkey '\e[5D'   backward-word
bindkey '\C-u'    backward-kill-line
bindkey '\C-w'    backward-kill-word

# History settings
HISTFILE="$HOME/.zhistory"
HISTSIZE=9000
SAVEHIST=8000

# Menu-driven history search
autoload -Uz history-beginning-search-menu
zle -N history-beginning-search-menu
bindkey ^X^X history-beginning-search-menu

# Set terminal type - set only if you have problems
#export TERM=vt100

# Use full bytes for characters
[[ -n "$TTY" ]] && stty cs8

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
alias cp='nocorrect cp'
alias mv='nocorrect mv'
alias rm='nocorrect rm'
alias mkdir='nocorrect mkdir'
alias touch='nocorrect touch'
alias cd~='cd ~'
alias ind='indent -kr -nbbo -bl -bli0 -bls -nce -cli4 -nut -c0 -cd0 -cp0'
alias l='ls -l'
alias la='ls -al'
alias lale='ls -al | $PAGER'
alias lh='last | head'
alias ll='ls -l'
alias lsd='ls -ld *(/^M)'
alias grep='grep --color=tty'
alias nano='nano -A -M -N -S -c -w -x -z'
#alias wget='wget --hsts-file=/dev/null'
alias lbigrpms='rpm -qa --qf "%{size}\t%{name}\n" | sort -nr | $PAGER'
[[ -n ${commands[vim]} ]] && alias vi=vim
unalias which > /dev/null 2>&1 || :

# Always play it safe when super-user
if [ $UID -eq 0 ]
then
	alias cp='nocorrect cp -i'
	alias mv='nocorrect mv -i'
	alias rm='nocorrect rm -i'
fi

# Get rid of some stupid aliases/options which might be set
unset SSH_ASKPASS

# ls(1) colors and other options
eval `dircolors --sh 2> /dev/null`
[[ -z "$LS_COLORS" ]] && export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
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
[[ -n ${commands[lesspipe.sh]} ]] && export LESSOPEN="| lesspipe.sh %s"

# Functions

# Helper
function istext () {
	[[ $# -eq 0 ]] && echo "Usage: $0 <file> [message]" 1>&2 && return 1
	local rc
	file "$1" | grep text > /dev/null 2>&1 && return 0
	rc=$?
	if [[ -n "$2" ]]
	then
		echo "$2 $1: not a text file" 1>&2
	else
		echo "$0: $1: not a text file" 1>&2
	fi
	return $rc
}

# Enable Unicode character insertion with Ctrl-U + <code> + Ctrl-U
function zle_enable_unicode_insert () {
	autoload -Uz insert-unicode-char
	zle -N insert-unicode-char
	bindkey ^U insert-unicode-char
	echo "$0: bound Ctrl-U to insert-unicode-char"
}

function cpd () {
	trap 'trap - INT ; bindkey "^M" accept-line ; return 1' INT
	local cpd_var
	bindkey -s "^M" "^X^W"
	bindkey "^[k" kill-region
	bindkey -s "^X^W" "^[2^[|^A cd ^A^@^[<^[k^E^@^[>^E^[k^[a^X^K"
	cpd_var=`dirs -v | sed -e 's/\"/\\\"/g' | tr '\t' '"' | sed -e 's/^[0-9]*//g' | awk -- '{printf("%s\"\n",$0);}' | sed -e 's,\"\(~.*\)\",\1,g'`
	vared cpd_var
	bindkey "^M" accept-line
	eval "$cpd_var"
	trap - INT
}

function {ls,un}tar () {
	[[ $# -eq 0 ]] && echo "Usage: $0 <archive> [file(s)]" 1>&2 && return 1
	local f="$1" filter flags=tf
	[[ "$0" = "untar" ]] &&	flags="xf" && [[ ! -w . || ! -x . ]] && echo "$0: permission denied: `pwd`" 1>&2 && return 1
	shift
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
	esac
	if [[ -n "$filter" ]]
	then
		nice "$filter" -dc "$f" | nice tar "$flags" - "$@"
	else
		nice tar "$flags" "$f" "$@"
	fi
}

function mktar{,gz,bz2,xz} () {
	[[ $# -ne 1 ]] && echo "Usage: $0 <directory>" 1>&2 && return 1
	[[ ! -d "$1" ]] && echo "$0: no such directory: $1" 1>&2 && return 1
	[[ ! -x "$1" ]] && echo "$0: permission denied: $1" 1>&2 && return 1
	[[ ! -w "$1"/.. || ! -x "$1"/.. ]] && echo "$0: permission denied: $1/.." 1>&2 && return 1
	local dir filter location
	location="`pwd`"
	cd "$1"
	dir="`basename "\`pwd\`"`"
	if [[ "$dir" = "/" ]]
	then
		echo "$0: I will not process /" 1>&2
		cd "$location" ; location=
		return 1
	fi
	cd ..
	case "$0"
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
	du -$flags *(/ND) .
}

function lbig () {
	'ls' -lF "$@" | sort -rn -k5 | grep -v total | $PAGER
}

function {dos2mac,dos2unix,mac2dos,mac2unix,unix2dos,unix2mac} () {
	[[ $# -ne 1 ]] && echo "Usage: $0 <file>" 1>&2 && return 1
	[[ ! -w . || ! -x . ]] && echo "$0: permission denied: `pwd`" 1>&2 && return 1
	istext "$1" "$0: skipping" || return 1
	local rand="$RANDOM"
	case "$0"
	in
		dos2mac)
			tr -d '\n' < "$1" > "$0.$$.$rand"
			;;
		dos2unix)
			tr -d '\r' < "$1" > "$0.$$.$rand"
			;;
		mac2dos)
			awk 'BEGIN{RS="\r";ORS="\r\n"}{print $0}' < "$1" > "$0.$$.$rand"
			;;
		mac2unix)
			tr '\r' '\n' < "$1" > "$0.$$.$rand"
			;;
		unix2dos)
			awk -- '{printf("%s\r\n",$0);}' < "$1" > "$0.$$.$rand"
			;;
		unix2mac)
			tr '\n' '\r' < "$1" > "$0.$$.$rand"
			;;
	esac
	diff "$1" "$0.$$.$rand" > /dev/null 2>&1
	if [[ $? -eq 1 ]]
	then
		cat "$0.$$.$rand" > "$1"
	fi
	rm -f "$0.$$.$rand"
}

function ps2mps () {
	[[ $# -eq 0 ]] && echo "Usage: $0 [--pages N] <infile>" 1>&2 && return 1
	[[ ! -w . || ! -x . ]] && echo "$0: permission denied: `pwd`" 1>&2 && return 1
	local pages=4
	[[ "$1" = "--pages" ]] && pages="$2" && shift 2
	file "$1" | grep PostScript > /dev/null 2>&1
	[[ $? -ne 0 ]] && echo "$0: skipping $1: not a PostScript document" 1>&2 && return 1
	psnup -pa4 -Pa4 -nup "$pages" "$1" "$1.multi.ps"
}

function txt2ps () {
	[[ $# -eq 0 ]] && echo "Usage: $0 [--lines N] <infile>" 1>&2 && return 1
	[[ ! -w . || ! -x . ]] && echo "$0: permission denied: `pwd`" 1>&2 && return 1
	local lines=75
	[[ "$1" = "--lines" ]] && lines="$2" && shift 2
	istext "$1" "$0: skipping" || return 1
	enscript --no-header --font=Courier10 --no-job-header --indent=8 --lines-per-page="$lines" --newline=n --output="$1.ps" --portrait --tabsize=8 "$1"
}

function jpg2pdf () {
	mv "$1" "${1/.JPG/.jpg}" > /dev/null 2>&1
	f="${1/.JPG/.jpg}"
	convert -strip -auto-orient -quality 50% -resize 50% "$f" "${f/.jpg/-tmp.jpg}"
	convert "${f/.jpg/-tmp.jpg}" "${f/.jpg/.pdf}"
	rm -f "${f/.jpg/-tmp.jpg}"
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
	gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -dPassThroughJPEGImages=true ${=enc_opts} -sPDFPassword="$old" -sOwnerPassword="$new" -sUserPassword="$new" -sOutputFile="new-$1" "$1" > /dev/null 2>&1
	[[ $? -eq 0 ]] && echo "ok." || (rm -f "new-$1" ; echo "failed.")
}

function rmws () {
	# Remove spaces and tabs from EOLs if exist
	[[ $# -ne 1 ]] && echo "Usage: $0 <file>" 1>&2 && return 1
	[[ ! -w . || ! -x . ]] && echo "$0: permission denied: `pwd`" 1>&2 && return 1
	istext "$1" "$0: skipping" || return 1
	grep "[ 	]$" "$1" > /dev/null 2>&1 || return 0
	local rand="$RANDOM"
	sed -e 's/[ 	]*$//g' < "$1" > "$0.$$.$rand"
	cat "$0.$$.$rand" > "$1"
	rm -f "$0.$$.$rand"
}

function pst () {
	local asc ptree="`whence pstree`"
	[[ -n "$ptree" ]] && "$ptree" -A > /dev/null 2>&1 && asc=-A
	[[ -z "$ptree" ]] && ptree="`whence proctree`"
	[[ -z "$ptree" ]] && echo "$0: command not found" 1>&2 && return 1
	[[ $# -eq 0 ]] && "$ptree" $asc | $PAGER || :
	[[ $# -gt 0 ]] && "$ptree" $asc -p "$@" | $PAGER || :
}

function killmy () {
	[[ $# -ne 1 ]] && echo "Usage: $0 <process>" 1>&2 && return 1
	local pslist sig proc psargs grepws=" "
	[[ "$OSTYPE" = *aix* ]] && psargs="-o pid,args -U"
	[[ "$OSTYPE" = *cygwin* ]] && psargs=-u && grepws=""
	[[ "$OSTYPE" = *netbsd* ]] && psargs=-xU
	[[ -z "$psargs" ]] && psargs=-U
	echo -n "$0: sending signals:"
	for sig in HUP TERM KILL
	do
		echo -n " $sig"
		pslist=$( ps ${=psargs} "`whoami`" | grep "${grepws}$1" | awk '{print $1}' | tr '\n' ' ' )
		for proc in ${=pslist}
		do
			kill -"$sig" "$proc" 2> /dev/null
		done
		sleep 1
	done
	echo
}

function killuser () {
	[[ $# -ne 1 ]] && echo "Usage: $0 <user>" 1>&2 && return 1
	[[ $UID -ne 0 ]] && [[ "$1" != "`whoami`" ]] && [[ "$OSTYPE" != *cygwin* ]] && echo "$0: permission denied: $1" 1>&2 && return 1
	local pslist sig proc psargs
	[[ "$OSTYPE" = *solaris* || "$OSTYPE" = *aix* || "$OSTYPE" = *irix* ]] && psargs=-fU
	[[ "$OSTYPE" = *cygwin* ]] && psargs=-fu
	[[ -z "$psargs" ]] && psargs="uw -U"
	echo -n "$0: sending signals:"
	for sig in HUP TERM KILL
	do
		echo -n " $sig"
		pslist=$( ps ${=psargs} "$1" 2> /dev/null | awk '{print $2}' | tr '\n' ' ' | tr -d '[:alpha:]' )
		for proc in ${=pslist}
		do
			kill -"$sig" "$proc" 2> /dev/null
		done
		sleep 1
	done
	echo
}

function {cd,dvd}-{blank,blank-full,burn-iso,checksum,eject,fixate,read-iso,write-dir,write-dir-close-disc} () {
	# http://fy.chalmers.se/~appro/linux/DVD+RW/tools/win32/*.exe -> C:\Windows
	local label msinfo ret=0 sess tgtdev
	[[ -n ${commands[cdrecord]} ]] || return 1
	[[ -z "$_cd_dev" && -z "$_dvd_dev" ]] && umount $(mount -t iso9660 2> /dev/null | awk '{print $1}' | tr '\n' ' ') > /dev/null 2>&1
	[[ -z "$_cd_dev" ]] && _cd_dev=$(cdrecord --devices | awk -F "'" '/CD/ {print $2}' | head -n 1)
	[[ -z "$_dvd_dev" ]] && _dvd_dev=$(cdrecord --devices | awk -F "'" '/DVD/ {print $2}' | head -n 1)
	if [ -z "$_dvd_dev" ]; then
		local t=$(cdrecord -scanbus | awk -F "'" '/DVD/ {print $2}' | head -n 1)
		[[ -z "$t" ]] && t=$(cdrecord -scanbus | awk -F "'" '/CD/ {print $2}' | head -n 1)
		_dvd_dev=$(cdrecord --devices | awk -F "'" '/'$t'/ {print $2}' | head -n 1)
	fi
	[[ -z "$_dvd_dev" ]] && _dvd_dev=$(cdrecord -prcap 2>&1 | awk '/Detected .* drive/ {print $NF}' | head -n 1)
	[[ -z "$_cd_dev" ]] && _cd_dev=$_dvd_dev
	[[ "$0" =~ "cd-*"  ]] && tgtdev=$_cd_dev
	[[ "$0" =~ "dvd-*" ]] && tgtdev=$_dvd_dev
	umount $tgtdev > /dev/null 2>&1
	case "$0"
	in
		cd-blank)
			cdrecord -eject -force blank=fast dev=$tgtdev
			ret=$?
			;;
		dvd-blank)
			dvd+rw-format -force $tgtdev
			ret=$?
			dvd-eject
			;;
		cd-blank-full)
			cdrecord -eject -force blank=all dev=$tgtdev
			ret=$?
			;;
		dvd-blank-full)
			growisofs -dvd-compat -Z $tgtdev=/dev/zero
			ret=$?
			dvd-eject
			;;
		cd-burn-iso)
			cdrecord -v -eject -data -sao dev=$tgtdev "$1"
			ret=$?
			;;
		dvd-burn-iso)
			growisofs -dvd-compat -Z $tgtdev="$1"
			ret=$?
			dvd-eject
			;;
		*-checksum)
			local blocks media tdev=$tgtdev tgtiso tmp
			[[ "$0" = "cd-checksum" ]] && blocks=$(cdrecord -toc dev=$tgtdev | tail -n 1 | awk '{print $3}')
			[[ "$0" = "dvd-checksum" ]] && blocks=$(dvd+rw-mediainfo $tgtdev | awk -F= '/CAPACITY/ {print $2 / 2048}')
			[[ "$OSTYPE" = "cygwin" ]] && for d in /dev/s* ; do cygpath -w $d | grep -q $tgtdev && tdev=$d ; done
			media=$(dvd+rw-mediainfo $tgtdev | awk '/Mounted Media/ {print $4}')
			[[ "$media" = "DVD+R" || "$media" = "DVD+RW" ]] && echo "$media checksumming is not always accurate."
			tmp=$(expr $(isosize $tdev) / 2048)
			[[ $(expr $blocks - $tmp) -gt 256 ]] && blocks=$tmp
			echo "Checksumming $(expr $blocks / 512) MB..."
			dd if=$tdev bs=2048 count=$blocks | md5sum | sed -e 's,-,CD/DVD,'
			ret=$?
			;;
		*-eject)
			local eject
			[[ "$OSTYPE" = "cygwin" ]] && eject="cdrecord -eject dev=" || eject="eject "
			eval $eject$tgtdev > /dev/null 2>&1
			;;
		cd-fixate)
			cdrecord -v -eject -fix dev=$tgtdev
			ret=$?
			;;
		dvd-fixate)
			dvd+rw-format -lead-out $tgtdev
			ret=$?
			dvd-eject
			;;
		*-read-iso)
			local blocks tdev=$tgtdev tgtiso tmp
			[[ "$0" = "cd-read-iso" ]] && blocks=$(cdrecord -toc dev=$tgtdev | tail -n 1 | awk '{print $3}')
			[[ "$0" = "dvd-read-iso" ]] && blocks=$(dvd+rw-mediainfo $tgtdev | awk -F= '/CAPACITY/ {print $2 / 2048}')
			[[ "$OSTYPE" = "cygwin" ]] && for d in /dev/s* ; do cygpath -w $d | grep -q $tgtdev && tdev=$d ; done
			tmp=$(expr $(isosize $tdev) / 2048)
			[[ $(expr $blocks - $tmp) -gt 256 ]] && blocks=$tmp
			echo "Enter name for the target ISO file (size $(expr $blocks / 512) MB):"
			read tgtiso
			echo "Creating $tgtiso..."
			dd if=$tdev of=$tgtiso bs=2048 count=$blocks
			ret=$?
			;;
		cd-write-dir|cd-write-dir-close-disc)
			local multi
			[[ "$0" = "cd-write-dir" ]] && multi=-multi
			msinfo=$(cdrecord -msinfo dev=$tgtdev 2> /dev/null)
			if [ -n "$msinfo" ]; then
				sess="-C $msinfo -M $tgtdev"
			fi
			find "$1" -print | sort
			echo "Enter disc label: "
			read label
			mkisofs -quiet -J -l -r -input-charset UTF-8 -joliet-long -V "$label" ${=sess} "$1" | \
				cdrecord -v -eject -data $multi -tao dev=$tgtdev -
			ret=$?
			;;
		dvd-write-dir|dvd-write-dir-close-disc)
			local compat=-dvd-compat cs=UTF-8 media tdev=$tgtdev
			[[ "$OSTYPE" = "cygwin" ]] && cs=iso8859-1
			[[ "$OSTYPE" = "cygwin" ]] && for d in /dev/s* ; do cygpath -w $d | grep -q $tgtdev && tdev=$d ; done
			media=$(dvd+rw-mediainfo $tgtdev | awk '/Mounted Media/ {print $4}')
			if [ "$0" = "dvd-write-dir-close-disc" ]; then
				if [ "$media" = "DVD-RW" -o "$media" = "DVD+RW" ]; then
					echo "Can't close a DVD±RW disc." 1>&2
					return 1
				fi
			else
				if [ "$media" = "DVD-R" -o "$media" = "DVD+R" ]; then
					compat=
				fi
			fi
			msinfo=$(isosize $tdev 2> /dev/null || echo 0)
			[[ $msinfo -eq 0 ]] && sess=-Z || sess=-M
			find "$1" -print | sort
			echo "Enter disc label: "
			read label
			growisofs -quiet -J -l -r -input-charset $cs -V "$label" $compat $sess $tgtdev "$1"
			ret=$?
			if [ "$0" = "dvd-write-dir-close-disc" ]; then
				if [ "$media" = "DVD-R" -o "$media" = "DVD+R" ]; then
					dvd+rw-mediainfo $tgtdev | grep -q appendable
					if [ $? -eq 0 ]; then
						growisofs -dvd-compat -M $tgtdev=/dev/zero
					fi
				fi
			fi
			ret=$?
			dvd-eject
			;;
	esac
	return $ret
}

# Completion control
compctl -D -g '*(-)' + -g '*(-D) ..' + -x 'S[..]' -k '(..)' -qS/
compctl -g '*.(tar|t[abgpx]z|tz|tar.gz|tar.Z|tarZ|tbz2|tar.bz2|tar.xz)' + -g '*(-/) ..' {ls,un}tar
compctl -g '*(-/)' + -g '*(-D/) ..' + -x 'S[..]' -k '(..)' -qS/ -- cd mktar{,gz,bz2,xz} {cd,dvd}-write-dir{,-close-disc}
compctl -g '*.(iso|ISO)' + -g '*(-/) ..' {cd,dvd}-burn-iso
compctl -g '*.(pdf|PDF)' + -g '*(-/) ..' pdfstrip
compctl -g '*.(jpg|JPG)' + -g '*(-/) ..' jpg2pdf

# ps(1) / kill(1) related
compctl -s '`ps xcw -ocommand | grep -v COMMAND`' killmy
if [[ $UID -eq 0 ]]
then
	compctl -s "\$(ps aux | grep -v \^USER | awk '{print \$1}')" killuser
fi
if [[ $UID -ne 0 ]] || [[ "$OSTYPE" = *openbsd* ]]
then
	compctl -s '`ps xcw -ocommand | grep -v COMMAND`' + \
		-x 's[-] p[1]' -k "($signals[1,-3])" -- killall
	compctl -s '`ps x -opid | tail -n +2`' + \
		-x 's[-] p[1]' -k "($signals[1,-3])" -- kill
else
	compctl -s '`ps xacw -ocommand | grep -v COMMAND`' + \
		-x 's[-] p[1]' -k "($signals[1,-3])" -- killall
	compctl -s '`ps xa -opid | tail -n +2`' + \
		-x 's[-] p[1]' -k "($signals[1,-3])" -- kill
fi

# Override tricky ps(1) using completions on AIX/IRIX/Solaris
if [[ "$OSTYPE" = *aix* || "$OSTYPE" = *irix* || "$OSTYPE" = *solaris* ]]
then
	if [[ $UID -eq 0 ]]
	then
		compctl -s "\$(ps -ef | grep -v PID | awk '{print \$1}')" killuser
		compctl -s '`ps -eopid | tail -n +2`' + -x 's[-] p[1]' -k "($signals[1,-10])" -- kill
	else
		compctl -s '`ps -opid -U "\`whoami\`" | tail -n +2`' + -x 's[-] p[1]' -k "($signals[1,-10])" -- kill
	fi
	compctl -s '`ps -ocomm -U "\`whoami\`" | grep -v COMMAND`' killmy
	compctl killall
fi

# Override tricky ps(1) using completions on Cygwin
if [[ "$OSTYPE" = *cygwin* ]]
then
	function _pslist () {
		reply=($(ps -ef | grep -v COMMAND | awk '{print $2}'))
	}
	compctl -K _pslist + -x 's[-] p[1]' -k "($signals[1,-10])" -- kill
	compctl -s '`users`' killuser
	function _mypslist () {
		reply=($(ps -su "`whoami`" | grep -v COMMAND | awk '{print $4}'))
	}
	compctl -K _mypslist killmy
	compctl killall
fi

# Manual page completion
function _man_glob () {
	local a b manp
	read -cA a
	read -lA b
	manp=`manpath 2> /dev/null` || manp=`echo "$MANPATH"`
	if [[ "$a[2]" = [0-9nlpo](p|) ]] # && [[ -n "$a[3]" || "${(M)b% }" = " " ]]
	then
		reply=( ${^$(echo $manp | sed -e 's/:/ /g')}/{man,sman,cat}$a[2]/$1*(-N.:t) )
	else
		reply=( ${^$(echo $manp | sed -e 's/:/ /g')}/{man,sman,cat}[0-9nlpo]{,X,m}*/$1*(-N.:t) )
	fi
	reply=( ${reply%.[^0-9Xmnlpo]*} )
	# Uncomment to strip trailing section names from reply
	#reply=( ${reply%.[0-9Xmnlpo]*} )
}
compctl -K _man_glob -x 'C[-1,-P]' -m - \
	'R[-*l*,;]' -g '*.(man|[0-9Xmnlpo](|[a-z]))' -- + -f -g '..' man

# Accept man page names with trailing section names, e.g., man.1
function man () {
	local param sect test=${(M)@#*/} # File name probably contains a slash
	if [[ -z "$test" ]] && [[ $# -lt 3 ]]
	then
		param=${(M)${${${(M)@%.[0-9Xmnlpo]*}#.}%pm}##[0-9Xmnlpo](p|)}
		[[ -n "$param" ]] && [[ "$OSTYPE" = *solaris* ]] && sect=-s
		command man $sect $param ${@%.[0-9Xmnlpo]*}
	else
		command man "$@"
	fi
}

# Use local completions (if any)
[[ -d $HOME/.zlocal ]] && fpath=($HOME/.zlocal $fpath)

# Use compsys - overrides all compctl rules!
autoload -Uz compinit
[[ "$OSTYPE" != *cygwin* ]] && compinit || compinit -i
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
zstyle ':completion:*' ignore-parents parent directory

# Restore custom compctls defined above
compctls=${(j:,:)${${${(f):-"$(compctl)"}/ *}//(COMMAND|DEFAULT|FIRST|TAGS)/}}
eval noglob unset _comps'[{'${compctls}'}]'
unset compctls

# Completion colors
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

# Terminal title
case "$TERM"
in
	cygwin*)
		precmd () { print -Pn "\033];%n@%m:%~\007" }
		preexec () { local CMD=${1//\%/%%}; print -Pn "\033];%n@%m:%~ <$CMD>\007" }
		;;
	gnome*|putty|*rxvt*|*xterm*)
		precmd () { print -Pn "\033]0;%n@%m:%~\007" }
		preexec () { local CMD=${1//\%/%%}; print -Pn "\033]0; %n@%m:%~ <$CMD>\007" }
		;;
	konsole*)
		precmd () { print -Pn "\033]30;%n@%m:%~\007" }
		preexec () { local CMD=${1//\%/%%}; print -Pn "\033]30;%n@%m:%~ <$CMD>\007" }
		;;
	screen*)
		precmd () { print -Pn "\033k%n@%m:%~\033\\" }
		preexec () { local CMD=${1//\%/%%}; print -Pn "\033k%n@%m:%~ <$CMD>\033\\" }
		;;
esac

# Git integration
setopt PROMPT_SUBST
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats "[%16<…<%b%<<|%m%u%c]"
zstyle ':vcs_info:*' actionformats "[%12<…<%p%<<(%a)%m%u%c]"
zstyle ':vcs_info:*' patch-format '%6<…<%p%<<(%n applied)'
RPROMPT='${vcs_info_msg_0_}'

# Display current commits
zstyle ':vcs_info:git+post-backend:*' hooks git-status-commits
function +vi-git-status-commits () {
	local q="@{upstream}...HEAD"
	[[ "${gitbranch}" != "master" ]] && q="master..."
	local -a x; x=($(git rev-list --left-right --count $q 2> /dev/null))
	(( $x[1] )) && hook_com[misc]+="↓$x[1]"
	(( $x[2] )) && hook_com[misc]+="↑$x[2]"
	return 0
}

# Display current changes
zstyle ':vcs_info:git*+set-message:*' hooks git-status-changes
function +vi-git-status-changes () {
        local -A x; x=($(git status --porcelain 2> /dev/null))
	hook_com[staged]+="${${(ks::u)x}// }"
	return 0
}
