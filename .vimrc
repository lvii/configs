"
""  ~/.vimrc
""" author  : OK100 <ok100@lavabit.com>
""  website : https://github.com/ok100
"

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

set nocompatible

syntax on
filetype plugin on

colorscheme dc3

set mouse=a                            " enable mouse
set wrap                               " wrap lines
set nobackup                           " disable backup files (filename~)
set number                             " show line numbers
set linebreak                          " attempt to wrap lines cleanly
set wildmenu                           " enhanced tab-completion shows all matching cmds in a popup menu
set clipboard=unnamed                  " yank to X clipboard

set tabstop=4                          " tabs appear as n number of columns
set shiftwidth=4                       " n cols for auto-indenting
set autoindent                         " auto indents next new line

set hlsearch                           " highlight all search results
set incsearch                          " increment search
set ignorecase                         " case-insensitive search
set smartcase                          " uppercase causes case-sensitive search

set ttyfast 			               " u got a fast terminal
set ttyscroll=3
set lazyredraw 			               " to avoid scrolling problems

set hidden                             " current buffer can be put to the background without writing to disk

let g:loaded_matchparen = 1
let g:acp_behaviorKeywordLength = 4    " autocomplete words with at least 4 characters

" status bar
set laststatus=2	                   " always show the statusline
set showmode                           " show mode in status line
set showcmd                            " show partial commands in status line
set statusline=%{&ff}\ \%{&fenc}\ \%#StatusFTP#\%Y\ \%#StatusRO#\%R\ \%#StatusHLP#\%H\ \%#StatusPRV#\%W\ \%#StatusModFlag#\%M\ \%#StatusLine#\%f\%=\%1.7c\ \%1.7l/%L\ \%p%%


if has("autocmd")
    " always jump to the last cursor position
    autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif

    autocmd BufRead *.txt set tw=80                                   " limit width to n cols for txt files
    autocmd BufRead ~/.mutt/temp/mutt-* set tw=80 ft=mail nocindent   " width, mail syntax hilight
    autocmd FileType tex set tw=80                                    " wrap at 80 chars for LaTeX files
	autocmd FileType html setlocal shiftwidth=2 tabstop=2
	autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 omnifunc=pythoncomplete#Complete
endif

" Map keys to toggle functions
function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction

command! -nargs=+ MapToggle call MapToggle(<f-args>)
" Keys & functions
MapToggle <F6>  number
MapToggle <F7>  spell
MapToggle <F8>  paste
MapToggle <F9>  hlsearch
MapToggle <F10> wrap

" <leader> character
let mapleader = ","

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

"------------------------------------------------------------------------------ 
" DmenuOpen
"------------------------------------------------------------------------------ 
" Strip the newline from the end of a string
function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction

" Find a file and pass it to cmd
function! DmenuOpen(cmd)
  let fname = Chomp(system("git ls-files | dmenu -i -l 20 -p " . a:cmd))
  if empty(fname)
    return
  endif
  execute a:cmd . " " . fname
endfunction

map <c-t> :call DmenuOpen("tabe")<cr>
map <c-f> :call DmenuOpen("e")<cr>

"------------------------------------------------------------------------------ 
" Tagbar
"------------------------------------------------------------------------------ 
"autocmd VimEnter * nested :call tagbar#autoopen(1)
nmap <F2> :TagbarToggle<CR>

highlight TagbarHighlight ctermbg=yellow ctermfg=black

let g:tagbar_width = 30
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['→', '▼']
let g:tagbar_autoshowtag = 0

"------------------------------------------------------------------------------ 
" Syntastic
"------------------------------------------------------------------------------ 
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 4
let g:syntastic_python_checker_args = '--ignore=E501'
