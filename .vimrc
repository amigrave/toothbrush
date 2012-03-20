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
set shiftwidth=4        " Number of spaces to use for each step of (auto)
set tabstop=4           " Number of spaces that a <Tab> in the file counts for
set softtabstop=4
set textwidth=0         " Maximum width of text that is being inserted
set history=50          " expand command history
set hlsearch            " Highlight previous search pattern matches.
set incsearch           " Use incremental search
"set hidden              " Unused buffers are hidden when abandonned
set backspace=2         " make backspace work like most other apps
set smartcase           " ignore case when the pattern contains lowercase letters only.
set nobackup            " do not write a .bak file
set nocompatible        " do not use vi compatible mode
"set autoindent          " automatic indentation
set smartindent
"set noexpandtab         " do not expand tab to spaces
set expandtab           " expand tab to spaces
set ruler               " Show the line and column number of the cursor position
set number              " precede each line with its line number
set showcmd             " Show (partial) command in the last line of the screen
set showmode            " If in Insert, Replace or Visual mode put a message on the last line
set viminfo='200,\"5000 nowrap
"set list listchars=tab:~.,trail:.,extends:>,precedes:<
set list listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:=
let mapleader = "²"
filetype plugin on
if &t_Co == 256 && !has('win32unix')
	colorscheme wombat256mod
else
	colorscheme agr
endif
if has("gui_macvim")
    set vb
endif
"}}}

" ################################### PLATFORM ################################## {{{
syntax on
if has("unix")
	let $VIMFILES=$HOME . "/.vim"
else
	let $VIMFILES=$HOME . "\\vim"
endif
"if $TERM == "screen"
"	set term=rxvt
"endif
if &term =~ "screen\\|rxvt"
"	"Set the cursor white in cmd-mode and orange in insert mode
"	let &t_EI = "\<Esc>]12;white\x9c"
"	let &t_SI = "\<Esc>]12;orange\x9c"
"	"We normally start in cmd-mode
"	silent !echo -e "\e]12;white\x9c"
endif
"}}}

