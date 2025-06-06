# ~/.cshrc

# Global definitions are always sourced from /etc/csh.cshrc

# Ensure SHELL is always correctly set
if ( $?SHELL == 0 || { eval 'if ! ( $SHELL =~ *csh* ) exit 0' } ) setenv SHELL "$0"

# Make OSTYPE like on other shells
setenv OSTYPE "`uname -s | tr '[:upper:]' '[:lower:]'`"

# Default umask
umask 027

# Disable GNU extensions
#setenv POSIXLY_CORRECT y
#setenv POSIX_ME_HARDER y

# Cygwin environment - add winsymlinks if needed to create shortcuts
if ( "${OSTYPE}" == 'cygwin' ) then
	setenv CYGWIN nodosfilewarning
endif

# Locale environment from ~/.i18n
if ( -f "${HOME}/.i18n" ) then
	eval `sed -ne 's|^[[:blank:]]*\([^#=]\{1,\}\)=\([^=]*\)|setenv \1 \2;|p' "${HOME}/.i18n"`
endif
setenv TIME_STYLE long-iso

# Timezone
#if ( "${OSTYPE}" == 'linux' ) then
#	setenv TZ :/etc/localtime
#endif

# Make sure some widely used variables are set
setenv USERNAME "${USER}"
setenv LOGNAME "${USER}"
if ( $?MAIL == 0 ) then
	setenv MAIL "/var/mail/${USER}"
endif

# Library path. Set LD_LIBRARY_PATH only if you REALLY know what you are doing
#setenv LD_LIBRARY_PATH /usr/local/lib

# Java
if ( $?JAVA_HOME == 0 && -d /etc/alternatives/java_sdk ) then
	setenv JAVA_HOME /etc/alternatives/java_sdk
endif
if ( $?JAVA_HOME == 0 && -d /etc/alternatives/jre ) then
	setenv JAVA_HOME /etc/alternatives/jre
endif
if ( $?JAVA_HOME == 1 ) then
	setenv JAVACMD "${JAVA_HOME}/bin/java"
endif

# Python
#if ( -d "${HOME}/.local/lib/python3.9/site-packages" ) then
#	if ( $?PYTHONPATH == 1 ) then
#		setenv PYTHONPATH "${HOME}/.local/lib/python3.9/site-packages:${PYTHONPATH}"
#	else
#		setenv PYTHONPATH "${HOME}/.local/lib/python3.9/site-packages"
#	endif
#endif

# Path
if ( $?PATH == 1 && -d "${HOME}/.local/bin" ) then
	setenv PATH "${HOME}/.local/bin:${PATH}"
endif
if ( $?PATH == 1 && -d "${HOME}/bin" ) then
	setenv PATH "${HOME}/bin:${PATH}"
endif

# Manual path. You may use /etc/man.conf instead of MANPATH on some systems
if ( $?MANPATH == 1 && -d "${HOME}/.local/share/man" ) then
	setenv MANPATH "${HOME}/.local/share/man:${MANPATH}"
endif
if ( $?MANPATH == 1 && -d "${HOME}/man" ) then
	setenv MANPATH "${HOME}/man:${MANPATH}"
endif

#
# Miscellaneous user preferences
#
setenv BROWSER firefox
setenv EDITOR vi
setenv FCEDIT vi
setenv VISUAL vi
setenv WINEDITOR vi
if ( -x "`which less`" ) then
	setenv PAGER less
else
	setenv PAGER more
endif
setenv LESS -CiMqRs
setenv LESSHISTFILE -
setenv LIBVIRT_DEFAULT_URI qemu:///system
setenv MORE -c
setenv PG -cn
setenv READNULLCMD "${PAGER}"
setenv SYSTEMD_LESS "${LESS}"
#setenv IRCNICK
#setenv IRCSERVER



# Options
set autolist
set correct = all
set histdup = prev

# Terminal type - set only if really needed
#setenv TERM vt100

# Eight bit character size
tty -s >& /dev/null && stty cs8 >& /dev/null || :

# Limits
#limit coredumpsize 0
set dirstack = 64
#set listmax = 0

