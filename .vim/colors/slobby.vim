" Vim color file

" First remove all existing highlighting.
hi clear

let colors_name = "slobby"

hi ErrorMsg term=standout ctermbg=1 ctermfg=White
hi IncSearch term=reverse cterm=reverse
hi ModeMsg term=bold cterm=bold
hi VertSplit term=reverse cterm=reverse
hi Visual term=reverse cterm=reverse 
hi VisualNOS term=underline,bold cterm=underline,bold
hi DiffText term=reverse cterm=bold ctermbg=9
hi Directory term=bold ctermfg=4
hi LineNr term=underline ctermfg=Black
hi MoreMsg term=bold ctermfg=2
hi Question term=standout ctermfg=2
hi Search term=reverse ctermbg=3 ctermfg=NONE
hi SpecialKey term=bold ctermfg=4
hi Title term=bold ctermfg=5
hi WarningMsg term=standout ctermfg=1
hi WildMenu term=standout ctermbg=12 ctermfg=0
hi Folded term=standout ctermbg=8 ctermfg=4
hi FoldColumn term=standout ctermbg=8 ctermfg=4
hi DiffAdd term=bold ctermbg=12
hi DiffChange term=bold ctermbg=13
hi DiffDelete term=bold ctermfg=4 ctermbg=14
hi Ignore ctermfg=darkgrey

hi StatusLine   cterm=bold ctermbg=4 ctermfg=3
hi StatusLineNC cterm=bold ctermbg=4 ctermfg=0
hi NonText term=bold ctermfg=4

" syntax highlighting
hi PreProc    term=underline cterm=NONE ctermfg=5  
hi Identifier term=underline cterm=NONE ctermfg=6     
hi Comment    term=NONE      cterm=NONE ctermfg=1      
hi Constant   term=underline cterm=NONE ctermfg=2    
hi Special    term=bold      cterm=NONE ctermfg=9     
hi Statement  term=bold      cterm=bold ctermfg=4         
hi Type       term=underline cterm=NONE ctermfg=4          

if exists("syntax_on")
  let syntax_cmd = "enable"
  runtime syntax/syncolor.vim
  unlet syntax_cmd
endif

" vim: sw=2


