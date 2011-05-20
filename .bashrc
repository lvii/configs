#
## ~/.bashrc
## author  : OK <ok100.ok100.ok100@gmail.com>
## website : https://github.com/ok100
#

# check for an interactive session
[ -z "$PS1" ] && return

# export path
PATH=$PATH:~/Scripts/

# pathname expansion will be treated as case-insensitive
shopt -s nocaseglob

# bash prompt
PS1="┌─[\[\e[34m\]\h\[\e[0m\]][\[\e[32m\]\w\[\e[0m\]]\n└─╼ "

# share history across all terminals
shopt -s histappend
PROMPT_COMMAND='history -a'

# default apps
export EDITOR='vim'
export VIEWER='vim -R'
export BROWSER='~/Scripts/chrome.sh'

# aliases
alias openports='netstat --all --numeric --programs --inet'
alias svi='sudo vim'
alias svim='sudo vim'
alias vi='vim'
alias smc='sudo mc'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias alsi='alsi -n'
alias connect='sudo dhcpcd'
alias locate='sudo updatedb && slocate -i'
alias powertop='sudo powertop'
alias scrotbox='cd ~/Dropbox/Public/Screenshots && scrot && dropbox-index.py ~/Dropbox/Public/Screenshots'
alias meld='GTK2_RC_FILES=~/.themes/BSM_Simple/gtk-2.0/gtkrc meld'
alias cmatrix='cmatrix -bx -u8'
alias cl='clear'
alias :q='clear; exit'
alias exit="clear; exit"
alias mc="mc -x"

# pacman aliases
alias pacman='sudo pacman-color'
alias pac='sudo pacman-color'
alias pacclean='sudo pacman-color -Rs $(pacman-color -Qqtd)'
alias pacup='yaourt -Syu --aur'
alias pacin='yaourt -S'
alias pacrc='sudo vim /etc/pacman.conf'
alias pacback='sudo pacman-color -Qqe | grep -v "$(pacman-color -Qmq)" > ~/Dropbox/pklist.txt'

# git aliases
alias gitco='git commit -m'
alias gitst='git status'
alias gitpu='git push -u origin master'
alias gitdi='git diff'
alias gitig='vim .gitignore'
alias gitad='git add'
alias gitcl='git clone'

# config aliases
alias bashrc='vim ~/.bashrc'
alias dwmrc='cd ~/Build/dwm && vim config.h && ./recompile.sh && ~/Scripts/dwm-reload.sh'
alias pacrc='sudo vim /etc/pacman.conf'
alias rcrc='sudo vim /etc/rc.conf'
alias rssrc='vim ~/.newsbeuter/urls'
alias wmfsrc='vim ~/.config/wmfs/wmfsrc'
alias tmuxrc='vim ~/.tmux.conf'
alias statusrc='vim ~/.conkyrc_dzen'
alias vimrc='vim ~/.vimrc'
alias virc='vim ~/.vimrc'

# coloured repo search
pacse () {
       echo -e "$(yaourt -Ss $@ | sed \
       -e 's#core/.*#\\033[1;31m&\\033[0;37m#g' \
       -e 's#extra/.*#\\033[0;32m&\\033[0;37m#g' \
       -e 's#community/.*#\\033[1;35m&\\033[0;37m#g' \
       -e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g' )"
}

# extract function
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

# simple notes
n () {
	vim ~/.notes/"$*".txt
	}
nls () {
	tree -CR --noreport ~/.notes | awk '{ if ((NR > 1) gsub(/.txt/,"")); if (NF==1) print $1; else if (NF==2) print $2; else if (NF==3) printf " %s\n", $3 }' ;
	}

# linux console colors (jwr dark) 
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

