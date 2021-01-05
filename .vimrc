call plug#begin('~/.vim/plugged')


Plug 'https://github.com/frazrepo/vim-rainbow'
Plug 'itchyny/lightline.vim'
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/kana/vim-smartinput'
Plug 'https://github.com/sheerun/vim-polyglot'
Plug 'https://github.com/preservim/nerdcommenter'

call plug#end()

au FileType c,js,cpp,objc,py call rainbow#load()
set number

set laststatus=2

if !has('gui_running')
  set t_Co=256
endif


nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <tab> <C-w>w

nnoremap <silent> <F8> :exe "vertical resize +5" <CR>
nnoremap <silent> <F5> :exe "vertical resize -5" <CR>
nnoremap <silent> <F7> :exe "resize +5" <CR>
nnoremap <silent> <F6> :exe "resize -5" <CR>

execute 'autocmd VimEnter * NERDTree' 
set tabstop=4
