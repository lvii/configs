#
## ~/.bashrc
## author  : OK100 <ok100@lavabit.com>
## website : https://github.com/ok100
#

# check for an interactive session
[ -z "$PS1" ] && return

# pathname expansion will be treated as case-insensitive
shopt -s nocaseglob

# bash prompt
PS1=" \[\e[0;32m\]\W \[\e[1;30m\]$ \[\e[0m\]"

# share history across all terminals
shopt -s histappend
PROMPT_COMMAND='history -a'

# avoid duplicates & blank commands in history
export HISTCONTROL=ignoreboth

# grep color
export GREP_COLOR="1;33"

# auto-completion
complete -cf man
complete -cf sudo
. ~/.bash_completion.d/c
. /etc/bash_completion.d/git
. /usr/share/bash-completion/completions/pacman
. /usr/share/bash-completion/completions/systemctl
. /usr/share/bash-completion/completions/tmux

# dir colors
eval `dircolors ~/.dircolors`

# aliases
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias :q='clear; exit'
alias abook='~/bin/abook-autoexport'
alias alsi='alsi -a'
alias cl='clear'
alias cmatrix='cmatrix -bx -u8'
alias df='df -h'
alias diff='colordiff'
alias du='du -c -h'
alias exit="clear; exit"
alias free='free -m'
alias grep='grep -n --color=auto'
alias iotop='sudo iotop -Poa'
alias ll='ls -l'
alias log='journalctl'
alias ls='ls --color=auto'
alias ly='lyvi'
alias mc="mc -x"
alias mem='sudo ~/bin/ps_mem.py'
alias nas='ssh root@192.168.1.147'
alias netcfg='sudo netcfg'
alias pac='sudo pacman-color'
alias pacback='sudo pacman-color -Qqe | grep -v "$(pacman-color -Qmq)" > ~/dropbox/pklist.txt'
alias pacclean='sudo pacman-color -Rs $(pacman-color -Qqtd)'
alias pacin='yaourt -S'
alias pacman='sudo pacman-color'
alias pacrc='sudo vim /etc/pacman.conf'
alias pacrm='yaourt -R'
alias pacup='yaourt -Syu --aur'
alias pianobar='pianobar; rm ~/.config/pianobar/nowplaying'
alias powerdown='sudo powerdown'
alias powertop='sudo powertop'
alias ptop='sudo powertop'
alias rip='cdparanoia -B -w -d /dev/sr0'
alias router='ssh root@192.168.1.1'
alias smc='sudo mc'
alias svi='sudo vim'
alias svim='sudo vim'
alias t='todo.sh'
alias vi='vim'
alias webcam='mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0 -fps 15 -vf screenshot'
alias ydl='youtube-dl'
# git
alias gitad='git add'
alias gitcl='git clone'
alias gitco='git commit -m'
alias gitdi='git diff'
alias gitig='vim .gitignore'
alias gitin='git init'
alias gitlo='git log'
alias gitpl='git pull'
alias gitpu='git push -u origin master'
alias gitrm='git rm'
alias gitst='git status'

c () {
	case $1 in
		bash)		vim ~/.bashrc ;;
		conky)		vim ~/.conkyrc ;;
		dwm)		dir=$(pwd) && cd ~/build/dwm && vim config.h && ./recompile.sh && killall dwm && cd $dir ;;
		homepage)	dir=$(pwd) && cd ~/build/homepage.py && vim homepage.py && ./homepage.py && cd $dir ;;
		mime)		vim ~/.config/mimi/mime.conf ;;
		mutt)		vim ~/.mutt/muttrc ;;
		pacman)		sudo vim /etc/pacman.conf ;;
		rss)		vim ~/.newsbeuter/urls ;;
		syslinux) 	sudo vim /boot/syslinux/syslinux.cfg ;;
		tmux)		vim ~/.tmux.conf ;;
		vim)		vim ~/.vimrc ;;
		xresources)	vim ~/.Xresources && xrdb ~/.Xresources ;;
	esac
}

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

# encode mp3
mp3 () {
    for file in $1; do
        lame --preset standard $file $file.mp3
    done
}

