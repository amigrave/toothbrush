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

"Find a way to do this only for php files :
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
	au BufRead,BufNewFile *.asp set ft=javascript
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

	" Javascript Snippets
	autocmd BufRead,BufNewFile * inorea <buffer> jscript <c-r>=IMAP_PutTextWithMovement("<script type=\"text/javascript\">\n&lt;!--\n<++>\n--&gt;\n</script>")<cr>
	autocmd BufRead,BufNewFile * inorea <buffer> jready <c-r>=IMAP_PutTextWithMovement("$(document).ready(function() {\n<++>\n});")<cr>
	autocmd BufRead,BufNewFile * inorea <buffer> jsb <c-r>=IMAP_PutTextWithMovement("<++>(function(<++>) {\n<++>\n});")<cr>
	autocmd BufRead,BufNewFile * inorea <buffer> jsq <c-r>=IMAP_PutTextWithMovement("$(\"<++>\").<++>(function(<++>) {\n<++>\n});")<cr>
	autocmd BufRead,BufNewFile * inorea <buffer> jsfun <c-r>=IMAP_PutTextWithMovement("function <++>(<++>) {\n<++>;\nreturn <++>;\n}")<cr>
	autocmd BufRead,BufNewFile * inorea <buffer> jsfuno <c-r>=IMAP_PutTextWithMovement("<++> : function(<++>) {\n<++>\n},")<cr>
	autocmd BufRead,BufNewFile * inorea <buffer> jsfunq <c-r>=IMAP_PutTextWithMovement("<++> : function(req, v) {\n<++>\n},")<cr>
	autocmd BufRead,BufNewFile * inorea <buffer> jsfor <c-r>=IMAP_PutTextWithMovement("for (<++>; <++>; <++>) {\n<++>;\n}")<cr>
	autocmd BufRead,BufNewFile * inorea <buffer> jsif <c-r>=IMAP_PutTextWithMovement("if (<++>) {\n<++>;\n}")<cr>
	autocmd BufRead,BufNewFile * inorea <buffer> jselse <c-r>=IMAP_PutTextWithMovement("if (<++>) {\n<++>;\n}\nelse {\n<++>;\n}")<cr>

	"au Filetype html,xml,xsl call InitXmlTag()
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
nnoremap <silent> <F6> zr
inoremap <silent> <F6> <C-O>zr
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

