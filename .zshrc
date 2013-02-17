# initialize colors
autoload -U colors
colors

# dir colors
eval $(dircolors ~/.dircolors)

# Autoload zsh functions
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

# Enable auto-execution of functions
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'

# allow for functions in the prompt
setopt PROMPT_SUBST

# set the prompt
PROMPT='%{$fg[green]%}%1~$(prompt_git_info) %{$fg_bold[black]%}\$%{$reset_color%} '

# set the right prompt if we are in ranger
[ -n "$RANGER_LEVEL" ] && RPROMPT='%{$fg[magenta]%}(in ranger)%{$reset_color%}'

# live command coloring
source ~/bin/live-command-coloring.sh

# command completion
autoload -U compinit && compinit                       # initialize completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'    # case insensitive completion
setopt completealiases                                 # autocompletion of command line switches for aliases
zstyle ':completion:*' menu select=2                   # autocompletion with an arrow-key driven interface
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# avoid duplicates in history
setopt hist_ignore_all_dups

# autocd
setopt autocd

# aliases
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias :q='clear; exit'
alias alsi='alsi -a -u'
alias cl='clear'
alias df='df -h'
alias die='killall -9'
alias diff='colordiff'
alias exit="clear; exit"
alias free='free -m'
alias grep='grep --color=auto'
alias ad='sudo hostsblock-urlcheck'
alias iotop='sudo iotop -Poa'
alias lc='lyvi -c ~/.config/lyvi/lyvi-cover.conf'
alias less='vimpager'
alias ll='ls -l'
alias log='journalctl'
alias ls='ls --color=auto'
alias ly='lyvi'
alias makepkg='PKGEXT=.tar makepkg'
alias mc="mc -x"
alias mem='sudo ps_mem'
alias mount='sudo mount'
alias nas='ssh root@192.168.1.147'
alias netcfg='sudo netcfg'
alias pac='sudo pacman-color'
alias pacclean='sudo pacman-color -Rs $(pacman-color -Qqtd)'
alias pacin='yaourt -S'
alias pacman='sudo pacman-color'
alias pacrm='yaourt -R'
alias powerdown='sudo powerdown'
alias powernow='sudo powernow'
alias powertop='sudo powertop'
alias powerup='sudo powerup'
alias rip='cdparanoia -B -w -d /dev/sr0'
alias router='ssh root@192.168.1.1'
alias smc='sudo mc'
alias sub='submarine -l cze -l ces -l cs'
alias subsk='submarine -l slo -l slk -l sk'
alias svi='sudo vim'
alias svim='sudo vim'
alias sysd='sudo systemctl'
alias sysdu='systemctl --user'
alias tex-update='sudo tlmgr update --all'
alias tlmgr='sudo tlmgr'
alias u='yaourt -Syu --aur'
alias umount='sudo umount'
alias nas='ssh root@192.168.1.147'
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

conf() {
	case $1 in
		conky)		vim ~/.conkyrc ;;
		dwm)		olddir=$(pwd) && cd ~/build/dwm && vim config.h && ./recompile.sh && systemctl --user restart dwm; cd $olddir ;;
		homepage)	olddir=$(pwd) && cd ~/build/homepage.py && vim homepage.py && ./homepage.py; cd $olddir ;;
		lirc)		vim ~/.lircrc ;;
		lyvi)		vim ~/.config/lyvi/lyvi.conf ;;
		menu)		vim ~/.menu ;;
		mime)		vim ~/.config/mimi/mime.conf ;;
		mpd)		vim ~/.mpdconf ;;
		mutt)		vim ~/.mutt/muttrc ;;
		ncmpcpp)	vim ~/.ncmpcpp/config ;;
		pacman)		vim /etc/pacman.conf ;;
		ranger)		vim ~/.config/ranger/rc.conf ;;
		rifle)		vim ~/.config/ranger/rifle.conf ;;
		rss)		vim ~/.config/rss2maildir/rss2maildir.conf ;;
		syslinux) 	vim /boot/syslinux/syslinux.cfg ;;
		sxiv)       olddir=$(pwd) && cd ~/build/sxiv-git && vim config.h && ./recompile.sh; cd $olddir ;;
		tmux)		vim ~/.tmux.conf ;;
		vim)		vim ~/.vimrc ;;
		xinit)		vim ~/.xinitrc ;;
		xresources)	vim ~/.Xresources && xrdb ~/.Xresources ;;
		zathura)	vim ~/.config/zathura/zathurarc ;;
		zsh)		vim ~/.zshrc && source ~/.zshrc ;;
		*)			echo "Unknown application: $1" ;;
	esac
}
confcmds=(conky dwm homepage lirc lyvi menu mime mpd mutt ncmpcpp pacman ranger rifle rss syslinux sxiv tmux vim xinit xresources zathura zsh)
compctl -k confcmds conf

