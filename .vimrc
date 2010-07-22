" vim:ft=vim:fdm=marker:nowrap:foldmethod=marker
scriptencoding utf-8

" ################################### OPTIONS ################################### {{{
set all&
set vb t_vb=
set autoindent backspace=2 hidden history=500 hlsearch ignorecase
set nobackup nocompatible noerrorbells noexpandtab
set ruler number shiftwidth=4 showcmd showmode t_vb= tabstop=4 textwidth=0
set viminfo='200,\"5000 nowrap
"set list listchars=tab:~.,trail:.,extends:>,precedes:<
if (&termencoding == "utf-8") || has("gui_running")
	if v:version >= 700
		set list listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:=
	else
		set list listchars=tab:»·,trail:·,extends:>,precedes:<
	endif
else
	if v:version >= 700
		set list listchars=tab:~.,trail:.,extends:>,precedes:<,nbsp:_
	else
		set list listchars=tab:~.,trail:.,extends:>,precedes:<
	endif
endif
"set fileencodings=ascii,ucs-bom,utf-8,ucs-2,ucs-le,latin1
set encoding=utf8
set fileencoding=utf8
set fileencodings=utf-8,latin1
:filetype plugin on
"}}}

" ################################### PLATFORM ################################## {{{
if has("win32")
	au GUIEnter * simalt ~x
endif
if has("gui_kde")
	set guifont=Bitstream\ Vera\ Sans\ Mono/11/-1/5/50/0/0/0/0/0
endif
if has("gui_gtk2")
	"set guifont=Fixedsys\ Excelsior\ 2.00\ 11
	set guifont=console
endif
if has("unix")
	let $VIMFILES=$HOME . "/.vim"
else
	let $VIMFILES=$HOME . "\\vim"
endif
if $TERM == "screen"
	set term=rxvt
endif
"}}}

" ############################### SYNTAX & COLORS ############################### {{{
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
"}}}

" ############################## FOLDING & AUTOCMD ############################## {{{
if has("autocmd")
	au BufEnter * cd %:p:h		"automatically change cwd to file's dir
	au BufReadPost * if line("'\"") | exe "normal '\"" | endif
	au BufReadPost * if getline(1) =~ '^#!.*python' | set filetype=python | endif
	au BufReadPost * if getline(1) =~ '^#!.*ruby' | set filetype=ruby | endif
	au BufReadPost * if getline(1) =~ '^#!.*bash' | set filetype=sh | endif
	au BufRead *.txt set expandtab " tw=78
	au BufRead,BufNewFile *.xml,*.xsl  set foldmethod=syntax foldcolumn=3 foldnestmax=2 foldlevel=2
	au BufRead,BufNewFile *.php,*.php3 set foldmethod=syntax foldcolumn=3 foldnestmax=2 foldlevel=2
	au BufRead,BufNewFile *.rb set fdm=syntax foldcolumn=0 foldnestmax=2 foldlevel=2
	au BufRead,BufNewFile *.aspx set syntax=cs
	"au BufRead,BufNewFile *.asp set ft=javascript
	au BufRead,BufNewFile *.css,*.aspx,*.c,*.cpp,*.cs,*.java,*.js,*.asp syn region myFold start="{" end="}" transparent fold
							\ | syn sync fromstart | set foldmethod=syntax foldcolumn=3 foldnestmax=2 foldlevel=2
	au BufRead,BufNewFile *.js,*.asp syn clear javaScriptBraces
	au BufReadPost *.js,*.css,*.asp set tabstop=4 shiftwidth=4 " override ftplugin tab=4

	au Filetype python set foldmethod=expr foldexpr=GetPythonFold(v:lnum) foldtext=PythonFoldText() foldcolumn=3 foldnestmax=2 foldlevel=2 tabstop=4 shiftwidth=4
	au Filetype python syn match agrEq "[=]" | hi agrEq ctermfg=green
	au Filetype python syn match agrSelf "self" | hi agrSelf ctermfg=gray

	au Filetype ruby set foldmethod=syntax foldcolumn=0 foldnestmax=2 foldlevel=2

	if has("unix")
		au BufNewFile *.py set autoread | s,^,#!/usr/bin/python, | w | !chmod +x %
		au BufNewFile *.rb set autoread | s,^,#!/usr/bin/ruby, | w | !chmod +x %
		au BufNewFile *.sh set autoread | s,^,#!/bin/bash, | w | !chmod +x %
	endif

	au Filetype xml call XmlQweb()
endif
"}}}

" ############################## LANGUAGE SPECIFIC ############################## {{{
"let javaScript_fold=1
"let php_minlines = 1000
"let php_htmlInStrings = 1
let php_sync_method=0
let php_folding=1
let php_asp_tags = 1
let g:xml_syntax_folding=1
let python_highlight_numbers = 1
"}}}