cleanup () {
	echo -e "\e[1;34m::\e[0m Cleaning pacman cache..."
	sudo rm /var/cache/pacman/pkg/* &> /dev/null
	yaourt -Scc --noconfirm &> /dev/null

	echo -e "\e[1;34m::\e[0m Deleting unneeded files..."
	rm -rf ~/.adobe
	rm -rf ~/.bzr.log
	rm -rf ~/.cmus/command-history
	rm -rf ~/.cmus/search-history
	rm -rf ~/.gvfs
	rm -rf ~/.local/share/Trash
	rm -rf ~/.local/share/gvfs-metadata
	rm -rf ~/.local/share/loliclip
	rm -rf ~/.local/share/recently-used.xbel
	rm -rf ~/.macromedia
	rm -rf ~/.newsbeuter/history.cmdline
	rm -rf ~/.newsbeuter/history.search
	rm -rf ~/.qalculate/qalc.history
	rm -rf ~/.subversion
	rm -rf ~/.sxiv/*
	rm -rf ~/.thumbnails
	rm -rf ~/Desktop

	sudo rm -rf /usr/share/doc
	sudo rm -rf /usr/share/ghostscript/*/doc
	sudo rm -rf /usr/share/ghostscript/*/examples
	sudo rm -rf /usr/share/gtk-doc
	sudo rm -rf /usr/lib/libreoffice/help
	sudo rm -rf /usr/lib/libreoffice/share/config/{images_crystal.zip,images_hicontrast.zip,images_tango.zip}
	sudo rm -rf /usr/lib/libreoffice/share/{gallery,template}
	sudo rm -rf /usr/share/stardict/help
	sudo rm -rf /usr/share/qt/translations
	sudo rm -rf /usr/share/lazarus/{examples,languages}
	sudo rm -rf /usr/share/skype/avatars
	sudo rm -rf /usr/share/fonts/TTF/{DroidSansArabic.ttf,DroidSansFallback.ttf,DroidSansFallbackLegacy.ttf,DroidSansHebrew.ttf,DroidSansJapanese.ttf,DroidSansThai.ttf}
	for file in $(ls /usr/share/vim/vim73/lang/ | grep -v README.txt); do
		sudo rm -rf /usr/share/vim/vim73/lang/$file
	done
	for file in $(ls /usr/share/skype/lang/ | grep -v "^skype_en"); do
		sudo rm -rf /usr/share/skype/lang/$file
	done

	echo -e "\e[1;34m::\e[0m Cleaning with BleachBit..."
	bleachbit -c --preset &> /dev/null
	sudo bleachbit -c --preset &> /dev/null

	echo -e "\e[1;34m::\e[0m Done."
}

backup () {
	backup_dir=/media/store/bkp
	echo -e "\e[1;34m::\e[0m Backing up pacman database..."
		sudo pacman-color -Qqe | grep -v "$(pacman-color -Qmq)" > ~/Dropbox/pklist.txt
		echo -e "\e[1;34m::\e[0m Done."
	if [ -d $backup_dir ]; then
		echo -e "\e[1;34m::\e[0m Backing up /mnt/SD..."
			rsync -a --delete --exclude 'mail' /mnt/SD/ $backup_dir/SD/
			echo -e "\e[1;34m::\e[0m Done."
		echo -e "\e[1;34m::\e[0m Backing up /etc..."
			sudo rsync -a --delete /etc/ $backup_dir/etc/
			echo -e "\e[1;34m::\e[0m Done."
		echo -e "\e[1;34m::\e[0m Backing up /home..."
			rsync -a --delete /home/ok/ $backup_dir/home/
			echo -e "\e[1;34m::\e[0m Done."
	else
		echo -e "\e[1;31merror:\e[0m backup directory not found"
	fi
}

die () {
	kill -s 9 $(pidof $1)
}

vbox_recompile () {
	virtualbox_version=$(yaourt -Qi virtualbox-source | grep Version | cut -d " " -f10 | cut -d "-" -f1)
	kernel_version=$(cut -d "'" -f2 < /usr/share/linux-ok100/currver"'")

	sudo dkms install vboxhost/$virtualbox_version -k $kernel_version/i686
}
