execute pathogen#infect()
let g:airline_theme='base16'
"let g:airline_theme='tomorrow'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" oh boy a vimrc that doesn't blow, here we go
" File name in status
"set statusline+=%f
"set laststatus=2
set hlsearch
set t_Co=256
set showtabline=2
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
"set ttyfast
set clipboard=unnamed,unnamedplus
set mouse=a
set whichwrap+=<,>,h,l,[,]
set wildmode=longest,list,full
set wildmenu

syntax on

nnoremap Q <nop>
nnoremap ; :
nmap <silent> <C-down> :bn<CR>
nmap <silent> <C-up> :bp<CR>
nmap <silent> <C-left> <C-W><C-H>
nmap <silent> <C-right> <C-W><C-L>


map q: :q

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions -=o
set formatoptions-=cro
