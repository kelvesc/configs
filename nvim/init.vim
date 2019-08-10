" NeoVIm Configuration

"function! s:isLinux ()
"  return has("unix") && count(spilt(system "uname"), '\n'), 'Linux')
"endfunction
"
"if s:isLinux ()
"  set clipboard=unnamedplus
"else
"  set clipboard=unnamed
"endif

syntax on
filetype on
set number
set ruler
set relativenumber
" Auto reads file when file changes
set autoread
"set statusline=

" Commands completions by <TAB>
set wildmenu
" Completion options
"set completopt=menu,menuone,longest,preview
set nocp
" Don't redraw whiel processing macros
set lazyredraw

" Draws a line in the line where the cursor is located
set cursorline
" Mouse bahavior set to ALL
set mouse=a
set wrap
set breakindent
" Broke lines are denoted by 
let &showbreak = "+ "
" Break long lines (to fit the terminal)
set linebreak
set encoding=utf-8
set autoindent
set smartindent

" Horizontal split is below
set splitbelow
" Vertical split is right
set splitright

" Tab bahavior
set tabstop=2
set smarttab
set expandtab
set shiftwidth=2
" Backspace Behavior
set backspace=indent,eol,start

set nospell
" Highlight and ignore case when searching
set hlsearch
set ignorecase
set smartcase
set incsearch
" Don't search in lines greater than 800 characters
set synmaxcol=800


"set foldlevelstart=99
"set foldmethod=indent
"set spell spelllang=en_us

" map <tecla> <Comando vim>
" inoremap <tecla1><tecla2> <sequencia de comandos>
" autocmd FileType <tipo do arquivo> inoremap <teclas> <comandos>