# coloured repo search
pacse() {
       echo -e "$(yaourt -Ss $@ | sed \
       -e 's#core/.*#\\033[1;31m&\\033[0;37m#g' \
       -e 's#extra/.*#\\033[0;32m&\\033[0;37m#g' \
       -e 's#community/.*#\\033[1;35m&\\033[0;37m#g' \
       -e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g' )"
}

# encode mp3
mp3() {
    for file in $1; do
        lame --preset standard $file $file.mp3
    done
}

# delete unneeded files
cleanup() {
	echo -e "\033[1;34m::\033[1;37m Cleaning pacman cache...\033[0m"
	sudo rm /var/cache/pacman/pkg/*.pkg.tar.*(m+7,N) &> /dev/null
	yaourt -Scc --noconfirm &> /dev/null

	echo -e "\033[1;34m::\033[1;37m Cleaning sxiv thumbnail cache...\033[0m"
	rm -rf ~/.sxiv && mkdir ~/.sxiv

	echo -e "\033[1;34m::\033[1;37m Cleaning with BleachBit...\033[0m"
	bleachbit -c --preset &> /dev/null
	sudo bleachbit -c --preset &> /dev/null

	echo -e "\033[1;32m=>\033[1;37m Done\033[0m"
}

# backup function
backup() {
	backup_dir=/media/store/bkp
	echo -e "\033[1;34m:: \033[1;37mBacking up pacman database...\033[0m"
		pacman -Qqe | grep -v "$(pacman -Qmq)" > ~/Dropbox/pklist.txt
		echo -e "\033[1;34m:: \033[1;37mDone.\033[0m"
	if [ -d $backup_dir ]; then
		echo -e "\033[1;34m:: \033[1;37mBacking up /mnt/SD...\033[0m"
			rsync -a --delete --exclude 'mail' --exclude 'safebox' /mnt/SD/ $backup_dir/SD/
			echo -e "\033[1;34m:: \033[1;37mDone.\033[0m"
		echo -e "\033[1;34m:: \033[1;37mBacking up /etc...\033[0m"
			sudo rsync -a --delete /etc/ $backup_dir/etc/
			echo -e "\033[1;34m:: \033[1;37mDone.\033[0m"
		echo -e "\033[1;34m:: \033[1;37mBacking up /home...\033[0m"
			rsync -a --delete /home/ok/ $backup_dir/home/
			echo -e "\033[1;34m:: \033[1;37mDone.\033[0m"
	else
		echo -e "\e[1;31merror:\e[0m backup directory not found"
	fi
}

# update vim plugins
vim-update() {
	olddir=$(pwd)
	for dir in ~/.vim/bundle/*; do
		echo -e "\033[1;34m:: \033[1;37m${dir##*/}\033[0m"
		cd $dir
		git pull
	done
	cd $olddir
}

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.

function zle-line-init () {
    echoti smkx
}
function zle-line-finish () {
    echoti rmkx
}

zle -N zle-line-init
zle -N zle-line-finish
