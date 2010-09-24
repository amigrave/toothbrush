" vim:ft=vim:fdm=marker:nowrap:foldmethod=marker
scriptencoding utf-8

" ################################### OPTIONS ################################### {{{
set all&                " reset all options to compiled in defaults
"set fileencodings=ascii,ucs-bom,utf-8,ucs-2,ucs-le,latin1
set encoding=utf8
set fileencoding=utf8
set fileencodings=utf-8,latin1
set novb t_vb=            " no visual bell
set noerrorbells        " do not bell on error
set autoindent          " automatic indentation
set shiftwidth=4        " Number of spaces to use for each step of (auto)
set tabstop=4           " Number of spaces that a <Tab> in the file counts for
set textwidth=0         " Maximum width of text that is being inserted
set history=50          " expand command history
set hlsearch            " Highlight previous search pattern matches.
set ignorecase
"set hidden              " Unused buffers are hidden when abandonned
set backspace=2         " make backspace work like most other apps
set smartcase           " ignore case when the pattern contains lowercase letters only.
set nobackup            " do not write a .bak file
set nocompatible        " do not use vi compatible mode
set noexpandtab         " do not expand tab to spaces
set ruler               " Show the line and column number of the cursor position
set number              " precede each line with its line number
set showcmd             " Show (partial) command in the last line of the screen
set showmode            " If in Insert, Replace or Visual mode put a message on the last line
set viminfo='200,\"5000 nowrap
"set list listchars=tab:~.,trail:.,extends:>,precedes:<
if (&termencoding == "utf-8") || has("gui_running")
	set list listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:=
else
	set list listchars=tab:~.,trail:.,extends:>,precedes:<,nbsp:_
endif
filetype plugin on
if &t_Co == 256
	colorscheme wombat256mod
else
	colorscheme agr
endif
"}}}

" ################################### PLATFORM ################################## {{{
if has("unix")
	let $VIMFILES=$HOME . "/.vim"
else
	let $VIMFILES=$HOME . "\\vim"
endif
"if $TERM == "screen"
"	set term=rxvt
"endif
"}}}

" ############################ AUTOCMD & FILETYPES ############################## {{{
if has("autocmd")
	au BufEnter * cd %:p:h		"automatically change cwd to file's dir
	au BufEnter *
		\ if line("'\"") | exe "normal '\"" | endif |
		\ if match( getline(1) , '^\#!') == 0 |
			\ execute("let b:interpreter = getline(1)[2:]") |
			\ if getline(1) =~ '^#!.*python' | set filetype=python | endif |
			\ if getline(1) =~ '^#!.*ruby' | set filetype=ruby | endif |
			\ if getline(1) =~ '^#!.*bash' | set filetype=sh | endif |
			\ if getline(1) =~ '^<DOCTYPE' | set filetype=html | endif |
		\endif

	fun! CallInterpreter()
		if exists("b:interpreter")
			exec ("!".b:interpreter." %")
		endif
	endfun

	au BufRead *.txt,*.rst set expandtab " tw=78
	au BufRead,BufNewFile *.xml,*.xsl  set foldmethod=syntax foldcolumn=3 foldnestmax=2 foldlevel=2
	au BufRead,BufNewFile *.php,*.php3 set foldmethod=syntax foldcolumn=3 foldnestmax=2 foldlevel=2
	au BufRead,BufNewFile *.rb set fdm=syntax foldcolumn=0 foldnestmax=2 foldlevel=2
	au BufRead,BufNewFile *.aspx set syntax=cs
"	"au BufRead,BufNewFile *.asp set ft=javascript
	au BufRead,BufNewFile *.css,*.aspx,*.c,*.cpp,*.cs,*.java,*.js,*.asp syn region myFold start="{" end="}" transparent fold
							\ | syn sync fromstart | set foldmethod=syntax foldcolumn=3 foldnestmax=2 foldlevel=2
"	au BufRead,BufNewFile *.js,*.asp syn clear javaScriptBraces
	au BufReadPost *.js,*.css,*.asp set tabstop=4 shiftwidth=4 " override ftplugin tab=4

	au Filetype python syn match agrEq "[=]" | hi agrEq ctermfg=green guifg=green
	au Filetype python syn match agrSelf "self" | hi agrSelf ctermfg=gray guifg=gray

