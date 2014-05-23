" vim:ft=vim:fdm=marker:nowrap
scriptencoding utf-8
call pathogen#infect()

" ################################### OPTIONS ################################### {{{
"set all&                " reset all options to compiled in defaults
"set fileencodings=ascii,ucs-bom,utf-8,ucs-2,ucs-le,latin1
set encoding=utf8
set fileencoding=utf8
set fileencodings=utf-8,latin1
set visualbell
set t_vb=
set noerrorbells        " do not bell on error
set shiftwidth=4        " Number of spaces to use for each step of (auto)
set tabstop=4           " Number of spaces that a <Tab> in the file counts for
set softtabstop=4
set textwidth=0         " Maximum width of text that is being inserted
set history=50          " expand command history
set hlsearch            " Highlight previous search pattern matches.
set incsearch           " Use incremental search
set scrolloff=5         " minimum number of screen lines that you would like above and below the cursor
set hidden              " Unused buffers are hidden when abandonned
set backspace=2         " make backspace work like most other apps
set ignorecase          " ignore case when searching
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
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set shortmess+=I          " do not display welcome message
set wildmode=longest,list " Improve autocompletion on command line
set splitbelow            " Invert horizontal split order
set splitright            " Invert vertical split order

"let mapleader = "²"
"let mapleader = "§"
let mapleader = ","

filetype plugin on
if &t_Co == 256 && !has('win32unix')
    colorscheme wombat256mod
else
    colorscheme agr
endif
if has("gui_macvim")
    set vb
endif

set laststatus=2
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=[Buf:\ %3.3n]\                                         " buffer number
set statusline+=%f\                                                     " file name
set statusline+=-\ %{FileSize()}\                                          " file size
set statusline+=%h                                                      "help file flag
set statusline+=%m                                                      "modified flag
set statusline+=%r                                                      "read only flag
set statusline+=[%{strlen(&ft)?&ft:'Unknown'},\                         " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc},\                           " encoding
set statusline+=%{&fileformat}]                                         " file format
set statusline+=%=                                                      " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\       " highlight
set statusline+=%b,0x%-8B\                                              " current char
set statusline+=%10.(%l,%c%V%)%<\ of\ %L\ :\ %P                       " offset

set tags+=.git/tags
set tags+=.bzr/tags
set tags+=~/.vim/tags

"}}}

" ################################### PLATFORM ################################## {{{
syntax on
if has("unix")
    let $VIMFILES=$HOME . "/.vim"
else
    let $VIMFILES=$HOME . "\\vim"
endif
"if $TERM == "screen"
"    set term=rxvt
"endif
if &term =~ "screen\\|rxvt"
"    "Set the cursor white in cmd-mode and orange in insert mode
"    let &t_EI = "\<Esc>]12;white\x9c"
"    let &t_SI = "\<Esc>]12;orange\x9c"
"    "We normally start in cmd-mode
"    silent !echo -e "\e]12;white\x9c"
endif
"}}}

