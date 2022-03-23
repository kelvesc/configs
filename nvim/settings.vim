"------------------------------------------------------------------
"General Settings
"------------------------------------------------------------------
syntax on
filetype on

set ruler
set number

"Display line numebers relative to the current
set relativenumber

"Disctance from top/bottom edge when scrolling
set scrolloff=8

"Vim chdir whenever a file is open
set autochdir

"Auto reads file when file changes
set autoread

"Don't redraw while processing macros
set lazyredraw

"Mouse behavior set to ALL
set mouse=a

"Display incomplete command in the lower right
set showcmd
set cmdheight=1
set history=500
set undolevels=200
set wildmenu                    "Command-line completion enabled
set wildmode=list:full          "Show a list when completing
"Ignore these when expanding blobs
set wildignore=*.o,*.obj,*.swp,*.bak,*pyc,*.class,*.exe
set completeopt=menuone,longest
set complete+=k

"------------------------------------------------------------------
"Editing
"------------------------------------------------------------------
set fsync
set expandtab
set autoindent
set smartindent
set breakindent
set textwidth=90
set colorcolumn=91
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set iskeyword+=-        "Treat - as part of a word
set clipboard+=unnamedplus
set backspace=indent,eol,start "Backspace behavior
set whichwrap+=<,>,b

"------------------------------------------------------------------
"Searching
"------------------------------------------------------------------
set showmatch           "Show matching { [ ( ) ] }
set magic               "For regular expressions
set hlsearch            "Highlight search results
set ignorecase          "Make the search case insensitive
set smartcase           "Smart about cases when searching
set incsearch           "Incremental search
set synmaxcol=80        "Don't search in long lines

"------------------------------------------------------------------
"Splits
"------------------------------------------------------------------
"Horizontal split is below
set splitbelow

"Vertical split is right
set splitright

"Always show the status line
set laststatus=2

"------------------------------------------------------------------
"Folding
"------------------------------------------------------------------
"enable folding
set foldenable

"Add a margin to the left
set foldcolumn=0

set foldmethod=manual

"------------------------------------------------------------------
"Visuals
"------------------------------------------------------------------
colorscheme elflord

"Don't draws a line where the cursor is located
set nocursorline

set background=dark
set guicursor+=i:blinkoff150-blinkon150
highlight LineLr ctermbg=NONE guibg=NONE
highlight NonText cterm=NONE ctermfg=NONE

set modelines=0

"Break long lines to fit the terminal size
set linebreak

"Wrapped lines will continue visually indented
set breakindent

"Broken lines are denoted by
let &showbreak = "+ "

"Wrap long line
set wrap

"NVim files (?)
"set undofile
"set undodir=~/.cache/nvim/undodir/
"set backupdir=~/.cache/nvim/backupdir/
"set directory=~/.cache/nvim/swapdir/

