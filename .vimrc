call plug#begin()
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'sonph/onehalf', {'rtp': 'vim'}
call plug#end()

map <C-n> :Ex<CR>

colorscheme onehalfdark
syntax enable

set laststatus=2
set statusline=%m\ %f%=\ %l:%L
set wildmenu
set scrolloff=5
set colorcolumn=81
set autoindent
set backspace=indent,eol,start
set hlsearch
set incsearch
set ic
set splitbelow
set splitright
