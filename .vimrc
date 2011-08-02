"---------------------------------------------------------------
" file:     ~/.vimrc                         
" author:   jason ryan - http://jasonwryan.com/    
" vim:fenc=utf-8:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=vim:
"---------------------------------------------------------------

syntax on
filetype plugin on

if &t_Co < 256
    colorscheme miro8   " colourscheme for the 8 colour linux term
else
    colorscheme miromiro
endif

set mouse=a             " enable mouse
set nocompatible        " leave the old ways behind...
set wrap                " wrap lines
set nobackup            " disable backup files (filename~)
set splitbelow          " place new files below the current
set clipboard+=unnamed  " yank and copy to X clipboard
set encoding=utf-8      " UTF-8 encoding for all new files
set backspace=2         " full backspacing capabilities (indent,eol,start)
set number              " show line numbers
set ww=b,s,h,l,<,>,[,]  " whichwrap -- left/right keys can traverse up/down
set linebreak           " attempt to wrap lines cleanly
set wildmenu            " enhanced tab-completion shows all matching cmds in a popup menu
set spelllang=sk        " default spelling language
set wildmode=list:longest,full
let g:loaded_matchparen=1

" tabs and indenting
set expandtab           " insert spaces instead of tabs
set tabstop=4           " tabs appear as n number of columns
set shiftwidth=4        " n cols for auto-indenting
set autoindent          " auto indents next new line

" searching
set hlsearch            " highlight all search results
set incsearch           " increment search
set ignorecase          " case-insensitive search
set smartcase           " uppercase causes case-sensitive search

" status bar info and appearance
set statusline=\ \%f%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\ 
set laststatus=2
set cmdheight=1

if has("autocmd")
	" always jump to the last cursor position
	autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif
	autocmd BufRead *.txt set tw=80 " limit width to n cols for txt files
	autocmd BufRead ~/.mutt/temp/mutt-* set tw=80 ft=mail nocindent spell   " width, mail syntax hilight, spellcheck
    autocmd FileType tex set tw=80   " wrap at 80 chars for LaTeX files
endif

" Map keys to toggle functions
function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction

command! -nargs=+ MapToggle call MapToggle(<f-args>)
" Keys & functions
:map <F3> :NERDTree<CR>
MapToggle <F4> number
MapToggle <F5> spell
MapToggle <F6> paste
MapToggle <F7> hlsearch
MapToggle <F8> wrap

" LaTeX settings
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" keep cursor centered
:nnoremap j jzz
:nnoremap k kzz

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

" C-f to search
nnoremap  /
inoremap  /

" C-s to save
inoremap <C-s> <esc>:w<cr>a
nnoremap <C-s> :w<cr>

noremap ěě @
noremap ššš #
noremap čč $
noremap řř %
noremap žž ^
noremap ýý &
noremap áá *
noremap íí (
noremap éé )
noremap úú {
noremap ůů :
inoremap ěě @
inoremap ššš #
inoremap čč $
inoremap řř %
inoremap žž ^
inoremap ýý &
inoremap áá *
inoremap íí (
inoremap éé )
inoremap úú {
inoremap ůů :
inoremap §§ '