" ############################ AUTOCMD & FILETYPES ############################## {{{
if has("autocmd")
    "au BufEnter * silent! lcd %:p:h    "automatically change cwd to file's dir
    "\ if line("'\"") | exe "normal '\"" | endif |
    au BufRead *
        \ if line("'\"") | exe "normal '\"" | endif |
        \ if match( getline(1) , '^\#!') == 0 |
            \ execute("let b:interpreter = getline(1)[2:]") |
            \ if getline(1) =~ '^#!.*python' | set filetype=python | endif |
            \ if getline(1) =~ '^#!.*ruby' | set filetype=ruby | endif |
            \ if getline(1) =~ '^#!.*bash' | set filetype=sh | endif |
            \ if getline(1) =~ '^<DOCTYPE' | set filetype=html | endif |
        \endif

    au BufRead *.txt,*.rst setlocal expandtab tw=78 colorcolumn=80
    au BufRead,BufNewFile *.xml,*.xsl  setlocal foldmethod=syntax foldcolumn=3 foldnestmax=2 foldlevel=2 synmaxcol=300
    au BufRead,BufNewFile *.php,*.php3 setlocal foldmethod=syntax foldcolumn=3 foldnestmax=2 foldlevel=2
    au BufRead,BufNewFile *.rb setlocal fdm=syntax foldcolumn=0 foldnestmax=2 foldlevel=2
    au BufRead,BufNewFile *.aspx setlocal syntax=cs
    au BufRead,BufNewFile *.mako setlocal ft=html
    au BufRead,BufNewFile *.asp setlocal ft=javascript
    au BufRead,BufNewFile *.coffee setlocal fdm=indent
    au BufRead,BufNewFile .vimrc setlocal fdm=marker
    au BufRead,BufNewFile *.iced setlocal filetype=coffee
    au BufNewFile,BufRead *.boo setlocal filetype=boo
    au BufWritePost,FileWritePost *.coffee :!coffee -c -b <afile>
    "au BufWritePost,FileWritePost *.md,*.mkd :!markdown "<afile>" > "%:p:r.html"
    au BufWritePost,FileWritePost *.sass :silent !sass --compass --style expanded <afile> > "%:p:r.css"

    " au BufRead,BufNewFile *.css,*.aspx,*.c,*.cpp,*.cs,*.java,*.js,*.json,*.asp syn region myFold start="{" end="}" transparent fold |
    "     \ syn sync fromstart | set foldmethod=syntax foldcolumn=3 foldnestmax=3 foldlevel=2
    " au BufRead,BufNewFile *.js,*.asp,*.json syn clear javaScriptBraces

    au Filetype python syn match agrEq "[=]" | hi agrEq ctermfg=green guifg=green
    au Filetype python syn match agrSelf "self" | hi agrSelf ctermfg=gray guifg=gray
    au FileType python setlocal omnifunc=pythoncomplete#Complete colorcolumn=100

    " au Filetype ruby set foldmethod=syntax foldcolumn=0 foldnestmax=2 foldlevel=2

    " Don't screw up folds when inserting text that might affect them, until
    " leaving insert mode. Foldmethod is local to the window. Protect against
    " screwing up folding when switching between windows.
    au InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
    au InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

    if has("unix")
        au BufNewFile *.py setlocal autoread | s,^,#!/usr/bin/env python\r# -*- coding: utf-8 -*-,
        au BufNewFile *.rb setlocal autoread | s,^,#!/usr/bin/env ruby,
        au BufNewFile *.sh setlocal autoread | s,^,#!/bin/bash, | w | !chmod +x %
    endif

    au Filetype xml call XmlQweb()

    let php_sync_method=0
    let php_folding=1
    let php_asp_tags = 1
    let g:xml_syntax_folding=1
    let python_highlight_numbers = 1
    let coffee_folding = 1
    " let g:javaScript_fold = 1
    " let g:javascript_fold = 1
endif
"}}}

