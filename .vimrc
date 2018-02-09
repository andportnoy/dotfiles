" Vim Plug section
call plug#begin()

    " Python linter, requires flake8, run with <F7>
    Plug 'nvie/vim-flake8'

    " Cool colorschemes
    Plug 'sonph/onehalf', {'rtp': 'vim'}

    " Status bar
    Plug 'vim-airline/vim-airline'

    " Tree explorer
    Plug 'scrooloose/nerdtree'
    map <C-n> :NERDTreeToggle<CR>

call plug#end()

" Use colorschemes from onehalf plugged in above
colorscheme onehalfdark
let g:airline_theme='onehalfdark'

set number         " display line numbers
set textwidth=0    " no linebreaking
set colorcolumn=81 " Show a red bar just past 80 chars
set shiftwidth=4   " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4      " a hard TAB displays as 4 columns
set expandtab      " insert spaces when hitting TABs
set smarttab

" exempt make files from tab expansion
filetype plugin on
autocmd FileType make setlocal noexpandtab

set softtabstop=4  " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround     " round indent to multiple of 'shiftwidth'
set autoindent     " align the new line indent with the previous line

set backspace=indent,eol,start

set foldmethod=indent " perform folding on indented blocks
set ruler          " show current line number

set hlsearch       " higlight search results
set incsearch      " incremental search (start showing results immediately)
set ic             " search ignoring case

set nofoldenable
set splitbelow      " vertical split appears below
set splitright      " horizontal split appears on the right

" remap split navigation 
" e.g. Ctrl + j instead of first Ctrl + w, then j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>


