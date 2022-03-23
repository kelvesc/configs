"------------------------------------------------------------------
" NeoVim Configuration
"------------------------------------------------------------------

"------------------------------------------------------------------
"Autocommands
"------------------------------------------------------------------
augroup vimrc
    autocmd!
    autocmd BufWinEnter,Syntax * syn sync minlines=500 maxlines=500
augroup END

"Autosaves when focus is lost
autocmd FocusLost * :wa

"Check is file has changed since focus was lost
autocmd FocusGained,BufEnter * checktime

"Place the cursor in last line in the file it was before
autocmd BufReadPost * :call ReturnLastPosition()

"Remove trailing whitespaces on save
autocmd BufWritePre * %s/\s\+$//e

"Center the text whenever entering insert mode
autocmd InsertEnter * norm zz

"FIXME: this whole block of autocmds does not their job
"Autocommands for specific file types
"TODO: change filetype from dos to unix when opening
autocmd BufRead,BufNewFile * if &ft == 'dos' | :%s/\r//g | endif
autocmd BufRead,BufNewFile *.txt set filetype=text

"Run xrdb when X* is updated
autocmd BufWritePost *Xresources, *Xdefaults !xrdb %

"Send SIGUSR1 whenever sxhkdrc is updated
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

"automatically resource nvim config when it is saved
autocmd BufWritePost *init.vim nested :source ~/\.config/nvim/init.vim

augroup c_cpp_source_code
        au BufWinEnter *.c,*.cpp abbr fi if
        au BufWinEnter *.c,*.cpp abbr def def
        au BufWinEnter *.c,*.cpp abbr inc inc
        "au BufWinEnter *.c,*.cpp <buffer> inoremap #def #define
        "au BufWinEnter *.c,*.cpp <buffer> inoremap #inc #include
augroup END
"------------------------------------------------------------------
"Functions
"------------------------------------------------------------------
function! ReturnLastPosition() abort
    if ! exists("g:leave_my_cursor_position_alone")
        if line("'\"") > 0 && line("'\"") <= line("$")
            execute "normal! g'\""
        endif
    endif
endfunction

"OBS: this function is here only for demonstration porpouses
"its is now done in a more simple away and with less lines
function! FindHelp() abort
    let s:w=fnameescape(expand('<cword>'))
    if &filetype == 'vim'
       execute "help " . s:w
    else
       execute "Man " . s:w
   endif
   unlet! s:w
endfunction

function! SpellCheck() abort
    setlocal spell spelllang=en_us
    setlocal noexpandtab
endfunction

function! CancelSpellCheck() abort
    setlocal nospell
    setlocal expandtab
endfunction

"------------------------------------------------------------------
"Abbreviations
"------------------------------------------------------------------
abbr ep ()
abbr eb []
abbr ec {}
abbr todo TODO:
abbr tood TODO:
abbr fixm FIXME:
abbr fxme FIXME:
abbr tehn then
abbr lese else
abbr caes case
abbr ceas case
inoremap '' "

"------------------------------------------------------------------
"Mappings
"------------------------------------------------------------------
let mapleader = "\<space>"

inoremap jj <esc>

noremap <A-s> <esc>:w<cr>
inoremap <A-s> <esc>:w<cr>
noremap <A-w> <esc>:w<cr>
inoremap <A-w> <esc>:w<cr>

"Maps qq to quit
inoremap <silent> <nowait> qq <esc>:q<cr>
noremap <silent> <nowait> qq <esc>:q<cr>
noremap <silent> <nowait> QQ <esc>:q!<cr>

"find help
noremap <leader>m K
noremap <C-h> :help<space><C-r><C-w><cr>

"------------------------------------------------------------------
"Navigation
" TODO: add an FZY map to open files(?)
"------------------------------------------------------------------
noremap n nzz
noremap N Nzz
" b and B, backwards word
noremap H 0
noremap L $
noremap J 10j
noremap K 10k
"Move in long lines
noremap <C-j> gj
noremap <C-k> gk
"Tab places the cursor at matching bracket
noremap <tab> %
"Open a vertical/horizontal split and switch over to it
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>h <C-w>s<C-w>k
"use `ALT+{h,j,k,l}` to navigate windows from any mode
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l

" - opens netrw
noremap <silent> - :e %:h<cr>

" gf opens a file  even if it does not exit
noremap <silent> gf :e <cfile><cr>

"Faster navigating between files
nnoremap <leader>e :e<space>
nnoremap <A-e> :e<space>
nnoremap <leader>b :b<space>

":jumps, to see the jump list (useful for moving around files back and forth)
" marking a line in the text is done by m{a-zA-Z}
" and the marking location is accesse by '{a-zA-Z}

"------------------------------------------------------------------
"Editing
"------------------------------------------------------------------
"Yank til the end of the line
noremap Y y$
noremap <leader>y v$y
"gu to lower gU to upper
noremap <silent> <nowait> <leader>u viwgU
noremap <silent> <nowait> <leader>l viwgu

"Surrond the word with  (), [] or {}
nnoremap <silent> <leader>' viw<esc>a"<esc>hbi"<esc>lel
nnoremap <silent> <leader>( viw<esc>a)<esc>hbi(<esc>lel
nnoremap <silent> <leader>[ viw<esc>a)<esc>hbi[<esc>lel
nnoremap <silent> <leader>{ viw<esc>a}<esc>hbi{<esc>lel
noremap < <<<esc>gv
noremap > >><esc>gv
"vnoremap < <<
"vnoremap > >>

"Strip all trailing white spaces in the current file
nnoremap <silent> <leader>w :silent! %s/\s/+$//<cr>:let @/=''<cr>

"sort lines
vnoremap <leader>ord :'<,'>!sort<cr>gv
vnoremap <leader>col :'<,'>!column --table<cr>gv
"TODO: take a look at :help filter

"------------------------------------------------------------------
"Search/Replace
"------------------------------------------------------------------
"Internally search the word under the cursor
" # * g# g gd gD
"External search the word under the cursor
"noremap <leader>f :grep '\b<cword>\b' %:p:h/*<cr>
"Deactivates highlighted search will returns when n or N is pressed
noremap <silent> cf :nohlsearch<cr>
"Substitute all (full) occurrencs of the word under the cursor (\< and \>)
"WHY/HOW does it substitute globally without the trailing g?
nnoremap <leader>s :%s/\<<C-r><C-w>\>/
"???: reselect pasted text
nnoremap <leader>p V`]

"------------------------------------------------------------------
"Folding
"------------------------------------------------------------------
" zf defines a fold
"noremap <F1> za
"noremap <Space> za
"inoremap <F3> <C-O>za

"------------------------------------------------------------------
"Terminal Mode TODO: learn terminal mode
"------------------------------------------------------------------
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd WinLeave term://* stopinsert
nnoremap <leader>t :bo term<cr>
tnoremap <esc> <C-\><C-n><C-w><C-p>
"tnoremap <esc> <C-\><C-n>

"------------------------------------------------------------------
"Sourcing Cofig Files
"------------------------------------------------------------------
"Reload nvim config file
noremap <silent> <leader>r :source ~/.config/nvim/init.vim<cr> :echo "init.vim reloaded"<cr>

source ~/.config/nvim/settings.vim