"" ################################### KEYMAPS ################################### {{{
" Broken terminals. Rxvt.
if (&term =~ "xterm") || (&term =~ "vt100")
    set t_kP=[5~ t_kN=[6~ t_kh=[1~ t_@7=[4~
endif

" Change behavior of some default mappings
nnoremap J mzJ`z
vnoremap J J`<

nnoremap <Leader>. :lcd %:p:h<CR>
" Reporoot
nnoremap <silent> <Leader>/ :ProjectRootLCD<cr>

" nnoremap <Leader>l :execute "!bzr qblame % -L " . line('.')<CR>
nnoremap <Leader>l :'<,'>Gbrowse<CR>
vnoremap <Leader>l :Gbrowse<CR>

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

" Editing
vmap <C-R> "_dP
vmap <C-Insert> "_d"+P
imap <C-Insert> <C-O>"+gP
vmap <Backspace> "_d

" nmap <C-t> :tabnew<CR>
" imap <C-t> <Esc>:tabnew<CR>
command! -nargs=* -complete=file E if expand('%')=='' && line('$')==1 && getline(1)=='' | :edit <args> | else | :tabnew <args> | endif
cabbrev e <c-R>=(getcmdtype()==':' && getcmdpos()==1 ? 'E' : 'e')<cr>
nnoremap <silent> <F2> :tabprevious<CR>
inoremap <silent> <F2> <C-O>:tabprevious<CR>
nnoremap <silent> <F3> :tabnext<CR>
inoremap <silent> <F3> <C-O>:tabnext<CR>

" Same for buffers
nnoremap <silent> <S-F2> :lprevious<CR>
inoremap <silent> <S-F2> <C-O>:lprevious<CR>
nnoremap <silent> <S-F3> :lnext<CR>
inoremap <silent> <S-F3> <C-O>:lnext<CR>

" Folding
nnoremap <silent> <S-Up> zc
inoremap <silent> <S-Up> <C-O>zc
nnoremap <silent> <S-Down> zO
inoremap <silent> <S-Down> <C-O>zO
noremap [a zc
inoremap [a <C-O>zc
noremap [1;5B zc
inoremap [1;5B <C-O>zc
nnoremap <silent> <F4> zR
inoremap <silent> <F4> <C-O>zR
nnoremap <silent> <F5> zM
inoremap <silent> <F5> <C-O>zM

nnoremap <F6> :call ToggleMarkers()<CR>
vnoremap <F6> :call ToggleMarkers()<CR>gv
inoremap <F6> <C-O>:call ToggleMarkers()<CR>
let g:agr_markers = 0
function! ToggleMarkers()
    if g:agr_markers
        set colorcolumn=0
        set nocursorline nocursorcolumn
        let g:agr_markers = 0
    else
        set colorcolumn=80
        set cursorline cursorcolumn
        let g:agr_markers = 1
    endif
endfunction

" F8 & Shift-F8 mapped in pydebug addon
" nnoremap <F8> :TogglePudbBreakPoint<CR>
" inoremap <F8> <ESC>:TogglePudbBreakPoint<CR>a

" Quit
nnoremap <silent> <F10> :bde<CR>
inoremap <silent> <F10> <C-O>:bde<CR>

nnoremap <F11> :nohlsearch<CR>
inoremap <F11> <C-O>:nohlsearch<CR>

" NERD Tree
nnoremap <F12> :NERDTreeToggle<CR>
inoremap <F12> <C-O>:NERDTreeToggle<CR>

" Taglist
nnoremap <silent> <S-F12> :TagbarToggle<CR><C-w>l
inoremap <silent> <S-F12> <C-O>:TagbarToggle<CR><C-w>l
" nnoremap <silent> <S-F7> :lcd %:p:h<CR>:RepoRoot<CR>:!ctags .<CR>

" Calculator
inoremap <Leader>= <C-O>yiW<End>=<C-R>=<C-R>0<CR>

" Ag
let g:agprg = 'ag --nogroup --nocolor --column'
noremap <Leader>ag :Ag! '<c-r>=expand("<cword>")<cr>'<Home><Right><Right><Right><Right><Right><Right>
vnoremap <Leader>ag :Ag! '<c-r>=expand("<cword>")<cr>'<Home><Right><Right><Right><Right><Right><Right>

" Emmet (used to be Zen coding)
let g:user_emmet_expandabbr_key = '<c-e>'
" let g:user_emmet_leader_key = '<c-e>'
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
    \  'indentation' : '    '
\}

" set pastetoggle=<S-F12>

" IP Lookup
nmap <silent> <Leader>IP :python lookupIPUnderCursor()<CR>

vmap <Tab> >
vmap <S-Tab> <LT>

"inoremap {{ {
"imap %% <%%><left><left>
"imap %%<cr> <%<cr>%><esc>O<Tab>
"inoremap {<cr> {<cr>}<esc>O<Tab>
"inoremap [ []<left>
"inoremap ( ()<left>
inoremap ({<cr> ({<cr><Backspace>});<esc>O
inoremap {<cr> {<cr><Backspace>}<esc>O
inoremap {{ {{  }}<left><left><left>

nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
imap <silent> <A-Up> <C-O>:wincmd k<CR>
imap <silent> <A-Down> <C-O>:wincmd j<CR>
imap <silent> <A-Left> <C-O>:wincmd h<CR>
imap <silent> <A-Right> <C-O>:wincmd l<CR>

map <A-i> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") ."> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"" }}}

"" ################################### ADDONS #################################### {{{

" Misc Configuration {{{
function! FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return ""
    endif
    if bytes < 1024
        return bytes
    else
        return (bytes / 1024) . "K"
    endif
endfunction
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" Tabular
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a\| :Tabularize /\|<CR>
vmap <Leader>a\| :Tabularize /\|<CR>

" Gist
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1

" SuperTab
" let g:SuperTabDefaultCompletionType = "context"

" Session.vim
let g:session_autosave = 'no'
let g:session_autoload = 'no'

" SnipMate
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['javascript'] = 'javascript,javascript-agr'
let g:snipMate.scope_aliases['xml'] = 'xml,xml-agr,html'
let g:snipMate.scope_aliases['_'] = '_,_-agr'
let g:snipMate.scope_aliases['python'] = 'python,python-agr'

" CtrlP
let g:ctrlp_max_files = 0
" let g:ctrlp_prompt_mappings = {
"     \ 'AcceptSelection("t")': ['<cr>'],
"     \ 'AcceptSelection("e")': ['<c-x>'],
" \ }
nnoremap <silent> <Leader>b :CtrlPBuffer<CR>

" NERDTree
let g:nerdtree_tabs_open_on_gui_startup=0
let NERDTreeMapCloseDir='<Left>'
let NERDTreeMapUpdir='<C-Left>'
let NERDTreeMapActivateNode='<Right>'
let NERDTreeMapChangeRoot='<C-Right>'

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = '⚠'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list = 1

" localvimrmc
" TODO: check if $HOME can be injected in string
let g:localvimrc_whitelist='/Users/agr/Projects/odoo/.lvimrc'
let g:localvimrc_sandbox=0
" TODO: blacklist everything else
" :localvimrc_blacklist

" Jedi
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0

" Xmledit
let g:xmledit_enable_html = 1

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
    hi xmlAttribQWeb guifg=#f0a040 ctermfg=DarkMagenta
    hi xmlAttribQWebTrad guifg=#ffffff ctermfg=white

    syn region qwebVarBlock matchgroup=qwebVarDelim start=/{{-\?/ end=/-\?}}/ containedin=xmlString
    syn region qwebVarBlock2 matchgroup=qwebVarDelim start=/#{-\?/ end=/-\?}/ containedin=xmlString
    hi def link qwebVarDelim qwebVarBlock
    hi qwebVarDelim guifg=#D4C828 ctermfg=DarkYellow
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
        if strLine.lstrip()[:38] == 'from pudb import set_trace;set_trace()':
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
" IP Lookup {{{
" Website: http://codeseekah.com/2012/03/04/vim-scripting-with-python-lookup-ip-country/
" Lookup the country for an IP address under the current cursor
" Make sure Python is ready

if has('python')
python << EOF
import vim, urllib

def lookupIPUnderCursor():
    ip = vim.eval("expand('<cWORD>')")
    print "Looking up %s..." % ip
    # api info : http://www.hostip.info/use.html API
    info = urllib.urlopen('http://api.hostip.info/get_html.php?position=true&ip=%s' % ip).read()
    vim.command("redraw") # discard previous messages
    print info
EOF
endif
" }}}
" CloseHiddenBuffers {{{
" This one doesn't work with tab.
" TODO: find another one
function! CloseHiddenBuffers()
    let lastBuffer = bufnr('$')
    let currentBuffer = 1
    while currentBuffer <= lastBuffer
        if bufexists(currentBuffer) && buflisted(currentBuffer) && bufwinnr(currentBuffer) < 0
            execute 'bdelete' currentBuffer
        endif
        let currentBuffer = currentBuffer + 1
    endwhile
endfunction
" }}}
