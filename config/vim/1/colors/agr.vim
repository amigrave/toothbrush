" Vim color file
"
" Author: Fabien Meghazi <agr@amigrave.com>
"

hi clear
if exists("syntax_on")
	syntax reset
endif
set background=dark
syntax on

hi Normal  ctermfg=white ctermbg=black guifg=Grey80 guibg=black
hi Comment ctermfg=darkred ctermbg=black guifg=#dd5555 guibg=black
hi rubySharpBang ctermfg=darkred ctermbg=black guifg=#dd5555 guibg=black
hi Cursor ctermfg=white ctermbg=red guifg=white guibg=red
hi SpecialKey ctermfg=darkgray ctermbg=black guifg=darkgray guibg=black
hi FoldColumn ctermfg=white ctermbg=darkgray guifg=white guibg=darkgray
hi LineNr ctermfg=white ctermbg=darkgray guifg=white guibg=darkgray
hi Visual ctermfg=gray ctermbg=black guifg=black guibg=gray
hi Folded ctermfg=gray ctermbg=darkblue guifg=white guibg=#555577 gui=bold
hi String ctermfg=blue guifg=#83a1ff
hi rubyStringDelimiter ctermfg=blue guifg=#83a1ff
hi xmlRegion ctermfg=white guifg=white
hi xmlAttribQWeb guifg=#f0a040 ctermfg=DarkMagenta
hi xmlAttribQWebTrad guifg=#ffffff ctermfg=white
hi TabLineFill ctermbg=4 cterm=none
hi TabLine ctermbg=4 cterm=none
hi TabLineSel ctermbg=5 ctermfg=7 cterm=bold
hi Search ctermfg=White ctermbg=Red cterm=none
hi ToDo ctermbg=Green
hi clear CursorLine
hi CursorLine ctermbg=4
hi MatchParen ctermbg=1
hi rubyDefine ctermfg=yellow guifg=yellow
hi rubyInstanceVariable ctermfg=darkgray guifg=darkgray
hi Pmenu ctermbg=magenta ctermfg=black
hi PmenuSel ctermbg=magenta ctermfg=white

hi htmlTag ctermfg=green ctermbg=black
hi htmlTagName ctermfg=green ctermbg=black
hi htmlEndTag ctermfg=green ctermbg=black
hi htmlArg ctermfg=grey ctermbg=black

hi DiffAdd cterm=none ctermfg=bg ctermbg=Green gui=none guifg=bg guibg=Green
hi DiffDelete cterm=none ctermfg=bg ctermbg=Red gui=none guifg=bg guibg=Red
hi DiffChange cterm=none ctermfg=bg ctermbg=Yellow gui=none guifg=bg guibg=Yellow
hi DiffText cterm=none ctermfg=bg ctermbg=Magenta gui=none guifg=bg guibg=Magenta