" ############################ AUTOCMD & FILETYPES ############################## {{{
if has("autocmd")
    "\ if line("'\"") | exe "normal '\"" | endif |
    au BufEnter * silent! lcd %:p:h    "automatically change cwd to file's dir
    au BufRead *
        \ if line("'\"") | exe "normal '\"" | endif |
        \ if match( getline(1) , '^\#!') == 0 |
            \ execute("let b:interpreter = getline(1)[2:]") |
            \ if getline(1) =~ '^#!.*python' | set filetype=python | endif |
            \ if getline(1) =~ '^#!.*ruby' | set filetype=ruby | endif |
            \ if getline(1) =~ '^#!.*bash' | set filetype=sh | endif |
            \ if getline(1) =~ '^<DOCTYPE' | set filetype=html | endif |
        \endif

    au BufRead *.txt,*.rst set expandtab tw=78
    au BufRead,BufNewFile *.xml,*.xsl  set foldmethod=syntax foldcolumn=3 foldnestmax=2 foldlevel=2
    au BufRead,BufNewFile *.php,*.php3 set foldmethod=syntax foldcolumn=3 foldnestmax=2 foldlevel=2
    au BufRead,BufNewFile *.rb set fdm=syntax foldcolumn=0 foldnestmax=2 foldlevel=2
    au BufRead,BufNewFile *.aspx set syntax=cs
    au BufRead,BufNewFile *.mako set ft=html
    au BufRead,BufNewFile *.asp set ft=javascript
    au BufRead,BufNewFile *.coffee set fdm=indent
    au BufWritePost,FileWritePost *.coffee :!coffee -c -b <afile>
    au BufWritePost,FileWritePost *.sass :!sass --style expanded <afile> > "%:p:r.css"
    au BufWritePost,FileWritePost *.md,*.mkd :!markdown "<afile>" > "%:p:r.html"

    au BufRead,BufNewFile *.css,*.aspx,*.c,*.cpp,*.cs,*.java,*.js,*.json,*.asp syn region myFold start="{" end="}" transparent fold |
        \ syn sync fromstart | set foldmethod=syntax foldcolumn=3 foldnestmax=3 foldlevel=2
    au BufRead,BufNewFile *.js,*.asp,*.json syn clear javaScriptBraces

    " au BufReadPost *.js,*.css,*.asp set tabstop=4 shiftwidth=4 " override ftplugin tab=4

    au Filetype python syn match agrEq "[=]" | hi agrEq ctermfg=green guifg=green
    au Filetype python syn match agrSelf "self" | hi agrSelf ctermfg=gray guifg=gray

    " au Filetype ruby set foldmethod=syntax foldcolumn=0 foldnestmax=2 foldlevel=2

    " Don't screw up folds when inserting text that might affect them, until
    " leaving insert mode. Foldmethod is local to the window. Protect against
    " screwing up folding when switching between windows.
    au InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
    au InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

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
    let coffee_folding = 1

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
noremap [1;5B <C-E><Down>
inoremap [1;5B <C-O><C-E><Down>
noremap <C-Up> <C-Y><Up>
inoremap <C-Up> <C-O><C-Y><Up>
noremap Oa <C-Y><Up>
inoremap Oa <C-O><C-Y><Up>
noremap [1;5A <C-E><Up>
inoremap [1;5A <C-O><C-E><Up>

noremap <S-MouseUp> <C-E><Down>
noremap <S-MouseDown> <C-Y><Up>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Editing
vmap <C-R> "_dP
vmap <C-Insert> "_d"+P
imap <C-Insert> <C-O>"+gP
vmap <Backspace> "_d

nmap <C-t> :tabnew<CR>
imap <C-t> <Esc>:tabnew<CR>
command! -nargs=* -complete=file E if expand('%')=='' && line('$')==1 && getline(1)=='' | :edit <args> | else | :tabnew <args> | endif
cabbrev e <c-R>=(getcmdtype()==':' && getcmdpos()==1 ? 'E' : 'e')<cr>
nnoremap <silent> <F2> :tabprevious<CR>
inoremap <silent> <F2> <C-O>:tabprevious<CR>
nnoremap <silent> <F3> :tabnext<CR>
inoremap <silent> <F3> <C-O>:tabnext<CR>
inoremap <Leader>= <C-O>yiW<End>=<C-R>=<C-R>0<CR>

" Same for buffers
nnoremap <silent> <S-F2> :bp<CR>
inoremap <silent> <S-F2> <C-O>:bp<CR>
nnoremap <silent> <S-F3> :bn<CR>
inoremap <silent> <S-F3> <C-O>:bn<CR>

" Folding
nnoremap <silent> <S-Up> zc
inoremap <silent> <S-Up> <C-O>zc
noremap [a zc
inoremap [a <C-O>zc
noremap [1;5B zc
inoremap [1;5B <C-O>zc
nnoremap <silent> <F4> zi
inoremap <silent> <F4> <C-O>zi
nnoremap <silent> <F5> zm
inoremap <silent> <F5> <C-O>zm

" Disable <S-Down>
noremap <S-Down> <Nop>
inoremap <S-Down> <Nop>

" Taglist
nnoremap <silent> <F7> :TlistToggle<CR><C-w>h
inoremap <silent> <F7> <C-O>:TlistToggle<CR><C-w>h

" Find File plugin
nmap <C-S-F> :FC .<CR>
nmap <C-F> :FF<CR>

" F8 & Shift-F8 mapped in pydebug addon


" Quit
nnoremap <silent> <F10> :bde<CR>
inoremap <silent> <F10> <C-O>:bde<CR>

set pastetoggle=<F12>
nnoremap <F11> :nohlsearch<CR>
inoremap <F11> <C-O>:nohlsearch<CR>

vnoremap <Tab> >
vnoremap <S-Tab> <LT>

"inoremap {{ {
"imap %% <%%><left><left>
"imap %%<cr> <%<cr>%><esc>O<Tab>
"inoremap {<cr> {<cr>}<esc>O<Tab>
"inoremap {{ {{   }}<left><left><left><left>
"inoremap [ []<left>
"inoremap ( ()<left>

" lhs comments
map ,# :s/^/#/<CR>:nohl<CR>
map ,/ :s/^/\/\//<CR>:nohl<CR>
map ,> :s/^/> /<CR>:nohl<CR>
map ," :s/^/\"/<CR>:nohl<CR>
map ,% :s/^/%/<CR>:nohl<CR>
map ,! :s/^/!/<CR>:nohl<CR>
map ,; :s/^/;/<CR>:nohl<CR>
map ,- :s/^/--/<CR>:nohl<CR>
map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohl<CR>

" wrapping comments
map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR>:nohl<CR>
map ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR>:nohl<CR>
map ,< :s/^\(.*\)$/<!-- \1 -->/<CR>:nohl<CR>
map ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>:nohl<CR>

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
    hi xmlAttribQWeb guifg=#f0a040 ctermfg=DarkMagenta
    hi xmlAttribQWebTrad guifg=#ffffff ctermfg=white
endfunction
" }}}
" Python Debug {{{
" Author: Nick Anderson <nick at anders0n.net>
" Website: http://www.cmdln.org
" Adapted from sonteks post on Vim as Python IDE
" http://blog.sontek.net/2008/05/11/python-with-a-modular-ide-vim/

if has('python')
python << EOF
import vim
def SetBreakpoint():
    import re
    nLine = int( vim.eval( 'line(".")'))

    strLine = vim.current.line
    strWhite = re.search( '^(\s*)', strLine).group(1)

    vim.current.buffer.append(
       "%(space)sfrom pudb import set_trace;set_trace() %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)

vim.command( 'map <f8> :py SetBreakpoint()<cr>')

def RemoveBreakpoints():
    import re

    nCurrentLine = int( vim.eval( 'line(".")'))

    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine.lstrip()[:38] == 'from ipdb import set_trace;set_trace()':
            nLines.append( nLine)
            print nLine
        nLine += 1

    nLines.reverse()

    for nLine in nLines:
        vim.command( 'normal %dG' % nLine)
        vim.command( 'normal dd')
        if nLine < nCurrentLine:
            nCurrentLine -= 1

    vim.command( 'normal %dG' % nCurrentLine)

vim.command( 'map <s-f8> :py RemoveBreakpoints()<cr>')
EOF
endif
" }}}
