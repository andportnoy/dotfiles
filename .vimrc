call plug#begin()
	Plug 'christoomey/vim-tmux-navigator'
call plug#end()

map <C-n> :bn<CR>
map <C-p> :bp<CR>

syntax off

set wildmenu
set colorcolumn=81
highlight ColorColumn ctermbg=237
set autoindent
set backspace=indent,eol,start
set hlsearch
set splitbelow
set splitright
set mouse=a
set timeoutlen=0
set ttimeoutlen=0
autocmd FileType markdown set textwidth=80
let g:netrw_banner = 0
set wildmode=longest:full,full
set hidden
set background=dark

filetype plugin on