"	au Filetype ruby set foldmethod=syntax foldcolumn=0 foldnestmax=2 foldlevel=2

	if has("unix")
		au BufNewFile *.py set autoread | s,^,#!/usr/bin/python, | w | !chmod +x %
		au BufNewFile *.rb set autoread | s,^,#!/usr/bin/ruby, | w | !chmod +x %
		au BufNewFile *.sh set autoread | s,^,#!/bin/bash, | w | !chmod +x %
	endif

	au Filetype xml call XmlQweb()

	let php_sync_method=0
	let php_folding=1
	let php_asp_tags = 1
	let g:xml_syntax_folding=1
	let python_highlight_numbers = 1

endif
"}}}

"" ################################### KEYMAPS ################################### {{{
" Broken terminals. Rxvt.
if (&term =~ "xterm") || (&term =~ "vt100")
	set t_kP=[5~ t_kN=[6~ t_kh=[1~ t_@7=[4~
endif

" Fixed scrolling
noremap <C-Down> <C-E><Down>
inoremap <C-Down> <C-O><C-E><Down>
noremap Ob <C-E><Down>
inoremap Ob <C-O><C-E><Down>
noremap <C-Up> <C-Y><Up>
inoremap <C-Up> <C-O><C-Y><Up>
noremap Oa <C-Y><Up>
inoremap Oa <C-O><C-Y><Up>

" Move by words
noremap <C-Left> b
inoremap <C-Left> <C-O>b
noremap Od b
inoremap Od <C-O>b
noremap <C-Right> w
inoremap <C-Right> <C-O>w
noremap Oc w
inoremap Oc <C-O>w

" Editing
vmap <C-R> "_dP

" Tab navigation like firefox
nmap <C-S-tab> :tabprevious<CR>
nmap <C-tab> :tabnext<CR>
map <C-S-tab> :tabprevious<CR>
map <C-tab> :tabnext<CR>
imap <C-S-tab> <Esc>:tabprevious<CR>i
imap <C-tab> <Esc>:tabnext<CR>i
nmap <C-t> :tabnew<CR>
imap <C-t> <Esc>:tabnew<CR>
command! -nargs=* -complete=file E if expand('%')=='' && line('$')==1 && getline(1)=='' | :edit <args> | else | :tabnew <args> | endif
cabbrev e <c-R>=(getcmdtype()==':' && getcmdpos()==1 ? 'E' : 'e')<cr>
nnoremap <silent> <F2> :tabprevious<CR>
inoremap <silent> <F2> <C-O>:tabprevious<CR>
nnoremap <silent> <F3> :tabnext<CR>
inoremap <silent> <F3> <C-O>:tabnext<CR>

" Same for buffers
nnoremap <silent> <S-F2> :bp<CR>
inoremap <silent> <S-F2> <C-O>:bp<CR>
nnoremap <silent> <S-F3> :bn<CR>
inoremap <silent> <S-F3> <C-O>:bn<CR>

" Folding
nnoremap <silent> <F4> zc
inoremap <silent> <F4> <C-O>zc
nnoremap <silent> <F5> zm
inoremap <silent> <F5> <C-O>zm
nnoremap <silent> <F6> zi
inoremap <silent> <F6> <C-O>zi

" Disable <S-Down>
noremap <S-Down> <Nop>
inoremap <S-Down> <Nop>

" Taglist
nnoremap <silent> <F7> :TlistToggle<CR><C-w>h
inoremap <silent> <F7> <C-O>:TlistToggle<CR><C-w>h

nnoremap <silent> <F8> :w<CR>:call CallInterpreter()<CR>
inoremap <silent> <F8> <C-O>:w<CR><C-O>:call CallInterpreter()<CR>

" Quit
nnoremap <silent> <F10> :bde<CR>
inoremap <silent> <F10> <C-O>:bde<CR>

set pastetoggle=<F12>

vnoremap <Tab> >
vnoremap <S-Tab> <LT>

"inoremap {{ {
"imap %% <%%><left><left>
"imap %%<cr> <%<cr>%><esc>O<Tab>
"inoremap {<cr> {<cr>}<esc>O<Tab>
"inoremap {{ {{   }}<left><left><left><left>
"inoremap [ []<left>
"inoremap ( ()<left>


map <A-i> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") ."> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"" }}}

"" ################################### ADDONS #################################### {{{
" Xml QWeb {{{
function! XmlQweb()
	syn match   xmlAttribQWeb
		\ +[-'"<]\@<!\<t-[a-zA-Z:_][-.0-9a-zA-Z0-9:_]*\>\(['">]\@!\|$\)+
		\ contained
		\ contains=xmlAttribPunct,@xmlAttribHook
		\ display

	syn cluster xmlAttribHook contains=xmlAttribQWeb
	hi link xmlAttribQWeb     xmlAttribQWeb
endfunction
" }}}
"" }}}