inoremap {<cr> {<cr>}<esc>O<Tab>
"inoremap {{ {
inoremap %% <%%><left><left>
inoremap %%<cr> <%<cr>%><esc>O<Tab>
inoremap { {}<left>
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

" Python folding {{{
" Author:	Jorrit Wiersma (foldexpr), Max Ischenko (foldtext), Robert
" Version:	2.3
function! PythonFoldText()
  let line = getline(v:foldstart)
  let nnum = nextnonblank(v:foldstart + 1)
  let nextline = getline(nnum)
  if nextline =~ '^\s\+"""$'
    let line = line . getline(nnum + 1)
  elseif nextline =~ '^\s\+"""'
    let line = line . ' ' . matchstr(nextline, '"""\zs.\{-}\ze\("""\)\?$')
  elseif nextline =~ '^\s\+"[^"]\+"$'
    let line = line . ' ' . matchstr(nextline, '"\zs.*\ze"')
  elseif nextline =~ '^\s\+pass\s*$'
    let line = line . ' pass'
  endif
  let size = 1 + v:foldend - v:foldstart
  if size < 10
    let size = " " . size
  endif
  if size < 100
    let size = " " . size
  endif
  if size < 1000
    let size = " " . size
  endif
  return size . " lines: " . line
endfunction


function! GetPythonFold(lnum)
    " Determine folding level in Python source
    "
    let line = getline(a:lnum)
    let ind  = indent(a:lnum)

    " Ignore blank lines
    if line =~ '^\s*$'
	return "="
    endif

    " Ignore triple quoted strings
    if line =~ "(\"\"\"|''')"
	return "="
    endif

    " Ignore continuation lines
    if line =~ '\\$'
	return '='
    endif

    " Support markers
    if line =~ '{{{'
	return "a1"
    elseif line =~ '}}}'
	return "s1"
    endif

    " Classes and functions get their own folds
    if line =~ '^\s*\(class\|def\)\s'
	return ">" . (ind / &sw + 1)
    endif

    let pnum = prevnonblank(a:lnum - 1)

    if pnum == 0
	" Hit start of file
	return 0
    endif

    " If the previous line has foldlevel zero, and we haven't increased
    " it, we should have foldlevel zero also
    if foldlevel(pnum) == 0
	return 0
    endif

    " The end of a fold is determined through a difference in indentation
    " between this line and the next.
    " So first look for next line
    let nnum = nextnonblank(a:lnum + 1)
    if nnum == 0
	return "="
    endif

    " First I check for some common cases where this algorithm would
    " otherwise fail. (This is all a hack)
    let nline = getline(nnum)
    if nline =~ '^\s*\(except\|else\|elif\)'
	return "="
    endif

    " Python programmers love their readable code, so they're usually
    " going to have blank lines at the ends of functions or classes
    " If the next line isn't blank, we probably don't need to end a fold
    if nnum == a:lnum + 1
	return "="
    endif

    " If next line has less indentation we end a fold.
    " This ends folds that aren't there a lot of the time, and this sometimes
    " confuses vim.  Luckily only rarely.
    let nind = indent(nnum)
    if nind < ind
	return "<" . (nind / &sw + 1)
    endif

    " If none of the above apply, keep the indentation
    return "="

endfunction

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

" XML Tag completion {{{
if !exists("*s:WrapTag") 
function s:WrapTag(text)
    if (line(".") < line("'<"))
	let insert_cmd = "o"
    elseif (col(".") < col("'<"))
	let insert_cmd = "a"
    else
	let insert_cmd = "i"
    endif
    if strlen(a:text) > 10
	let input_text = strpart(a:text, 0, 10) . '...'
    else
	let input_text = a:text
    endif
    let wraptag = inputdialog('Tag to wrap "' . input_text . '" : ')
    if strlen(wraptag)==0
	if strlen(b:last_wrap_tag_used)==0
	    undo
	    return
	endif
	let wraptag = b:last_wrap_tag_used
	let atts = b:last_wrap_atts_used
    else
	let atts = inputdialog('Attributes in <' . wraptag . '> : ')
    endif
    if (visualmode() ==# 'V')
	let text = strpart(a:text,0,strlen(a:text)-1)
	if (insert_cmd ==# "o")
	    let eol_cmd = ""
	else
	    let eol_cmd = "\<Cr>"
	endif
    else
	let text = a:text
	let eol_cmd = ""
    endif
    if strlen(atts)==0
	let text = "<".wraptag.">".text."</".wraptag.">"
	let b:last_wrap_tag_used = wraptag
	let b:last_wrap_atts_used = ""
    else
	let text = "<".wraptag." ".atts.">".text."</".wraptag.">"
	let b:last_wrap_tag_used = wraptag
	let b:last_wrap_atts_used = atts
    endif
    execute "normal! ".insert_cmd.text.eol_cmd
endfunction
endif

if !exists("*s:NewFileXML")
function s:NewFileXML( )
    if &filetype == 'xml' || (!exists ("g:did_xhtmlcf_inits") && exists ("g:xml_use_xhtml") && (&filetype == 'html' || &filetype == 'xhtml'))
	if append (0, '<?xml version="1.0"?>')
	    normal! G
	endif
    endif
endfunction
endif

if !exists("*s:Callback")
function s:Callback( xml_tag, isHtml )
    let text = 0
    if a:isHtml == 1 && exists ("*HtmlAttribCallback")
	let text = HtmlAttribCallback (a:xml_tag)
    elseif exists ("*XmlAttribCallback")
	let text = XmlAttribCallback (a:xml_tag)
    endif	
    if text != '0'
	execute "normal! i " . text ."\<Esc>l"
    endif
endfunction
endif

if !exists("*s:IsParsableTag")
function s:IsParsableTag( tag )
    let parse = 1

    if a:tag !~ '^<[[:alnum:]_:\-].*>$'
	let parse = 0
    endif

    if strpart (a:tag, strlen (a:tag) - 2, 1) == '/'
	let parse = 0
    endif
    
    return parse
endfunction
endif

if !exists("*s:ParseTag")
function s:ParseTag( )
    let old_reg_save = @"
    let old_save_x   = @x

    if (!exists("g:xml_no_auto_nesting") && strpart (getline ("."), col (".") - 2, 2) == '>>')
	let multi_line = 1
	execute "normal! \"xX"
    else
	let multi_line = 0
    endif

    let @" = ""
    execute "normal! \"xy%%"
    let ltag = @"
    if (&filetype == 'html' || &filetype == 'xhtml') && (!exists ("g:xml_no_html"))
	let html_mode = 1
	let ltag = substitute (ltag, '[^[:graph:]]\+', ' ', 'g')
	let ltag = substitute (ltag, '<\s*\([^[:alnum:]_:\-[:blank:]]\=\)\s*\([[:alnum:]_:\-]\+\)\>', '<\1\2', '')
    else
	let html_mode = 0
    endif

    if <SID>IsParsableTag (ltag)
	let index = 1
	while index < strlen (ltag) && strpart (ltag, index, 1) =~ '[[:alnum:]_:\-]'
	    let index = index + 1
	endwhile

	let tag_name = strpart (ltag, 1, index - 1)
	if strpart (ltag, index) =~ '[^/>[:blank:]]'
	    let has_attrib = 1
	else
	    let has_attrib = 0
	endif

	let index = index + 2

	if html_mode && tag_name =~? '^\(img\|input\|param\|frame\|br\|hr\|meta\|link\|base\|area\)$'
	    if has_attrib == 0
		call <SID>Callback (tag_name, html_mode)
	    endif
	    if exists ("g:xml_use_xhtml")
		execute "normal! i /\<Esc>l"
	    endif
	else
	    if multi_line
		let com_save = &comments
		set comments-=n:>
		execute "normal! a\<Cr>\<Cr>\<Esc>kAx\<Esc>>>$\"xx"
		execute "set comments=" . com_save

		let @" = old_reg_save
		let @x = old_save_x

		startinsert!
		return ""
	    else
		if has_attrib == 0
		    call <SID>Callback (tag_name, html_mode)
		endif
		execute "normal! a</" . tag_name . ">\<Esc>" . index . "h"
	    endif
	endif
    endif

    let @" = old_reg_save
    let @x = old_save_x

    if col (".") < strlen (getline ("."))
	execute "normal! l"
	startinsert
    else
	startinsert!
    endif
endfunction
endif

if !exists("*s:BuildTagName")
function s:BuildTagName( )
  let b:xreg = @x 

  exec "normal! v\"xy"
  if @x=='>'
     " Don't do anything
  else
     exec "normal! />/\<Cr>"
  endif

  exec "normal! ?<?\<Cr>"

  exec "normal! v/\\s\\|$/\<Cr>\"xy"

  let @x=strpart(@x, 0, match(@x, "[[:blank:]>\<C-J>]"))

  let @x=substitute(@x,'^<\|>$','','')

  let @x=substitute(@x,'/\s*','/', '')
  let @x=substitute(@x,'^\s*','', '')

  let temp = @x
  let @x = b:xreg
  let b:xreg = temp
endfunction
endif

if !exists("*s:TagMatch1")
function s:TagMatch1()
  let old_reg_save = @"

  normal! mz

  call <SID>BuildTagName()

  if match(b:xreg, '^/')==-1
    let endtag = 0
  else
    let endtag = 1  
  endif

 let b:xreg=substitute(b:xreg,'^/','','g')

 if match(b:xreg,'^[[:alnum:]_:\-]') != -1
     call <SID>TagMatch2(b:xreg, endtag)
 endif
 let @" = old_reg_save
endfunction
endif


if !exists("*s:TagMatch2")
function s:TagMatch2(tag,endtag)
  let match_type=''

  if a:endtag==0
     let match_type = '/'
  else
     let match_type = '?'
  endif

  if a:endtag==0
     let stk = 1 
  else
     let stk = 1
  end

 let wrapval = &wrapscan
 let &wrapscan = 1

  let lpos = line(".")
  let cpos = col(".")

  if a:endtag==0
      let iter = 1
  else
      let iter = -1
  endif

  while 1 
     exec "normal! " . match_type . '<\s*\/*\s*' . a:tag . '\([[:blank:]>]\|$\)' . "\<Cr>"

     if a:endtag == 0
	 if line(".") < lpos
	     call <SID>MisMatchedTag (0, a:tag)
	     break
	 elseif line(".") == lpos && col(".") <= cpos
	     call <SID>MisMatchedTag (1, a:tag)
	     break
	 endif
     else
	 if line(".") > lpos
	     call <SID>MisMatchedTag (2, '/'.a:tag)
	     break
	 elseif line(".") == lpos && col(".") >= cpos
	     call <SID>MisMatchedTag (3, '/'.a:tag)
	     break
	 endif
     endif

     call <SID>BuildTagName()

     if match(b:xreg,'^/')==-1
	let stk = stk + iter 
     else
	let stk = stk - iter
     endif

     if stk == 0
	break
     endif    
  endwhile

  let &wrapscan = wrapval
endfunction
endif

if !exists("*s:MisMatchedTag")
function s:MisMatchedTag( id, tag )
    normal! `z
    normal zz
    echohl WarningMsg
    echo "Mismatched tag <" . a:tag . ">"
    echohl None
endfunction
endif

if !exists("*s:DeleteTag")
function s:DeleteTag( )
    if strpart (getline ("."), col (".") - 1, 1) == "<"
	normal! l
    endif
    if search ("<[^\/]", "bW") == 0
	return
    endif
    normal! mz
    normal \5
    normal! d%`zd%
endfunction
endif

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

function InitXmlTag( )
	setlocal matchpairs+=<:>

	if !exists("g:xml_tag_completion_map")
		inoremap <buffer> <Leader>. >
		inoremap <buffer> <Leader>> >
	endif

	nnoremap <buffer> <Leader>5 :call <SID>TagMatch1()<Cr>
	nnoremap <buffer> <Leader>% :call <SID>TagMatch1()<Cr>

	vnoremap <buffer> <Leader>x "xx:call <SID>WrapTag(@x)<Cr>
	nnoremap <buffer> <Leader>d :call <SID>DeleteTag()<Cr>

	if !exists("g:xml_tag_completion_map")
		inoremap <buffer> > ><Esc>:call <SID>ParseTag()<Cr>
	else
		execute "inoremap <buffer> " . g:xml_tag_completion_map . " ><Esc>:call <SID>ParseTag()<Cr>"
	endif

	augroup xml
		au!
		au BufNewFile * call <SID>NewFileXML()
	augroup END
endfunction
" }}}

" Imaps template expander {{{
let s:save_cpo = &cpo
set cpo&vim
if !exists('g:Imap_StickyPlaceHolders')
	let g:Imap_StickyPlaceHolders = 1
endif
if !exists('g:Imap_DeleteEmptyPlaceHolders')
	let g:Imap_DeleteEmptyPlaceHolders = 1
endif
function! IMAP_PutTextWithMovement(str, ...)
	if a:0 < 2
		let phs = '<+'
		let phe = '+>'
	else
		let phs = escape(a:1, '\')
		let phe = escape(a:2, '\')
	endif

	let text = a:str

	let phsUser = IMAP_GetPlaceHolderStart()
	let pheUser = IMAP_GetPlaceHolderEnd()

	let phsEnc     = s:Iconv(phs, "encode")
	let pheEnc     = s:Iconv(phe, "encode")
	let phsUserEnc = s:Iconv(phsUser, "encode")
	let pheUserEnc = s:Iconv(pheUser, "encode")
	let textEnc    = s:Iconv(text, "encode")
	if textEnc != text
		let textEncoded = 1
	else
		let textEncoded = 0
	endif

	let pattern = '\V\(\.\{-}\)' .phs. '\(\.\{-}\)' .phe. '\(\.\*\)'
	if textEnc !~ pattern
		return text
	endif
	let initialEnc  = substitute(textEnc, pattern, '\1', '')
	let templateEnc = substitute(textEnc, pattern, '\2', '')
	let finalEnc    = substitute(textEnc, pattern, '\3', '')

	if exists('g:Imap_UsePlaceHolders') && !g:Imap_UsePlaceHolders
		let finalEnc = substitute(finalEnc, '\V'.phs.'\.\{-}'.phe, '', 'g')
	else
		let finalEnc = substitute(finalEnc, '\V'.phs.'\(\.\{-}\)'.phe,
					\ phsUserEnc.'\1'.pheUserEnc, 'g')
	endif

	if textEncoded
		let initial = s:Iconv(initialEnc, "decode")
		let template = s:Iconv(templateEnc, "decode")
		let final = s:Iconv(finalEnc, "decode")
	else
		let initial = initialEnc
		let template = templateEnc
		let final = finalEnc
	endif

	let template = phsUser . template . pheUser
	let text = initial . "X\<C-\>\<C-N>:call IMAP_Mark('set')\<CR>\"_s"
	let text = text . template . final
	let text = text . "\<C-\>\<C-N>:call IMAP_Mark('go')\<CR>"
	let text = text . "i\<C-r>=IMAP_Jumpfunc('', 1)\<CR>"

	return text
endfunction

function! IMAP_Jumpfunc(direction, inclusive)
	let phsUser = IMAP_GetPlaceHolderStart()
	let pheUser = IMAP_GetPlaceHolderEnd()

	let searchString = ''
	if !a:inclusive || strpart(getline('.'), col('.')-1) !~ '\V\^'.phsUser
		let searchString = '\V'.phsUser.'\_.\{-}'.pheUser
	endif

	if searchString != '' && !search(searchString, a:direction)
		return ''
	endif

	silent! foldopen!

	let template = 
		\ matchstr(strpart(getline('.'), col('.')-1),
		\          '\V\^'.phsUser.'\zs\.\{-}\ze\('.pheUser.'\|\$\)')
	let placeHolderEmpty = !strlen(template)

	let extramove = ''
	if &selection == 'exclusive'
		let extramove = 'l'
	endif

	let movement = "\<C-o>v/\\V".pheUser."/e\<CR>".extramove

	let g:Tex_LastSearchPattern = @/

	if placeHolderEmpty && g:Imap_DeleteEmptyPlaceHolders
		return movement."\"_c\<C-o>:".s:RemoveLastHistoryItem."\<CR>"
	else
		return movement."\<C-\>\<C-N>:".s:RemoveLastHistoryItem."\<CR>gv\<C-g>"
	endif
endfunction

" jumping forward and back in insert mode.
imap <silent> <Plug>IMAP_JumpForward    <c-r>=IMAP_Jumpfunc('', 0)<CR>
imap <silent> <Plug>IMAP_JumpBack       <c-r>=IMAP_Jumpfunc('b', 0)<CR>

" jumping in normal mode
nmap <silent> <Plug>IMAP_JumpForward        i<c-r>=IMAP_Jumpfunc('', 0)<CR>
nmap <silent> <Plug>IMAP_JumpBack           i<c-r>=IMAP_Jumpfunc('b', 0)<CR>

" deleting the present selection and then jumping forward.
vmap <silent> <Plug>IMAP_DeleteAndJumpForward       "_<Del>i<c-r>=IMAP_Jumpfunc('', 0)<CR>
vmap <silent> <Plug>IMAP_DeleteAndJumpBack          "_<Del>i<c-r>=IMAP_Jumpfunc('b', 0)<CR>

" jumping forward without deleting present selection.
vmap <silent> <Plug>IMAP_JumpForward       <C-\><C-N>i<c-r>=IMAP_Jumpfunc('', 0)<CR>
vmap <silent> <Plug>IMAP_JumpBack          <C-\><C-N>`<i<c-r>=IMAP_Jumpfunc('b', 0)<CR>

if !hasmapto('<Plug>IMAP_JumpForward', 'i')
    imap <C-J> <Plug>IMAP_JumpForward
endif
if !hasmapto('<Plug>IMAP_JumpForward', 'n')
    nmap <C-J> <Plug>IMAP_JumpForward
endif
if exists('g:Imap_StickyPlaceHolders') && g:Imap_StickyPlaceHolders
	if !hasmapto('<Plug>IMAP_JumpForward', 'v')
		vmap <C-J> <Plug>IMAP_JumpForward
	endif
else
	if !hasmapto('<Plug>IMAP_DeleteAndJumpForward', 'v')
		vmap <C-J> <Plug>IMAP_DeleteAndJumpForward
	endif
endif
" }

nmap <silent> <script> <plug><+SelectRegion+> `<v`>

fun! <SID>Strntok(s, tok, n)
	return matchstr( a:s.a:tok[0], '\v(\zs([^'.a:tok.']*)\ze['.a:tok.']){'.a:n.'}')
endfun

let s:RemoveLastHistoryItem = ':call histdel("/", -1)|let @/=g:Tex_LastSearchPattern'

fun! s:Hash(text)
	return substitute(a:text, '\([^[:alnum:]]\)',
				\ '\="_".char2nr(submatch(1))."_"', 'g')
endfun
function! IMAP_GetPlaceHolderStart()
	if exists("b:Imap_PlaceHolderStart") && strlen(b:Imap_PlaceHolderEnd)
		return b:Imap_PlaceHolderStart
	elseif exists("g:Imap_PlaceHolderStart") && strlen(g:Imap_PlaceHolderEnd)
		return g:Imap_PlaceHolderStart
	else
		return "<+"
endfun
function! IMAP_GetPlaceHolderEnd()
	if exists("b:Imap_PlaceHolderEnd") && strlen(b:Imap_PlaceHolderEnd)
		return b:Imap_PlaceHolderEnd
	elseif exists("g:Imap_PlaceHolderEnd") && strlen(g:Imap_PlaceHolderEnd)
		return g:Imap_PlaceHolderEnd
	else
		return "+>"
endfun
function! s:Iconv(text, mode)
	if a:mode == "decode"
		return iconv(a:text, "utf8", "latin1")
	endif
	if a:text =~ '\V\^' . escape(a:text, '\') . '\$'
		return a:text
	endif
	let textEnc = iconv(a:text, "latin1", "utf8")
	return textEnc
endfun
let s:Mark = "(0,0)"
let s:initBlanks = ''
function! IMAP_Mark(action)
	if a:action == 'set'
		let s:Mark = "(" . line(".") . "," . col(".") . ")"
		let s:initBlanks = matchstr(getline('.'), '^\s*')
	elseif a:action == 'go'
		execute "call cursor" s:Mark
		let blanksNow = matchstr(getline('.'), '^\s*')
		if strlen(blanksNow) > strlen(s:initBlanks)
			execute 'silent! normal! '.(strlen(blanksNow) - strlen(s:initBlanks)).'l'
		elseif strlen(blanksNow) < strlen(s:initBlanks)
			execute 'silent! normal! '.(strlen(s:initBlanks) - strlen(blanksNow)).'h'
		endif
	endif
endfunction

let &cpo = s:save_cpo
" }}}
" }}}
