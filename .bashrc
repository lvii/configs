#
## ~/.bashrc
## author: OK <ok100.ok100.ok100@gmail.com>
#

# Check for an interactive session
[ -z "$PS1" ] && return

# pathname expansion will be treated as case-insensitive
shopt -s nocaseglob

PS1="┌─[\[\e[34m\]\h\[\e[0m\]][\[\e[32m\]\w\[\e[0m\]]\n└─╼ "

export EDITOR='urxvtc -e ~/Scripts/vim.sh'
export VIEWER='urxvtc -e ~/Scripts/view.sh'
export BROWSER='~/Scripts/chrome.sh'

alias openports='netstat --all --numeric --programs --inet'
alias svim='sudo vim'
alias grep='grep --color=auto'
alias ..='cd ..'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias alsi='alsi -n'
alias connect='sudo dhcpcd'
alias locate='sudo updatedb && slocate -i'
alias ls='ls --color=auto'
alias pacman='sudo pacman-color'
alias pacclean='sudo pacman -Rs $(pacman -Qqtd)'
alias powertop='sudo powertop'
alias scrot_dropbox='cd ~/Dropbox/Public/Screenshots && scrot && dropbox-index.py ~/Dropbox/Public/Screenshots'
alias yaourt_temp='yaourt -S --asdeps'
alias exit="clear; exit"
alias tmux="tmux -f ~/.tmux/conf"
alias meld='GTK2_RC_FILES=~/.themes/BSM_Simple/gtk-2.0/gtkrc meld'
alias pacback='sudo pacman -Qqe | grep -v "$(pacman -Qmq)" > ~/Dropbox/pklist.txt'
alias :q='clear; exit'
alias cmatrix='cmatrix -bx -u8'

alias bashrc='vim ~/.bashrc'
alias dwmrc='cd ~/Build/dwm && vim config.h && ./recompile.sh && ~/Scripts/dwm-reload.sh'
alias gitignore='vim .gitignore'
alias pacrc='sudo vim /etc/pacman.conf'
alias rcrc='sudo vim /etc/rc.conf'
alias rssrc='vim ~/.newsbeuter/urls'
alias yaourtrc='sudo vim /etc/yaourtrc'
alias wmfsrc='vim ~/.config/wmfs/wmfsrc'

PATH=$PATH:~/Scripts/

# set 256 colours in tmux
[ -n "$TMUX" ] && export TERM=screen-256color

# share history across all terminals
shopt -s histappend
PROMPT_COMMAND='history -a'

# coloured repo search
search () {
       echo -e "$(pacman -Ss $@ | sed \
       -e 's#core/.*#\\033[1;31m&\\033[0;37m#g' \
       -e 's#extra/.*#\\033[0;32m&\\033[0;37m#g' \
       -e 's#community/.*#\\033[1;35m&\\033[0;37m#g' \
       -e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g' )"
}

extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xvJf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.xz)        unxz $1        ;;
          *.exe)       cabextract $1  ;;
		  *.ace)       unace $1       ;;
		  *.arj)       unarj $1       ;;
          *)           echo "\`$1': unrecognized file compression" ;;
      esac
  else
      echo "\`$1' is not a valid file"
  fi
}

# Linux console colors (jwr dark) 
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0000000" #black
    echo -en "\e]P83d3d3d" #darkgrey
    echo -en "\e]P18c4665" #darkred
    echo -en "\e]P9bf4d80" #red
    echo -en "\e]P2287373" #darkgreen
    echo -en "\e]PA53a6a6" #green
    echo -en "\e]P37c7c99" #brown
    echo -en "\e]PB9e9ecb" #yellow
    echo -en "\e]P4395573" #darkblue
    echo -en "\e]PC477ab3" #blue
    echo -en "\e]P55e468c" #darkmagenta
    echo -en "\e]PD7e62b3" #magenta
    echo -en "\e]P631658c" #darkcyan
    echo -en "\e]PE6096bf" #cyan
    echo -en "\e]P7899ca1" #lightgrey
    echo -en "\e]PFc0c0c0" #white
    clear # bring us back to default input colours
fi
