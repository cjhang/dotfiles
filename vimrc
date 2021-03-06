set encoding=utf-8

set nocompatible "not compatible with vi
syntax on
set number
set wrap
set scrolloff=3 "leave three line at the bottom when go to next page
set nobackup
set nowritebackup
set noswapfile
set showmatch
set mouse=a
set mousemodel=popup
set splitright
set splitbelow
"set textwidth=80
set autoindent
set smartindent
"set fdm=manual
set hlsearch
set incsearch
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set backspace=indent,eol,start " fix the delete key functions in macOS
set clipboard=unnamed
set bg=dark
"set bg=light
""}}}

"{{{Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ','
" edit add source vimrc file
nnoremap <leader>ee :sp $MYVIMRC<cr>
nnoremap <leader>ss :source $MYVIMRC<cr>
" find and replace
nnoremap ;; :1,$s:::gc<Left><Left><Left><Left>
"about moving between windows
"}}}
"
"
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
