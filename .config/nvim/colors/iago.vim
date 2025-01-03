" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer: 
" Last Change: 02 Out 2004 21:49


set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

syn keyword rTodoKeyw BUG FIXME NOTE TODO TEST CHECK contained

let g:colors_name = "iago"
hi Normal  guifg=#f0f0f0 guibg=black
hi NonText  guifg=brown
hi comment  guifg=lightgreen
hi constant  guifg=cyan gui=bold
hi identifier guifg=cyan gui=NONE
hi statement guifg=lightblue gui=NONE
hi preproc  guifg=Pink2
hi type   guifg=seagreen gui=bold
hi special  guifg=yellow
hi ErrorMsg  guifg=Black guibg=red
hi WarningMsg guifg=Black guibg=Green
hi Error  guibg=Red
hi Todo guifg=Black guibg=orange
hi Cursor  guibg=red guifg=black ctermbg=12
hi! CursorInsert guibg=#0077ff guifg=#ffffff ctermbg=39  ctermfg=12
hi! CursorVisual guibg=#2077ff guifg=#ffffff ctermbg=38 ctermfg=12
hi! CursorReplace guibg=#ff2000 guifg=#ffffff ctermbg=196 ctermfg=12
hi Search  guibg=lightslateblue
hi IncSearch gui=NONE guibg=steelblue
hi LineNr  guifg=darkgrey
hi title  guifg=darkgrey
hi Title  gui=bold guifg=#d4ee10
hi htmlH1 gui=bold guifg=#d4ee10
hi htmlH2 gui=bold guifg=#d4ee10
hi htmlH3 gui=bold guifg=#d4ee10
hi htmlH4 gui=bold guifg=#d4ee10
hi StatusLineNC gui=NONE guifg=lightblue guibg=darkblue
hi StatusLine gui=bold guifg=cyan guibg=blue
hi label  guifg=gold2
hi operator  guifg=orange
hi Function  guifg=rred
hi clear Visual
hi Visual  term=reverse cterm=reverse gui=reverse
hi DiffChange   guibg=darkgreen
hi DiffText  guibg=olivedrab
hi DiffAdd  guibg=slateblue
hi DiffDelete   guibg=coral
hi Folded  guibg=#2E2E2E guifg=lightgreen
hi FoldColumn guibg=gray10 guifg=gray60
hi ColorColumn  guibg=black guibg=gray10
hi cIf0   guifg=gray
hi SpecialKey  guifg=gray40
hi String       gui=bold guifg=lightgreen
hi Ignore       guifg=white

" TODO.txt
hi TodoContext  guifg=white
hi TodoProject  guifg=white

" Inbox
hi TodoPriority0  gui=bold guifg=DarkOrange
" Doing
hi TodoPriorityA  gui=bold guifg=Yellow
" Ready
hi TodoPriorityB  gui=bold guifg=SpringGreen
" Backlog
hi TodoPriorityC  gui=bold guifg=SteelBlue3
" Done
hi TodoPriorityG  gui=bold guifg=DarkTurquoise
" Idea
hi TodoPriorityI  gui=bold guifg=Orange
" WaitingFor
hi TodoPriorityW  gui=bold guifg=SlateGray1

" spell
highlight default SpellErrors ctermfg=Red guifg=Red cterm=underline gui=underline term=reverse

highlight clear SignColumn

" gitgutter
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" current line
set cursorline
hi CursorLine  guibg=#222222
