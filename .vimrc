"
""  ~/.vimrc
""" author  : OK <ok100.ok100.ok100@gmail.com>
""  website : https://github.com/ok100
"
set nocompatible

syntax on
filetype plugin on

colorscheme dc3

set mouse=a                " enable mouse
set wrap                   " wrap lines
set nobackup               " disable backup files (filename~)
set number                 " show line numbers
set linebreak              " attempt to wrap lines cleanly
set wildmenu               " enhanced tab-completion shows all matching cmds in a popup menu
set spelllang=sk           " default spelling language
set clipboard=unnamed      " yank to X clipboard

set tabstop=4              " tabs appear as n number of columns
set shiftwidth=4           " n cols for auto-indenting
set autoindent             " auto indents next new line

set hlsearch               " highlight all search results
set incsearch              " increment search
set ignorecase             " case-insensitive search
set smartcase              " uppercase causes case-sensitive search
let g:loaded_matchparen = 1
let g:acp_behaviorKeywordLength = 4

" status bar
"set statusline=\ \%F%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\ 
"set laststatus=2
"set cmdheight=1

if has("autocmd")
    " always jump to the last cursor position
    autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif

    autocmd BufRead *.txt set tw=80                                         " limit width to n cols for txt files
    autocmd BufRead ~/.mutt/temp/mutt-* set tw=80 ft=mail nocindent spell   " width, mail syntax hilight, spellcheck
    autocmd FileType tex set tw=80                                          " wrap at 80 chars for LaTeX files
	autocmd FileType html setlocal shiftwidth=2 tabstop=2
	autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 omnifunc=pythoncomplete#Complete
	let g:pydiction_location = '/usr/share/pydiction/complete-dict'
endif

" Map keys to toggle functions
function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction

command! -nargs=+ MapToggle call MapToggle(<f-args>)
" Keys & functions
MapToggle <F6> number
MapToggle <F7> spell
MapToggle <F8> paste
MapToggle <F9> hlsearch
MapToggle <F10> wrap

" LaTeX settings
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'

" space bar un-highligts search
:noremap <silent> <Space> :silent noh<Bar>echo<CR>

" Allows writing to files with root priviledges
cmap w!! w !sudo tee % > /dev/null

" C-a to select all
nnoremap  ggVG
inoremap  ggVG

" C-w to quit
nnoremap  :confirm quit<CR>
inoremap  :confirm quit<CR>

" fix numeric keys in tmux
noremap Oj *
inoremap Oj *
noremap Ok +
inoremap Ok +
noremap Oq 1
inoremap Oq 1
noremap Or 2
inoremap Or 2
noremap Os 3
inoremap Os 3
noremap Ot 4
inoremap Ot 4
noremap Ou 5
inoremap Ou 5
noremap Ov 6
inoremap Ov 6
noremap Ow 7
inoremap Ow 7
noremap Ox 8
inoremap Ox 8
noremap Oy 9
inoremap Oy 9
noremap Oo /
inoremap Oo /
noremap Om -
inoremap Om -

" Strip the newline from the end of a string
function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction

" Find a file and pass it to cmd
function! DmenuOpen(cmd)
  let fname = Chomp(system("git ls-files | dmenu -i -fn -*-termsyn-medium-*-*-*-11-*-*-*-*-*-*-* -nb '#1A1A1A' -nf '#999999' -sb '#4C4C4C' -sf '#B3B3B3' -l 20 -p " . a:cmd))
  if empty(fname)
    return
  endif
  execute a:cmd . " " . fname
endfunction

map <c-t> :call DmenuOpen("tabe")<cr>
map <c-f> :call DmenuOpen("e")<cr>
