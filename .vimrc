"
""  ~/.vimrc
""" author  : OK <ok100.ok100.ok100@gmail.com>
""  website : https://github.com/ok100
"
set nocompatible

syntax on
filetype plugin on

colorscheme dc3

set mouse=a             " enable mouse
set wrap                " wrap lines
set nobackup            " disable backup files (filename~)
set number              " show line numbers
set linebreak           " attempt to wrap lines cleanly
set wildmenu            " enhanced tab-completion shows all matching cmds in a popup menu
set spelllang=sk        " default spelling language
set expandtab           " insert spaces instead of tabs
set tabstop=4           " tabs appear as n number of columns
set shiftwidth=4        " n cols for auto-indenting
set autoindent          " auto indents next new line
set hlsearch            " highlight all search results
set incsearch           " increment search
set ignorecase          " case-insensitive search
set smartcase           " uppercase causes case-sensitive search

" status bar
set statusline=\ \%F%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\ 
set laststatus=2
set cmdheight=1

if has("autocmd")
        " always jump to the last cursor position
        autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif

        autocmd BufRead *.txt set tw=80                                         " limit width to n cols for txt files
        autocmd BufRead ~/.mutt/temp/mutt-* set tw=80 ft=mail nocindent spell   " width, mail syntax hilight, spellcheck
    autocmd FileType tex set tw=80                                              " wrap at 80 chars for LaTeX files
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

"noremap ěě @
"noremap ššš #
"noremap čč $
"noremap řř %
"noremap žž ^
"noremap ýý &
"noremap áá *
"noremap íí (
"noremap éé )
"noremap úú {
"noremap ůů :
"inoremap ěě @
"inoremap ššš #
"inoremap čč $
"inoremap řř %
"inoremap žž ^
"inoremap ýý &
"inoremap áá *
"inoremap íí (
"inoremap éé )
"inoremap úú {
"inoremap ůů :
"inoremap §§ ' 

noremap Oj *
inoremap Oj *

