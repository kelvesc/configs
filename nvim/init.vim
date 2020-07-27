" NeoVim Configuration

" General
syntax on
filetype on
"set autochdir                  "Vim chdir whenever a file is open
set ruler
set number
set relativenumber              "Display line numebers relative to the current
set scrolloff=8                 "Disctance from top/bottom edge when scrolling
set autoread                    "Auto reads file when file changes
set lazyredraw                  "Don't redraw while processing macros
set mouse=a                     "Mouse behavior set to ALL
set nocursorline                "Don't draws a line where the cursor is located
set showcmd                     "Display incomplete command in the lower right
set cmdheight=1
set history=500
set undolevels=200
set wildmenu                    "Command-line completion enabled
set wildmode=longest,list:full  "Show a list when completing
set wildignore=*.swp,*.bak,*pyc,*.class "Ignore these when expanding blobs
set completeopt=menuone,longest
set complete+=k

"NVim files (?)
"set undofile
"set undodir=~/.cache/nvim/undodir/
"set backupdir=~/.cache/nvim/backupdir/
"set directory=~/.cache/nvim/swapdir/
"TODO: search for what exactly it does

"Colors
set t_Co=256
set t_AB=^[[48;5;%dm
set t_AF=^[[38;5;%dm
colorscheme default
"colorscheme elflord
"set termguicolors
set background=dark
highlight LineLr ctermbg=none guibg=none

"Editing
"set fsync
set autoindent
set smartindent
set breakindent
set textwidth=80
set colorcolumn=81
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set iskeyword+=-        "Treat "-" as a character that may be in a word
set clipboard+=unnamedplus
set backspace=indent,eol,start "Backspace behavior
set whichwrap+=<,>,b

set modelines=0
set linebreak           "Break long lines to fit the terminal size
set breakindent         "Wrapped lines will continue visually indented
let &showbreak = "+ "   "Broken lines are denoted by
set wrap                "Wrap long line

"Tab behavior
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

"Searching
set magic               "For regular expressions
set hlsearch            "Highlight search results
set ignorecase          "Make the search case insensitive
set smartcase           "Smart about cases when searching
set incsearch           "Incremental search
set synmaxcol=80        "Don't search in long lines

set showmatch           "Show matching { [ ( ) ] }
set foldenable          "enable folding
set foldcolumn=0        "Add a margin to the left
set foldmethod=manual

set splitbelow          "Horizontal split is below
set splitright          "Vertical split is right
set laststatus=2        "Always show the status line

"Autocommands
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

autocmd BufRead,BufNewFile * call MapOnTerm()

"Autocommands for specific file types
"TESTING: change filetype from dos to unix when opening
"DOES NOT WORK
autocmd BufRead dos set filetype=unix
autocmd BufRead,BufNewFile * if &ft == 'dos' | setfiletype unix | endif
"TESTING: set text file as text files
autocmd BufRead,BufNewFile *.txt set filetype=text

autocmd Filetype c,cpp call CSyntax()
autocmd Filetype ml,sml call MLSyntax()
autocmd Filetype erlang call ErlangSyntax()
autocmd Filetype haskell,vhdl,ada call HSSyntax()
autocmd Filetype sh,make,python call ScriptSyntax()
"autocmd BufNewFile *.sh 0r ~/path/to/skeleton.sh

"Autocommands for specific files
"Resource NVim config
let s:vimrc="~/.config/nvim/init.vim"
autocmd BufWritePost s:vimrc nested source s:vimrc
"Run xrdb when X* is updated
autocmd BufWritePost *Xresources, *Xdefaults !xrdb %
"Send SIGUSR1 whenever sxhkdrc is updated
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

"Functions
function! ReturnLastPosition() abort
    if ! exists("g:leave_my_cursor_position_alone")
        if line("'\"") > 0 && line("'\"") <= line("$")
            execute "normal! g'\""
        endif
    endif
endfunction

function! FindHelp() abort
    let s:w=fnameescape(expand('<cword>'))
    if &filetype == 'vim'
       execute "help " . s:w
    else
       execute "Man " . s:w
   endif
   unlet! s:w
endfunction

"TESTING
function! MapOnTerm() abort
"???: maybe change URxvt behavior on Alt-s
"???: what is about with Ctrl-s in the terminal?
"Binds Ctrl-s to save a file in URxvt and Alt-s in any other terminal emulator
    if &term == "rxvt-unicode-256color"
        noremap <C-s> <Esc>:w<CR>
        inoremap <C-s> <Esc>:w<CR>
    else
        noremap <A-s> <Esc>:w<CR>
        inoremap <A-s> <Esc>:w<CR>
    endif
endfunction

function! Sort() abort
"Select an area and type !sort to sort the lines selected
endfunction

function! SetColor(thm) abort
    if &thm == default
        colorscheme default
    elseif &thm == elflord
        colorscheme elflord
    endif
endfunction

function! SpellCheck() abort
    setlocal spell spelllang=en_us
    setlocal noexpandtab
endfunction

function! CancelSpellCheck() abort
    setlocal nospell
    setlocal expandtab
endfunction

"Languages Specific Functions
"FIXME:: this is a mess.
function! HSSyntax() abort
    map <silent> <F2> :s/^/--/<CR>:nohlsearch<CR>
    map <silent> <F4> :s/^--//<CR>:nohlsearch<CR>
endfunction

function! CSyntax() abort
    map <silent> <F2> :s/^/\/\//<CR>:nohlsearch<CR>
    map <silent> <F4> :s/^\/\///<CR>:nohlsearch<CR>
endfunction

function! ScriptSyntax() abort
    map <silent> <F2> :s/^/#/<CR>:nohlsearch<CR>
    map <silent> <F4> :s/^#//<CR>:nohlsearch<CR>
endfunction

function! ErlangSyntax() abort
    map <silent> <F2> :s/^/%/<CR>:nohlsearch<CR>
    map <silent> <F4> :s/^%//<CR>:nohlsearch<CR>
    inoremap ,, ->
endfunction

function! MLSyntax() abort
    map <silent> <F2> :s/^/(*/<CR>:s/$/*)/<CR>:nohlsearch<CR>
    map <silent> <F4> :s/^(*//<CR>:s/*)$/ /<CR>:nohlsearch<CR>
    inoremap ,, =>
endfunction

"Abbreviations
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

"Mappings
"\ is the default mapleader
let mapleader = ","
"Remaps jj to Esc, in INSERT MODE
inoremap jj <Esc>

"Open/Quit file editting
"Maps qq to quit
inoremap qq <Esc>:q<CR>
noremap qq <Esc>:q<CR>
noremap qw <Esc>:q<CR>
"QQ to force quit
nnoremap QQ <Esc>:q!<CR>
"Faster navigating between files
nnoremap <A-e> :e<space>
"Save file map is done on MapOnTerm()
":jumps, to see the jump list (useful for moving around files back and forth)

"Navigation
noremap n nzz
noremap N Nzz
" b and B, backwards word
"Map Shift-h to start of the line and Shift-l to lines end
noremap H 0
noremap L $
"More movement
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
"Navigate between splits
nnoremap <A-k> <C-w>k
nnoremap <A-j> <C-w>j
nnoremap <A-h> <C-w>h
nnoremap <A-l> <C-w>l

"TODO: lear terminal mode
"Terminal Mode
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd WinLeave term://* stopinsert
tnoremap <Esc> <C-\><C-n><C-w><C-p>
"tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

"Editing
"Yank til the end of the line
noremap Y y$
"Surrond the word with  (), [] or {}
nnoremap <silent> <leader>' i"<Esc>ea"
nnoremap <silent> <leader>t i(<Esc>ea)
nnoremap <silent> <leader>b i[<Esc>ea]
nnoremap <silent> <leader>c i{<Esc>ea}
noremap < <<
noremap > >>
"Strip all trailing white spaces in the current file
nnoremap <leader>w :%s/\s/+$//<CR>:let @/=''<CR>

"Search/Replace
"gu to lower gU to upper
noremap <space>u vegU
noremap <space>l vegu
"Fix regex search by inserting \v at the begining
noremap / /\v
"Internally search the word under the cursor (gd for exact matches)
noremap <leader>f /<C-r><C-w><CR>
"External search the word under the cursor
"\b<word>\b does the same as \<<word>\>
"%:p:h/ denotes the dir as same as current file
noremap <leader>e :grep '\b<cword>\b' %:p:h/*<CR>
"Deactivates highlighted search
"Highlighted search will returns when n or N is pressed
noremap <silent> cf :nohlsearch<CR>
"Substitute all occurrencs of the word under the cursor
"The \< and \> ensure that only full words are matched
"<C-r> insert the content of <C-w> the word under the cursor
"Optionally(auto /g): nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <leader>s :%s/\<<C-r><C-w>\>/
"Open a help file or a man page for the word unde the cursor, when it exists
noremap <silent> <A-m> :call FindHelp()<CR>
"below, is the one line version of the above mapped function
"noremap <expr> <A-m> (&filetype is# 'vim' ? (':help ' . fnameescape(expand('<cword>')) . "\n") : (':Man ' . fnameescape(expand('<cword>')) . "\n"))
"???: reselect pasted text
nnoremap <leader>p V`]

"Folding
"TODO: figure out how folding works
" zf defines a fold
noremap <F1> za
noremap <Space> za
inoremap <F3> <C-O>za

"Reload nvim config file
noremap <silent> <A-r> <Esc>:source ~/.config/nvim/init.vim<CR>:nohlsearch<CR>

