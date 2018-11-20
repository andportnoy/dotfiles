" Vim Plug section
call plug#begin()

    " Python linter, requires flake8, run with <F7>
    Plug 'nvie/vim-flake8'

    " Python code formatter
    Plug 'ambv/black'
    let g:black_linelength = 79
    let g:black_skip_string_normalization = 1
    nmap <F6> :Black<CR>

    " Cool colorschemes
    Plug 'sonph/onehalf', {'rtp': 'vim'}

    " Status bar with themes
    Plug 'vim-airline/vim-airline'

    " Filesystem explorer
    Plug 'scrooloose/nerdtree'
    map <C-n> :NERDTreeToggle<CR>
    let NERDTreeShowBookmarks=1

    Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_types = ['fil']
    let g:ctrlp_extensions = ['tag']
    let g:ctrlp_cmd = 'CtrlPTag'

    " tmux listens to ctrl-hjkl
    Plug 'christoomey/vim-tmux-navigator'

    " Sidebar with code tags
    Plug 'majutsushi/tagbar'
    nmap <C-t> :TagbarToggle<CR>

    " LaTeX continuous compilation
    Plug 'lervag/vimtex'
    let g:vimtex_view_method = 'skim'

    " LaTeX shortcuts
    Plug 'brennier/quicktex'

    " Easy surround
    Plug 'tpope/vim-surround'

    " C++ highlighting
    Plug 'octol/vim-cpp-enhanced-highlight'

    Plug 'aserebryakov/vim-todo-lists'
    let g:VimTodoListsMoveItems = 0

    Plug 'jamessan/vim-gnupg'


call plug#end()

map <Space> za

" use system clipboard
set clipboard=unnamed

" show 5 lines of context around cursor
set scrolloff=5

colorscheme onehalfdark
let g:airline_theme='onehalfdark'

" improve mode switch times
set timeoutlen=1000 ttimeoutlen=0

set mouse=a

let mapleader = ","
let maplocalleader = "\\"

set number         " display line numbers
set textwidth=0    " no linebreaking
set colorcolumn=80 " Show a red bar just past 79 chars
set shiftwidth=4   " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4      " a hard TAB displays as 4 columns
set expandtab      " insert spaces when hitting TABs
set smarttab

"""""""""""""""""""""""""""""""
" File type specific settings "
"""""""""""""""""""""""""""""""
filetype plugin on
" exempt make files from tab expansion
autocmd FileType make setlocal noexpandtab

" hard wrap at 79 columns in tex files
autocmd FileType tex setlocal textwidth=79

" use cppman for C++ reference
autocmd FileType cpp set keywordprg=cppman

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

""""""""""""""
" Key remaps "
""""""""""""""

" Use C-hjkl for window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Use these same keys in the terminal emulator
tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-W><C-H>
" Quickfix previous/next
noremap [q :cprev<CR>
noremap ]q :cnext<CR>
" Switch tabs with Ctrl + arrows
noremap <C-Left> :tabp<CR>
noremap <C-Right> :tabn<CR>
