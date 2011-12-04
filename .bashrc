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

# grep color
export GREP_COLOR="1;33"

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

# create mp3 files
mp3 () {
    for file in $1; do
        lame --preset standard $file $file.mp3
    done
}

cleanup () {
	echo -e "\e[1;34m::\e[0m Cleaning pacman cache..."
	sudo rm /var/cache/pacman/pkg/* &> /dev/null

	echo -e "\e[1;34m::\e[0m Deleting unneeded files..."
	rm -rf ~/.adobe
	rm -rf ~/.cache
	rm -rf ~/.local/share/recently-used.xbel
	rm -rf ~/.macromedia
	rm -rf ~/.thumbnails
	rm -rf ~/.subversion
	rm -rf ~/.cmus/search-history
	rm -rf ~/.cmus/command-history
	rm -rf ~/.newsbeuter/history.cmdline
	rm -rf ~/.newsbeuter/history.search
	rm -rf ~/.qalculate/qalc.history
	sudo rm -rf /usr/share/doc
	sudo rm -rf /usr/share/ghostscript/*/doc
	sudo rm -rf /usr/share/ghostscript/*/examples
	sudo rm -rf /usr/share/gtk-doc
	sudo rm -rf /usr/lib/libreoffice/basis-link/help
	sudo rm -rf /usr/lib/libreoffice/basis-link/share/config/images_crystal.zip
	sudo rm -rf /usr/lib/libreoffice/basis-link/share/config/images_hicontrast.zip
	sudo rm -rf /usr/lib/libreoffice/basis-link/share/config/images_tango.zip
	sudo rm -rf /usr/lib/libreoffice/basis-link/share/gallery
	sudo rm -rf /usr/lib/libreoffice/basis-link/share/template
	sudo rm -rf /usr/share/fonts/TTF/DroidSansArabic.ttf
	sudo rm -rf /usr/share/fonts/TTF/DroidSansFallback.ttf
	sudo rm -rf /usr/share/fonts/TTF/DroidSansFallbackLegacy.ttf
	sudo rm -rf /usr/share/fonts/TTF/DroidSansHebrew.ttf
	sudo rm -rf /usr/share/fonts/TTF/DroidSansJapanese.ttf
	sudo rm -rf /usr/share/fonts/TTF/DroidSansThai.ttf
	sudo rm -rf /usr/share/vim/vim73/lang/af
	sudo rm -rf /usr/share/vim/vim73/lang/ca
	sudo rm -rf /usr/share/vim/vim73/lang/de
	sudo rm -rf /usr/share/vim/vim73/lang/eo
	sudo rm -rf /usr/share/vim/vim73/lang/es
	sudo rm -rf /usr/share/vim/vim73/lang/fi
	sudo rm -rf /usr/share/vim/vim73/lang/fr
	sudo rm -rf /usr/share/vim/vim73/lang/ga
	sudo rm -rf /usr/share/vim/vim73/lang/it
	sudo rm -rf /usr/share/vim/vim73/lang/ja
	sudo rm -rf /usr/share/vim/vim73/lang/ko
	sudo rm -rf /usr/share/vim/vim73/lang/ko.UTF-8
	sudo rm -rf /usr/share/vim/vim73/lang/menu_af_af.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_af_af.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_af.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_af.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ca_es.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ca_es.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ca.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ca.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_chinese_gb.936.vim
	sudo rm -rf "/usr/share/vim/vim73/lang/menu_chinese(gb)_gb.936.vim"
	sudo rm -rf /usr/share/vim/vim73/lang/menu_chinese_taiwan.950.vim
	sudo rm -rf "/usr/share/vim/vim73/lang/menu_chinese(taiwan)_taiwan.950.vim"
	sudo rm -rf /usr/share/vim/vim73/lang/menu_de_de.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_de_de.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_de.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_de.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_eo_eo.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_eo.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_eo_xx.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_es_es.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_es_es.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_es.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_es.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_fi_fi.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_fi_fi.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_fi.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_finnish_finland.1252.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_fi.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_french_france.1252.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_fr_fr.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_fr_fr.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_fr.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_fr.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_german_germany.1252.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_hu_hu.iso_8859-2.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_hu_hu.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_hu.iso_8859-2.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_hu.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_italian_italy.1252.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_it_it.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_it_it.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_it.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_it.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ja.cp932.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ja.euc-jp.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ja.eucjp.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ja_jp.cp932.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ja_jp.euc-jp.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ja_jp.eucjp.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ja_jp.ujis.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ja_jp.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_japanese_japan.932.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ja.ujis.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ja.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ko_kr.euckr.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ko_kr.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ko_kr.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ko.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_nl.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_nl_nl.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_nl_nl.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_nl.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_no.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_no_no.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_no_no.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_no.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_pl.cp1250.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_pl_pl.cp1250.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_pl_pl.iso_8859-2.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_pl_pl.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_polish_poland.1250.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_pt_br.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_pt_br.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_pt_br.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_pt_pt.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_pt_pt.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_pt_pt.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ru_ru.koi8-r.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ru_ru.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ru_ru.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_ru.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sk.cp1250.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sk_sk.1250.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sk_sk.cp1250.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sk_sk.iso_8859-2.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sk_sk.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_slovak_slovak_republic.1250.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sl_si.cp1250.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sl_si.latin2.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sl_si.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_spanish_spain.850.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sr_rs.ascii.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sr_rs.iso_8859-2.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sr_rs.iso_8859-5.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sr_rs.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sr.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sr_yu.ascii.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sr_yu.iso_8859-2.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sr_yu.iso_8859-5.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sr_yu.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sv.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sv_se.latin1.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sv_se.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_sv.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_uk_ua.cp1251.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_uk_ua.koi8-u.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_vi_vn.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_zh.big5.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_zh_cn.18030.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_zh_cn.cp936.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_zh_cn.gb2312.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_zh_cn.gbk.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_zh_cn.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_zh.cp936.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_zh.cp950.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_zh.gb2312.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_zh_tw.big5.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_zh_tw.cp950.vim
	sudo rm -rf /usr/share/vim/vim73/lang/menu_zh_tw.utf-8.vim
	sudo rm -rf /usr/share/vim/vim73/lang/nb
	sudo rm -rf /usr/share/vim/vim73/lang/no
	sudo rm -rf /usr/share/vim/vim73/lang/pl
	sudo rm -rf /usr/share/vim/vim73/lang/pt_BR
	sudo rm -rf /usr/share/vim/vim73/lang/ru
	sudo rm -rf /usr/share/vim/vim73/lang/sk
	sudo rm -rf /usr/share/vim/vim73/lang/sv
	sudo rm -rf /usr/share/vim/vim73/lang/uk
	sudo rm -rf /usr/share/vim/vim73/lang/vi
	sudo rm -rf /usr/share/vim/vim73/lang/zh_CN
	sudo rm -rf /usr/share/vim/vim73/lang/zh_CN.UTF-8
	sudo rm -rf /usr/share/vim/vim73/lang/zh_TW
	sudo rm -rf /usr/share/vim/vim73/lang/zh_TW.UTF-8
	sudo rm -rf /usr/share/stardict/help
	sudo rm -rf /usr/share/skype/avatars
	sudo rm -rf /usr/share/skype/lang/skype_bg.qm
	sudo rm -rf /usr/share/skype/lang/skype_bg.ts
	sudo rm -rf /usr/share/skype/lang/skype_de.qm
	sudo rm -rf /usr/share/skype/lang/skype_de.ts
	sudo rm -rf /usr/share/skype/lang/skype_es.qm
	sudo rm -rf /usr/share/skype/lang/skype_es.ts
	sudo rm -rf /usr/share/skype/lang/skype_et.qm
	sudo rm -rf /usr/share/skype/lang/skype_et.ts
	sudo rm -rf /usr/share/skype/lang/skype_fr.qm
	sudo rm -rf /usr/share/skype/lang/skype_fr.ts
	sudo rm -rf /usr/share/skype/lang/skype_it.qm
	sudo rm -rf /usr/share/skype/lang/skype_it.ts
	sudo rm -rf /usr/share/skype/lang/skype_ja.qm
	sudo rm -rf /usr/share/skype/lang/skype_ja.ts
	sudo rm -rf /usr/share/skype/lang/skype_ko.qm
	sudo rm -rf /usr/share/skype/lang/skype_ko.ts
	sudo rm -rf /usr/share/skype/lang/skype_lt.qm
	sudo rm -rf /usr/share/skype/lang/skype_lt.ts
	sudo rm -rf /usr/share/skype/lang/skype_lv.qm
	sudo rm -rf /usr/share/skype/lang/skype_lv.ts
	sudo rm -rf /usr/share/skype/lang/skype_pl.qm
	sudo rm -rf /usr/share/skype/lang/skype_pl.ts
	sudo rm -rf /usr/share/skype/lang/skype_pt_br.qm
	sudo rm -rf /usr/share/skype/lang/skype_pt_br.ts
	sudo rm -rf /usr/share/skype/lang/skype_pt_pt.qm
	sudo rm -rf /usr/share/skype/lang/skype_pt_pt.ts
	sudo rm -rf /usr/share/skype/lang/skype_ro.qm
	sudo rm -rf /usr/share/skype/lang/skype_ro.ts
	sudo rm -rf /usr/share/skype/lang/skype_ru.qm
	sudo rm -rf /usr/share/skype/lang/skype_ru.ts
	sudo rm -rf /usr/share/skype/lang/skype_th.qm
	sudo rm -rf /usr/share/skype/lang/skype_th.ts
	sudo rm -rf /usr/share/skype/lang/skype_tr.qm
	sudo rm -rf /usr/share/skype/lang/skype_tr.ts
	sudo rm -rf /usr/share/skype/lang/skype_uk.qm
	sudo rm -rf /usr/share/skype/lang/skype_uk.ts
	sudo rm -rf /usr/share/skype/lang/skype_zh_s.qm
	sudo rm -rf /usr/share/skype/lang/skype_zh_s.ts
	sudo rm -rf /usr/share/skype/lang/skype_zh_t.qm
	sudo rm -rf /usr/share/skype/lang/skype_zh_t.ts
	sudo rm -rf /usr/share/qt/translations
	sudo rm -rf /usr/share/opera/locale/be
	sudo rm -rf /usr/share/opera/locale/bg
	sudo rm -rf /usr/share/opera/locale/da
	sudo rm -rf /usr/share/opera/locale/de
	sudo rm -rf /usr/share/opera/locale/el
	sudo rm -rf /usr/share/opera/locale/es-ES
	sudo rm -rf /usr/share/opera/locale/es-LA
	sudo rm -rf /usr/share/opera/locale/et
	sudo rm -rf /usr/share/opera/locale/fi
	sudo rm -rf /usr/share/opera/locale/fr
	sudo rm -rf /usr/share/opera/locale/fr-CA
	sudo rm -rf /usr/share/opera/locale/fy
	sudo rm -rf /usr/share/opera/locale/hi
	sudo rm -rf /usr/share/opera/locale/hr
	sudo rm -rf /usr/share/opera/locale/hu
	sudo rm -rf /usr/share/opera/locale/id
	sudo rm -rf /usr/share/opera/locale/it
	sudo rm -rf /usr/share/opera/locale/ja
	sudo rm -rf /usr/share/opera/locale/ka
	sudo rm -rf /usr/share/opera/locale/ko
	sudo rm -rf /usr/share/opera/locale/lt
	sudo rm -rf /usr/share/opera/locale/mk
	sudo rm -rf /usr/share/opera/locale/nb
	sudo rm -rf /usr/share/opera/locale/nl
	sudo rm -rf /usr/share/opera/locale/nn
	sudo rm -rf /usr/share/opera/locale/pl
	sudo rm -rf /usr/share/opera/locale/pt
	sudo rm -rf /usr/share/opera/locale/pt-BR
	sudo rm -rf /usr/share/opera/locale/ro
	sudo rm -rf /usr/share/opera/locale/ru
	sudo rm -rf /usr/share/opera/locale/sr
	sudo rm -rf /usr/share/opera/locale/sv
	sudo rm -rf /usr/share/opera/locale/ta
	sudo rm -rf /usr/share/opera/locale/te
	sudo rm -rf /usr/share/opera/locale/tr
	sudo rm -rf /usr/share/opera/locale/uk
	sudo rm -rf /usr/share/opera/locale/vi
	sudo rm -rf /usr/share/opera/locale/zh-cn
	sudo rm -rf /usr/share/opera/locale/zh-hk
	sudo rm -rf /usr/share/opera/locale/zh-tw
	sudo rm -rf /usr/share/opera/locale/af
	sudo rm -rf /usr/share/opera/locale/az
	sudo rm -rf /usr/share/opera/locale/bn
	sudo rm -rf /usr/share/opera/locale/en-GB
	sudo rm -rf /usr/share/opera/locale/gd
	sudo rm -rf /usr/share/opera/locale/me
	sudo rm -rf /usr/share/opera/locale/ms
	sudo rm -rf /usr/share/opera/locale/pa
	sudo rm -rf /usr/share/opera/locale/sk
	sudo rm -rf /usr/share/opera/locale/sw
	sudo rm -rf /usr/share/opera/locale/th
	sudo rm -rf /usr/share/opera/locale/tl
	sudo rm -rf /usr/share/opera/locale/uz
	sudo rm -rf /usr/share/opera/locale/zu
	sudo rm -rf /usr/share/opera-next/locale/be
	sudo rm -rf /usr/share/opera-next/locale/bg
	sudo rm -rf /usr/share/opera-next/locale/da
	sudo rm -rf /usr/share/opera-next/locale/de
	sudo rm -rf /usr/share/opera-next/locale/el
	sudo rm -rf /usr/share/opera-next/locale/es-ES
	sudo rm -rf /usr/share/opera-next/locale/es-LA
	sudo rm -rf /usr/share/opera-next/locale/et
	sudo rm -rf /usr/share/opera-next/locale/fi
	sudo rm -rf /usr/share/opera-next/locale/fr
	sudo rm -rf /usr/share/opera-next/locale/fr-CA
	sudo rm -rf /usr/share/opera-next/locale/fy
	sudo rm -rf /usr/share/opera-next/locale/hi
	sudo rm -rf /usr/share/opera-next/locale/hr
	sudo rm -rf /usr/share/opera-next/locale/hu
	sudo rm -rf /usr/share/opera-next/locale/id
	sudo rm -rf /usr/share/opera-next/locale/it
	sudo rm -rf /usr/share/opera-next/locale/ja
	sudo rm -rf /usr/share/opera-next/locale/ka
	sudo rm -rf /usr/share/opera-next/locale/ko
	sudo rm -rf /usr/share/opera-next/locale/lt
	sudo rm -rf /usr/share/opera-next/locale/mk
	sudo rm -rf /usr/share/opera-next/locale/nb
	sudo rm -rf /usr/share/opera-next/locale/nl
	sudo rm -rf /usr/share/opera-next/locale/nn
	sudo rm -rf /usr/share/opera-next/locale/pl
	sudo rm -rf /usr/share/opera-next/locale/pt
	sudo rm -rf /usr/share/opera-next/locale/pt-BR
	sudo rm -rf /usr/share/opera-next/locale/ro
	sudo rm -rf /usr/share/opera-next/locale/ru
	sudo rm -rf /usr/share/opera-next/locale/sr
	sudo rm -rf /usr/share/opera-next/locale/sv
	sudo rm -rf /usr/share/opera-next/locale/ta
	sudo rm -rf /usr/share/opera-next/locale/te
	sudo rm -rf /usr/share/opera-next/locale/tr
	sudo rm -rf /usr/share/opera-next/locale/uk
	sudo rm -rf /usr/share/opera-next/locale/vi
	sudo rm -rf /usr/share/opera-next/locale/zh-cn
	sudo rm -rf /usr/share/opera-next/locale/zh-hk
	sudo rm -rf /usr/share/opera-next/locale/zh-tw
	sudo rm -rf /usr/share/opera-next/locale/af
	sudo rm -rf /usr/share/opera-next/locale/az
	sudo rm -rf /usr/share/opera-next/locale/bn
	sudo rm -rf /usr/share/opera-next/locale/en-GB
	sudo rm -rf /usr/share/opera-next/locale/gd
	sudo rm -rf /usr/share/opera-next/locale/me
	sudo rm -rf /usr/share/opera-next/locale/ms
	sudo rm -rf /usr/share/opera-next/locale/pa
	sudo rm -rf /usr/share/opera-next/locale/sk
	sudo rm -rf /usr/share/opera-next/locale/sw
	sudo rm -rf /usr/share/opera-next/locale/th
	sudo rm -rf /usr/share/opera-next/locale/tl
	sudo rm -rf /usr/share/opera-next/locale/uz
	sudo rm -rf /usr/share/opera-next/locale/zu
	sudo rm -rf /usr/share/applications/gparted.desktop
	sudo rm -rf /usr/share/applications/assistant.desktop
	sudo rm -rf /usr/share/applications/parcellite.desktop
	sudo rm -rf /usr/share/applications/dconf-editor.desktop
	sudo rm -rf /usr/share/applications/htop.desktop
	sudo rm -rf /usr/share/applications/rxvt-unicode.desktop
	sudo rm -rf /usr/share/applications/avahi-discover.desktop
	sudo rm -rf /usr/share/applications/bssh.desktop
	sudo rm -rf /usr/share/applications/bvnc.desktop
	sudo rm -rf /usr/share/applications/designer.desktop
	sudo rm -rf /usr/share/applications/linguist.desktop
	sudo rm -rf /usr/share/applications/base.desktop
	sudo rm -rf /usr/share/applications/cups.desktop
	sudo rm -rf /usr/share/applications/exo-file-manager.desktop
	sudo rm -rf /usr/share/applications/exo-mail-reader.desktop
	sudo rm -rf /usr/share/applications/exo-preferred-applications.desktop
	sudo rm -rf /usr/share/applications/exo-terminal-emulator.desktop
	sudo rm -rf /usr/share/applications/exo-web-browser.desktop
	sudo rm -rf /usr/share/applications/gksu.desktop
	sudo rm -rf /usr/share/applications/gksu-properties.desktop
	sudo rm -rf /usr/share/applications/gthumb-import.desktop
	sudo rm -rf /usr/share/applications/javafilter.desktop
	sudo rm -rf /usr/share/applications/mimeinfo.cache
	sudo rm -rf /usr/share/applications/qstart.desktop
	sudo rm -rf /usr/share/applications/startcenter.desktop
	sudo rm -rf /usr/share/applications/template.desktop
	sudo rm -rf /usr/share/applications/Thunar-folder-handler.desktop
	sudo rm -rf /usr/share/applications/thunar-settings.desktop
	sudo rm -rf /usr/share/applications/wine.desktop
	sudo rm -rf /usr/share/applications/qv4l2.desktop
	sudo rm -rf /usr/share/applications/gvim.desktop
	sudo rm -rf /usr/share/applications/7zFM.desktop
	sudo rm -rf /usr/share/applications/mplayer.desktop


	echo -e "\e[1;34m::\e[0m Cleaning with BleachBit..."
	sudo bleachbit -c deepscan.backup deepscan.ds_store deepscan.thumbs_db deepscan.tmp firefox.cache firefox.cookies firefox.dom firefox.download_history firefox.forms firefox.session_restore firefox.site_preferences firefox.url_history firefox.vacuum flash.cache flash.cookies gimp.tmp midnightcommander.history openofficeorg.cache openofficeorg.recent_documents opera.cache opera.current_session opera.dom opera.download_history opera.search_history opera.url_history pidgin.cache pidgin.logs skype.chat_logs system.cache system.clipboard system.desktop_entry system.localizations system.recent_documents system.rotated_logs system.tmp system.trash thumbnails.cache vim.history wine.tmp x11.debug_logs &> /dev/null
	bleachbit -c deepscan.backup deepscan.ds_store deepscan.thumbs_db deepscan.tmp firefox.cache firefox.cookies firefox.dom firefox.download_history firefox.forms firefox.session_restore firefox.site_preferences firefox.url_history firefox.vacuum flash.cache flash.cookies gimp.tmp midnightcommander.history openofficeorg.cache openofficeorg.recent_documents opera.cache opera.current_session opera.dom opera.download_history opera.search_history opera.url_history pidgin.cache pidgin.logs skype.chat_logs system.cache system.clipboard system.desktop_entry system.localizations system.recent_documents system.rotated_logs system.tmp system.trash thumbnails.cache vim.history wine.tmp x11.debug_logs &> /dev/null

	echo -e "\e[1;34m::\e[0m Done."
}

backup () {
	backup_dir=/media/StoreJet/bkp
	if [ -d $backup_dir ]; then
		echo -e "\e[1;34m::\e[0m Backing up SD..."
		rsync -a --delete --exclude 'mail' /mnt/SD/ $backup_dir/SD/
		echo -e "\e[1;34m::\e[0m Backing up home..."
		rsync -a --delete /home/ok/ $backup_dir/home/
		echo -e "\e[1;34m::\e[0m Done."
	else
		echo -e "\e[1;31merror:\e[0m backup directory not found"
	fi
}

# auto-completion
complete -cf sudo
complete -cf man
