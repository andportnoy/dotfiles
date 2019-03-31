" Vim Plug section
call plug#begin()

    Plug 'sonph/onehalf', {'rtp': 'vim'}

    Plug 'scrooloose/nerdtree'
    map <C-n> :NERDTreeToggle<CR>

    Plug 'christoomey/vim-tmux-navigator'

    Plug 'vim-airline/vim-airline'
    let g:airline_theme='onehalfdark'

    " Sidebar with code tags
    Plug 'majutsushi/tagbar'
    nmap <C-t> :TagbarToggle<CR>
    let g:tagbar_type_ngdl = {
        \ 'ctagstype' : 'ngdl',
        \ 'kinds': ['l:lair', 's:subgraph']
        \}

call plug#end()

colorscheme onehalfdark
syntax enable
filetype plugin on

set laststatus=2
set statusline=%m
set statusline+=%=%F
set ruler               " show current line number

set path+=**            " search for files recursively in subdirs
set wildmenu            " show options when tab completing
set tags=./tags,tags;   " search for tags in working directory first
set clipboard=unnamed   " use system clipboard
set scrolloff=5         " show 5 lines of context around cursor
set timeoutlen=1000 ttimeoutlen=0 " improve mode switch times
set mouse=a

let mapleader = ","
let maplocalleader = "\\"

set number              " display line numbers
set textwidth=0         " no linebreaking
set colorcolumn=80      " Show a red bar just past 79 chars
set shiftwidth=4        " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4           " a hard TAB displays as 4 columns
set expandtab           " insert spaces when hitting TABs
set smarttab
set softtabstop=4       " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround          " round indent to multiple of 'shiftwidth'
set autoindent          " align the new line indent with the previous line

autocmd FileType make setlocal noexpandtab " exempt make files from tab expansion

set backspace=indent,eol,start

set foldmethod=indent   " perform folding on indented blocks

set hlsearch            " higlight search results
set incsearch           " incremental search (start showing results immediately)
set ic                  " search ignoring case

set nofoldenable
set splitbelow          " vertical split appears below
set splitright          " horizontal split appears on the right
