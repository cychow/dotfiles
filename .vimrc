" oh boy a vimrc that doesn't blow, here we go
" File name in status
set statusline+=%f
set laststatus=2
set number
set ruler
set novisualbell
set encoding=utf-8
set nowrap
set autoindent
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set ttyfast
set clipboard=unnamed,unnamedplus
set mouse=a
set whichwrap+=<,>,h,l,[,]

syntax on

nnoremap Q <nop>

map q: :q

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