# Prompt
set prompt = "%{\033[32m%}%n@%m:%{\033[00m%}%~% "

# History settings
set histfile = "${HOME}/.history"
set history  = 8000
set savehist = (8000 merge)

# Mail check interval
#set mail = "60 ${MAIL}"

# Unset unhelpful options and settings
unsetenv SSH_ASKPASS

# Don't logout automagically
unset autologout

# Key bindings for Linux/BSD/X11/Solaris
bindkey "^B"      backward-word
bindkey "^F"      forward-word
bindkey "^U"      backward-kill-line
bindkey "^W"      backward-delete-word
bindkey "\e[2~"   overwrite-mode
bindkey "\e[3~"   delete-char
bindkey "\e[7~"   beginning-of-line
bindkey "\e[8~"   end-of-line

# Aliases
alias cd~ 'cd ~'
alias ind 'indent -kr -nbbo -bl -bli0 -bls -nce -cli4 -nut -c0 -cd0 -cp0'
alias l 'ls -l'
alias la 'ls -al'
alias lale 'ls -al | "${PAGER}"'
alias lh 'last | head'
alias ll 'ls -l'
alias lsd 'ls -ld */'
alias grep 'grep --color=tty'
alias reset "printf '\033\143'"
alias wget 'wget --hsts-file=/dev/null'
alias systemctl 'systemctl -l -n 50'
alias journalctl 'journalctl -l -n 50'
alias lbigrpms 'rpm -qa --qf "%{size}\t%{name}\n" | sort -nr | numfmt --field=1 --to=iec | "${PAGER}"'
if ( -x "`which vim`" ) then
	alias vi 'vim -u ~/.vimrc'
endif
alias vim 'vim -u ~/.vimrc'
alias bc 'bc -l ~/.bcrc'

# Always play it safe when super-user
if ( `id -u` == 0 ) then
	alias cp 'cp -i'
	alias mv 'mv -i'
	alias rm 'rm -i'
endif

# less
if ( -x "`which lesspipe.sh`" ) then
	setenv LESSOPEN "| lesspipe.sh %s"
endif

# ls(1) colors and other options
eval `dircolors --csh >& /dev/null`
if ( $?LS_COLORS == 0 ) then
	setenv LS_COLORS 'rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
endif
switch ( "${OSTYPE}" )
	case cygwin:
	case gnu:
	case linux:
	case msys:
		alias ls 'ls -h --literal --show-control-chars --color=auto'
		breaksw
	case darwin:
	case freebsd:
		alias ls 'ls -G -h'
		setenv CLICOLOR yes
		# GNU ls(1) style colors
		setenv LSCOLORS "ExGxFxdxCxDxDxCxCxExEx"
		# Expect xterm to support colors
		if ( "x${TERM}" == 'xxterm' ) then
			setenv TERM xterm-color
		endif
		breaksw
	case netbsd:
	case openbsd:
	case solaris:
		alias ls 'ls -F -h'
		breaksw
endsw

# Completion control
if ( -f /etc/csh_completion ) then
	source /etc/csh_completion
endif

# Terminal title
if ( $?TERM == 0 ) then
	setenv TERM dumb
endif
switch ( "${TERM}" )
	case "cygwin*":
		set prompt = "%{\033];%n@%m:%~\007%}%{\033[32m%}%n@%m:%{\033[00m%}%~% "
		breaksw
	case "gnome*":
	case "putty":
	case "*rxvt*":
	case "*xterm*":
		set prompt = "%{\033]0;%n@%m:%~\007%}%{\033[32m%}%n@%m:%{\033[00m%}%~% "
		breaksw
	case "konsole*":
		set prompt = "%{\033]30;%n@%m:%~\007%}%{\033[32m%}%n@%m:%{\033[00m%}%~% "
		breaksw
	case "screen*":
	case "tmux*":
		set prompt = "%{\033k%n@%m:%~\033\\%}%{\033[32m%}%n@%m:%{\033[00m%}%~% "
		if ( $?TERMCAP == 0 ) then
			echo -n '\033]2;'${USER}@${HOST}:${PWD}'\033\\'
		endif
		breaksw
endsw
