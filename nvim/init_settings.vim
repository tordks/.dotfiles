
"""""""""""""
"""""""""""""
"" SETTINGS "
"""""""""""""
"""""""""""""
" TODO: consider mapping leader to space -> Need to change folding key
let mapleader = ","

set nocompatible
set background=dark
set pastetoggle=<F2>        " set key to toggle paste mode
set laststatus=2            " always displaying status line
set nu                      " display line numbers
set tabstop=4               " number of visual spaces per TAB
set shiftwidth=4            " size of an indent
set expandtab               " smart expansion of tabs into spaces
set softtabstop=4           " number of spaces in tab when editing.
set smarttab
set wildmenu                " visual autocomplete for command menu
set nohlsearch              " removes highlight search
set incsearch               " search as characters are entered
set t_Co=256                " 256 colors
set encoding=utf-8          " sets encoding to utf-8
set history=9999            " remember more history than usual
set undofile                " save undo's after file closes
set undodir=$HOME/.config/nvim/undo " persistent undo
set undolevels=10000        " set the undo history size
set undoreload=10000        " set the number of undos to reload when opening a file
set ruler                   " show the cursor position with a ruler
set cursorline              " highlights the line where the cursor is
set showcmd                 " display incomplete commands
set showmatch               " show matching braces
set lazyredraw              " do not redraw when executing macros; much faster
set foldenable              " enable folding
set foldlevelstart=10       " open most folds by default
set foldnestmax=3          " 10 nested fold max
set foldmethod=indent       " fold based on indent level
set scrolloff=10             " Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
set mouse=a                 "Enable mouse"
set clipboard=unnamed       "Sets vim clipboard to the systems"

