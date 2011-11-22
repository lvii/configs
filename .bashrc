#
## ~/.bashrc
## author  : OK <ok100.ok100.ok100@gmail.com>
## website : https://github.com/ok100
#

# check for an interactive session
[ -z "$PS1" ] && return

# pathname expansion will be treated as case-insensitive
shopt -s nocaseglob

# bash prompt
PS1=" \[\e[0;32m\]\W \[\e[1;30m\]> \[\e[0m\]"

# share history across all terminals
shopt -s histappend
PROMPT_COMMAND='history -a'

# avoid duplicates & blank commands in history
export HISTCONTROL=ignoreboth

# default apps
export EDITOR='vim'
export VIEWER='vim -R'
export BROWSER='opera-next -noargb -nolirc'

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
alias connect='sudo dhcpcd'
alias locate='sudo updatedb && slocate -i'
alias cmatrix='cmatrix -bx -u8'
alias cl='clear'
alias :q='clear; exit'
alias exit="clear; exit"
alias mc="mc -x"
alias abook='~/bin/abook-autoexport'
alias rip='cdparanoia -B -w -d /dev/sr0'
alias ydl='youtube-dl'
alias yvi='youtube-viewer'
alias iotop='sudo iotop'
# pacman
alias pacman='sudo pacman-color'
alias pac='sudo pacman-color'
alias pacclean='sudo pacman-color -Rs $(pacman-color -Qqtd)'
alias pacup='yaourt -Syu --aur'
alias pacin='yaourt -S'
alias pacrm='yaourt -R'
alias pacrc='sudo vim /etc/pacman.conf'
alias pacback='sudo pacman-color -Qqe | grep -v "$(pacman-color -Qmq)" > ~/dropbox/pklist.txt'
# git
alias gitco='git commit -m'
alias gitst='git status'
alias gitpu='git push -u origin master'
alias gitdi='git diff'
alias gitig='vim .gitignore'
alias gitad='git add'
alias gitcl='git clone'
alias gitlo='git log'
alias gitpl='git pull'
alias gitin='git init'
alias gitrm='git rm'
alias githu='~/bin/github_update.sh'
# config
alias bashrc='vim ~/.bashrc'
alias dwmrc='curr_dir=`pwd`; cd ~/build/dwm; vim config.h; ./recompile.sh; ~/bin/dwm-reload.sh; cd $curr_dir'
alias rcrc='sudo vim /etc/rc.conf'
alias rssrc='vim ~/.newsbeuter/urls'
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

# create mp3 audio files
mp3 () {
    for file in $1; do
        lame --preset standard $file $file.mp3
    done
}

# linux console colors 
#if [ "$TERM" = "linux" ]; then
    # jwr dark
    #echo -en "\e]P0000000" #black
    #echo -en "\e]P85e5e5e" #darkgrey
    #echo -en "\e]P18a2f58" #darkred
    #echo -en "\e]P9cf4f88" #red
    #echo -en "\e]P2287373" #darkgreen
    #echo -en "\e]PA53a6a6" #green
    #echo -en "\e]P3914e89" #darkyellow
    #echo -en "\e]PBbf85cc" #yellow
    #echo -en "\e]P4395573" #darkblue
    #echo -en "\e]PC4779b3" #blue
    #echo -en "\e]P55e468c" #darkmagenta
    #echo -en "\e]PD7f62b3" #magenta
    #echo -en "\e]P62b7694" #darkcyan
    #echo -en "\e]PE47959e" #cyan
    #echo -en "\e]P7899ca1" #lightgrey
    #echo -en "\e]PFc0c0c0" #white
    #clear # bring us back to default input colours

    # zenburn
    #echo -en "\e]P01e2320" # zenburn black (normal black)
    #echo -en "\e]P8709080" # bright-black  (darkgrey)
    #echo -en "\e]P1705050" # red           (darkred)
    #echo -en "\e]P9dca3a3" # bright-red    (red)
    #echo -en "\e]P260b48a" # green         (darkgreen)
    #echo -en "\e]PAc3bf9f" # bright-green  (green)
    #echo -en "\e]P3dfaf8f" # yellow        (brown)
    #echo -en "\e]PBf0dfaf" # bright-yellow (yellow)
    #echo -en "\e]P4506070" # blue          (darkblue)
    #echo -en "\e]PC94bff3" # bright-blue   (blue)
    #echo -en "\e]P5dc8cc3" # purple        (darkmagenta)
    #echo -en "\e]PDec93d3" # bright-purple (magenta)
    #echo -en "\e]P68cd0d3" # cyan          (darkcyan)
    #echo -en "\e]PE93e0e3" # bright-cyan   (cyan)
    #echo -en "\e]P7dcdccc" # white         (lightgrey)
    #echo -en "\e]PFffffff" # bright-white  (white)
    #clear # bring us back to default input colours
#fi

# auto-completion
complete -cf sudo
complete -cf man
