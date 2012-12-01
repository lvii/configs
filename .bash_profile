#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export GTK2_RC_FILES="/home/ok/.gtkrc-2.0"
export MOZ_DISABLE_PANGO=1

export EDITOR='vim'
export VIEWER='vim -R'
export PAGER='vimpager'
export BROWSER='dwb'
export TERMCMD='urxvtc'

export PATH="/usr/lib/cw:/usr/local/texlive/2012/bin/i386-linux/:/home/ok/bin/:$PATH"

export NOCOLOR_PIPE=1

if [[ -z $DISPLAY ]] && ! [[ -e /tmp/.X11-unix/X0 ]] && (( EUID )); then
  exec startx
fi
