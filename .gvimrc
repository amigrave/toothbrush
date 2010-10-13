colorscheme wombat
set guioptions-=T           " hide toolbar
"set guioptions-=m           " Remove menu bar


if has("win32")
    au GUIEnter * simalt ~x
    "set guifont=Fixedsys\ Excelsior\ 2.00\ 11
    "set guifont=MiscFixed\ 8
    set guifont=DejaVu\ Sans\ Mono
else
    set lines=999 columns=999   " Hack: maximize gvim
    "set guifont=console
    "set guifont=-misc-fixed-medium-r-normal--10-100-75-75-c-60-iso8859-1
    "set guifont=Bitstream\ Vera\ Sans\ Mono/11/-1/5/50/0/0/0/0/0
    set guifont=Monospace\ 9
endif

" Windows handling
nnoremap <silent> <C-H> :vne<CR>
"nnoremap <silent> <C-S-L> :rightb vne<CR>
nnoremap <silent> <C-J> :rightb new<CR>
nnoremap <silent> <C-K> :new<CR>
"nnoremap <silent> <C-S-Up> <C-O>:rightb vne<CR>
nnoremap <silent> <C-S-Right> <C-W>>
inoremap <silent> <C-S-Right> <C-O><C-W>>
nnoremap <silent> <C-S-Left> <C-W><
inoremap <silent> <C-S-Left> <C-O><C-W><
nnoremap <silent> <C-S-Up> <C-W>+
inoremap <silent> <C-S-Up> <C-O><C-W>+
nnoremap <silent> <C-S-Down> <C-W>-
inoremap <silent> <C-S-Down> <C-O><C-W>-


"The following removes bold from all highlighting
" Steve Hall wrote this function for me on vim@vim.org
" See :help attr-list for possible attrs to pass
" {{{
function! Highlight_remove_attr(attr)
    " save selection registers
    new
    silent! put

    " get current highlight configuration
    redir @x
    silent! highlight
    redir END
    " open temp buffer
    new
    " paste in
    silent! put x

    " convert to vim syntax (from Mkcolorscheme.vim,
    "   http://vim.sourceforge.net/scripts/script.php?script_id=85)
    " delete empty,"links" and "cleared" lines
    silent! g/^$\| links \| cleared/d
    " join any lines wrapped by the highlight command output
    silent! %s/\n \+/ /
    " remove the xxx's
    silent! %s/ xxx / /
    " add highlight commands
    silent! %s/^/highlight /
    " protect spaces in some font names
    silent! %s/font=\(.*\)/font='\1'/

    " substitute bold with "NONE"
    execute 'silent! %s/' . a:attr . '\([\w,]*\)/NONE\1/geI'
    " yank entire buffer
    normal ggVG
    " copy
    silent! normal "xy
    " run
    execute @x

    " remove temp buffer
    bwipeout!

    " restore selection registers
    silent! normal ggVGy
    bwipeout!
endfunction
" Note adding ,Syntax above messes up the syntax loading
" See :help syntax-loading for more info
" }}}
if has("win32")
    autocmd BufNewFile,BufRead * call Highlight_remove_attr("bold")
    autocmd BufNewFile,BufRead * call Highlight_remove_attr("italic")
endif

hi Pmenu guibg=yellow guifg=black
hi PmenuSel guibg=white guifg=black
hi Cursor guifg=white guibg=red
hi FoldColumn guibg=black guifg=gray
