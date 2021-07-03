call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'frazrepo/vim-rainbow'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'kana/vim-smartinput'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdcommenter'
Plug 'dense-analysis/ale'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'sillybun/vim-repl'

call plug#end()
"au VimEnter *  :exe 'NERDTree' | :exe 'RainbowLoad'  | :exe 'wincmd w'
au VimEnter * NERDTree | wincmd p
au BufReadPost,BufNew,BufNewFile * :exe 'RainbowLoad'
set encoding=UTF-8

"Leave NERDTree if it's the only window left open
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

"prevent other buffers from being opened in the NERDTree window
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

"have the same NERDTree window open in all tabs
autocmd BufWinEnter * silent NERDTreeMirror


if !has('gui_running')
  set t_Co=256
endif


"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable
set foldlevel=1         "this is just what i use

let mapleader = ' '
nnoremap <F9>m <C-w>1|
nnoremap <F10>M <C-w>|
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <tab> <C-w>w
nnoremap <C-w>] <C-w>]<C-w>H<C-w>R

nnoremap <silent> <F8> :exe "vertical resize +5" <CR>
nnoremap <silent> <F5> :exe "vertical resize -5" <CR>
nnoremap <silent> <F7> :exe "resize +5" <CR>
nnoremap <silent> <F6> :exe "resize -5" <CR>
nnoremap <silent> <F6> :exe "resize -5" <CR>
nnoremap <F2> :exe "NERDTreeToggle" <CR>

set tabstop=4
set nu rnu
set laststatus=2
set background=light
let g:ale_fixers = {
\  '*' : ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript' : ['eslint'],
\  'python': ['add_blank_lines_for_python_control_statements', 'autoimport', 'autopep8', 'isort', 'yapf']
\}
highlight ALEWarningSign ctermbg = Black
highlight ALEErrorSign ctermbg = Black
highlight ALEError ctermbg = grey
highlight ALEWarning ctermbg =grey
highlight SignColumn ctermbg =Black

highlight Folded ctermfg=Black
highlight Folded ctermbg=DarkGrey
"highlight LineNr ctermfg=DarkGrey
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

let g:ale_sign_error = '⛔️'
let g:ale_sign_warning = '🔔'
let g:ale_python_pylint_options='--max-line-length=180'
let g:ale_python_flake8_options='--max-line-length=180'
let g:ale_fix_on_save = 1

command! Pyrun !python3 '%'
colorscheme gruvbox
set bg=dark
highlight Normal ctermbg=None

" REPL Python config from repository
let g:repl_program = {
            \   'python': 'ipython',
            \   'default': 'bash',
            \   'r': 'R',
            \   'lua': 'lua',
            \   'vim': 'vim -e',
            \   }
let g:repl_predefine_python = {
            \   'numpy': 'import numpy as np',
            \   'matplotlib': 'from matplotlib import pyplot as plt'
            \   }
let g:repl_cursor_down = 1
let g:repl_python_automerge = 1
let g:repl_ipython_version = '7'
let g:repl_output_copy_to_register = "t"
nnoremap <leader>r :REPLToggle<Cr>
nnoremap <leader>e :REPLSendSession<Cr>
autocmd Filetype python nnoremap <F12> <Esc>:REPLDebugStopAtCurrentLine<Cr>
autocmd Filetype python nnoremap <F10> <Esc>:REPLPDBN<Cr>
autocmd Filetype python nnoremap <F11> <Esc>:REPLPDBS<Cr>
let g:repl_position = 3