" ################################### KEYMAPS ################################### {{{
" Broken terminals
if (&term =~ "xterm") || (&term =~ "vt100")
	set t_kP=[5~ t_kN=[6~ t_kh=[1~ t_@7=[4~
endif
" map Q gqq
nnoremap <silent> <F4> zi
inoremap <silent> <F4> <C-O>zi
nnoremap <silent> <F5> zm
inoremap <silent> <F5> <C-O>zm
nnoremap <silent> <F6> :TlistToggle<CR><C-w><C-w>
inoremap <silent> <F6> <C-O>:TlistToggle<CR>
nnoremap <silent> <F7> :set foldmethod=syntax<CR>
inoremap <silent> <F7> <C-O>:set foldmethod=syntax<CR>
nnoremap <silent> <F9> :16vsp .<CR>:wincmd p<CR>
"nnoremap <silent> <F10> :wincmd h<CR>:q<CR>
nnoremap <silent> <F10> :bde<CR>
inoremap <silent> <F10> <C-O>:bde<CR>
nnoremap <F12> :set paste!<CR>
inoremap <F12> <C-O>:set paste!<CR>

noremap [a zc
inoremap [a <C-O>zc
noremap <S-Up> zc
inoremap <S-Up> <C-O>zc

noremap <C-Down> <C-E><Down>
inoremap <C-Down> <C-O><C-E><Down>
noremap Ob <C-E><Down>
inoremap Ob <C-O><C-E><Down>
noremap <C-Up> <C-Y><Up>
inoremap <C-Up> <C-O><C-Y><Up>
noremap Oa <C-Y><Up>
inoremap Oa <C-O><C-Y><Up>

noremap <C-Left> b
inoremap <C-Left> <C-O>b
noremap Od b
inoremap Od <C-O>b
noremap <C-Right> w
inoremap <C-Right> <C-O>w
noremap Oc w
inoremap Oc <C-O>w

vnoremap <Tab> >
vnoremap <S-Tab> <LT>

"inoremap {{ {
inoremap %% <%%><left><left>
inoremap %%<cr> <%<cr>%><esc>O<Tab>
inoremap {<cr> {<cr>}<esc>O<Tab>
inoremap {{ {{   }}<left><left><left><left>
inoremap [ []<left>
inoremap ( ()<left>
inoremap <C-Backspace> <End>
inoremap <S-Backspace> <Home>

" For IMAP template expander
imap <C-j> <C-]>

map <M-i> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") ."> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
map i :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") ."> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" }}}

" ################################### PLUGINS ################################### {{{

" Vim 7 tabs {{{
"command! -nargs=* -complete=file E :tabnew <args>
if (v:version < 700)
	nnoremap <silent> <F2> :bp!<CR>
	inoremap <silent> <F2> <C-O>:bp!<CR>
	nnoremap <silent> <F3> :bn!<CR>
	inoremap <silent> <F3> <C-O>:bn!<CR>
else
	command! -nargs=* -complete=file E if expand('%')=='' && line('$')==1 && getline(1)=='' | :edit <args> | else | :tabnew <args> | endif
	cabbrev e <c-R>=(getcmdtype()==':' && getcmdpos()==1 ? 'E' : 'e')<cr>
	nnoremap <silent> <F2> :tabprevious<CR>
	inoremap <silent> <F2> <C-O>:tabprevious<CR>
	nnoremap <silent> <F3> :tabnext<CR>
	inoremap <silent> <F3> <C-O>:tabnext<CR>
endif
" }}}

" Xml QWeb {{{
function! XmlQweb()
	syn match   xmlAttribQWeb
		\ +[-'"<]\@<!\<t-[a-zA-Z:_][-.0-9a-zA-Z0-9:_]*\>\(['">]\@!\|$\)+
		\ contained
		\ contains=xmlAttribPunct,@xmlAttribHook
		\ display

	syn cluster xmlAttribHook contains=xmlAttribQWeb
	hi link xmlAttribQWeb     xmlAttribQWeb

"	syn match   xmlAttribQWebTrad
"		\ +[-'"<]\@<!\<t-trad[-.0-9a-zA-Z0-9:_]*\>\(['">]\@!\|$\)+
"		\ contained
"		\ contains=xmlAttribPunct,@xmlAttribHook
"		\ display

"	syn cluster xmlAttribHook contains=xmlAttribQWebTrad,xmlAttribQWeb
"	hi link xmlAttribQWebTrad     xmlAttribQWebTrad
endfunction
" }}}

" Tab Completion {{{
if has("eval")
	if (v:version < 700)
		function! InsertTabWrapper(direction)
			let col = col('.') - 1
			if !col || getline('.')[col - 1] !~ '\k'
				return "\<tab>"
			elseif "backward" == a:direction
				return "\<c-p>"
			else
				return "\<c-n>"
			endif
		endfunction

		inoremap <Tab> <c-r>=InsertTabWrapper ("forward")<cr>
		inoremap <S-Tab> <c-r>=InsertTabWrapper ("backward")<cr>
	endif
	if (v:version >= 700)
		function! CleverTab()
			if pumvisible()
				return "\<C-N>"
			endif
			if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
				return "\<Tab>"
			elseif exists('&omnifunc') && &omnifunc != ''
				return "\<C-X>\<C-O>"
			else
				return "\<C-N>"
			endif
		endfunction
		inoremap <Tab> <C-R>=CleverTab()<CR>
		inoremap <S-Tab> <C-P>

		" toggle tab completion
		function! ToggleCompletion()
			if mapcheck("\<tab>", "i") != ""
				:iunmap <tab>
			else
				inoremap <Tab> <C-R>=CleverTab()<CR>
			endif
		endfunction
		inoremap <F11> <C-O>:call ToggleCompletion()<CR>
	endif
endif
" }}}

" Save code, run ruby, show output in preview window {{{
"save code, run ruby, show output in preview window
function! Ruby_eval_vsplit() range
  let src = tempname()
  let dst = tempname()
  execute ": " . a:firstline . "," . a:lastline . "w " . src
  execute ":silent ! ruby " . src . " > " . dst . " 2>&1 "
  execute ":pclose!"
  execute ":redraw!"
  execute ":vsplit"
  execute "normal \<C-W>l"
  execute ":e! " . dst
  execute ":set pvw"
  execute "normal \<C-W>h"
  execute "normal \<C-W>w"
endfunction
vmap <silent> <F7> :call Ruby_eval_vsplit()<CR>
nmap <silent> <F7> mzggVG<F7>`z
imap <silent> <F7> <Esc><F7>a
map <silent> <S-F7> <C-W>l:bw<CR>
imap <silent> <S-F7> <Esc><S-F7>a
" }}}

" }}}
