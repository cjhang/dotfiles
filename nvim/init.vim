" Author: Jianhang Chen
" Release: 2017-01-28
" Update: 2020-01-12
" Version: 0.2.1
" Copyright: 2020 cjhang, all rights reserved 
" Email: cjhastro@gmail.com

"{{{Plugins 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')
"Plug list
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
Plug 'tmhedberg/SimpylFold'
Plug 'lervag/vimtex'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'
Plug 'ap/vim-css-color'
Plug 'hail2u/vim-css3-syntax'
Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'Konfekt/FastFold'

call plug#end()
filetype plugin indent on
"}}}

"{{{Basic Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" inherent from nvim-defaults, see :help nvim-defaults
" about split
set splitright
set splitbelow
" about tab and indent
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
" about searching
set ignorecase
" about backup
set nobackup
set swapfile
" about visual
syntax on
set number
set ruler
set wrap
set scrolloff=3  "leave three line at the bottom when scroll down
set mousemodel=popup
set mouse=a
set laststatus=2
set modeline
set fillchars=vert:\ ,fold:\   " make fold look more cleaner
set clipboard=unnamedplus
set bg=dark
colorscheme jellybeans
let g:airline_theme='jellybeans'
"}}}

"{{{VimR Special
if has("gui_vimr")
  set bg=light
	colorscheme github
	let g:airline_theme='github'
endif
"}}}

"{{{Some Special
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""set python3 virtual env, no need for install noevim for each env
let g:python3_host_prog = '/usr/local/bin/python3'

""to let the cursor stay at the same place as last time edit"
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
""make the fold more pretty
function! MyFoldText()
    let nl = v:foldend - v:foldstart + 1
    let comment = substitute(getline(v:foldstart),"^ *","",1)
    let linetext = substitute(getline(v:foldstart+1),"^ *","",1)
    let txt = comment . '+--' . nl
    return txt
  endfunction
"set foldtext=MyFoldText()
""highlitgh column if it exceed given column
highlight OverLength ctermbg=242 ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/  "enable in the following special group
"}}}

"{{{Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ','

"edit and source vimrc file
nnoremap <leader>ee :sp $MYVIMRC<cr>
nnoremap <leader>ss :source $MYVIMRC<cr>
"use very magic regrex for search
nnoremap / /\v
nnoremap ? ?\v
"clear the hlsearch patterns
nnoremap <leader>s :let @/=""<cr>
"find and replace
nnoremap ;; :1,$s:::gc<left><left><left><left>
"use esc to escape terminal-mode
tnoremap <Esc> <C-\><C-n>
"about moving between windows
nnoremap <C-down> <C-w>j
nnoremap <C-up> <C-w>k
nnoremap <C-left> <C-w>h
nnoremap <C-right> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"when invoke with terminal-emulator
tnoremap <C-down> <C-\><C-n><C-w>j
tnoremap <C-up> <C-\><C-n><C-w>k
tnoremap <C-left> <C-\><C-n><C-w>h
tnoremap <C-right> <C-\><C-n><C-w>l
"about moving when in insert mode
imap <M-h> <Left>
imap <M-l> <Right>
imap <M-j> <Down>
imap <M-k> <Up>
"}}}

"{{{FileType Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup nvim
    au!
    autocmd FileType vim set fdm=marker
    " open a new term://* session, auto start insert
    autocmd BufEnter term://* startinsert
augroup END

augroup python
    au!
    "autocmd FileType python match OverLength /\%81v.\+/
    autocmd FileType python let s:maxoff = 50 " maximum number of lines to look backwards.
    autocmd FileType python cabbrev ol match OverLength /\%1000v.\+/
augroup END

augroup markdown
    au!
    ""specify the template
    "autocmd BufNewFile *.mkd 0r ~/.config/nvim/templates/blog.template
    autocmd filetype markdown nnoremap <leader>s :setlocal spell spelllang=en_us<cr>
augroup END

augroup c
    au!
    autocmd Filetype c setlocal fdm=syntax
    "add ; at the end of the line
    autocmd filetype c nnoremap <leader>; mqA;<esc>`q
augroup END

augroup html
    au!
    autocmd BufNewFile,BufRead *.html set filetype=html
    autocmd filetype html set shiftwidth=2
augroup END

augroup css
    au!
    autocmd FileType css set shiftwidth=4
augroup END

augroup latex
    au!
    autocmd filetype tex nnoremap <leader>w :setlocal spell spelllang=en_us<cr>
    autocmd filetype tex nnoremap <leader>ww :setlocal nospell<cr>
augroup END

augroup bibtex
    au!
    autocmd BufNewFile,BufRead *.bib set filetype=bib
    autocmd FileType bib setlocal foldmethod=syntax
    autocmd FileType bib setlocal foldtext=MyFoldText()
augroup END
"}}}

"{{{Plugin Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{airline
"""""""""""
"let airline_theme='jellybeans'
if &background == 'light'
	let g:airline_theme='github'
elseif &background == 'dark'
  let g:airline_theme='jellybeans'
endif
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
"}}}

"{{{NERDTree
""""""""""""
"autocmd vimenter * NERDTree
"let loaded_nerd_tree=1
let NERDTreeChDirMode=1
map <C-t> :NERDTreeToggle<CR>
"cabbrev tree NERDTreeToggle
let NERDTreeShowBookmarks=1
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") 
            \ && b:NERDTree.isTabTree()) | q | endif
"}}}

"{{{syntastic-check
"""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
        \ "mode": "passive",
        \ "active_filetypes": ["c", "python"],
        \ "passive_filetypes": [] }
let g:syntastic_python_checkers = ['pyflakes']
"let g:syntastic_tex_checkers = ['lacheck']
"let g:syntastic_tex_chtex_quiet_messages = {
            "\ "!level": "warnings",
            "\ "type": "syntax",
            "\ "regex": '\v\CCommand\s+\s+\s+'}
"map <C-g> :SyntasticToggleMode<CR>
cabbrev st SyntasticToggleMode
"}}}

"{{{deoplete
let g:deoplete#enable_at_startup = 1
set completeopt+=noinsert
"}}}

"{{{ultisnips
"""""""""""""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:ultisnips_python_style='numpy'
"}}}

"{{{SimpyFold & FastFold
"""""""""""""
let g:SimpylFold_docstring_preview = 1
"}}}

"{{{vim-markdown
"""""""""""""
let g:vim_markdown_frontmatter = 1
"}}}

"{{{gitgutter
"""""""""""""
let g:gitgutter_max_signs = 1000
"}}}

"{{{vimtex
""""""""""
let g:tex_flavor = 'latex'
let g:vimtex_enabled = 1 
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_manual = 1
let  g:vimtex_fold_types = {
       \ 'envs' : {
       \    'blacklist' : ['eqution*','eqnarray*','align*'],
       \ },
       \}
let g:vimtex_complete_enabled = 1
let g:vimtex_toc_enabled = 0
let g:vimtex_imaps_enabled = 1 "default: 1
let g:vimtex_imaps_disabled = []
let g:vimtex_imaps_leader = '`'
let g:vimtex_index_split_pos = 'topleft'
let g:vimtex_mappings_enabled = 0
" for latexmk
let g:vimtex_compiler_enabled = 1
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_method = 'tectonic'
let g:vimtex_compiler_tectonic = {
    \ 'build_dir' : './_build',
    \ 'options' : [
    \   '--keep-logs',
    \   '--synctex'
    \ ],
    \}


let g:vimtex_compiler_latexmk = {
    \ 'backend' : 'nvim',
    \ 'background' : 1,
    \ 'build_dir' : './_build',
    \ 'callback' : 1,
    \ 'continuous' : 0,
    \ 'executable' : 'latexmk',
    \ 'options' : [
    \   '-pdf',
    \   '-bibtex',
    \   '-dvi',
    \   '-ps',
    \   '-silent',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

"let g:vimtex_latexmk_enabled = 1
"let g:vimtex_latexmk_build_dir = './_build'
"let g:vimtex_latexmk_continuous = 0
"let g:vimtex_quickfix_autojump = 0 "set to 0 if continuous is 1
"let g:vimtex_latexmk_backgroud = 0 "default
"let g:vimtex_latexmk_options = '-pdflatex="xelatex %O %S" -pdf -dvi- -ps- -silent'
"let g:vimtex_quickfix_ignore_all_warnings = 0 "default
"let g:vimtex_quickfix_mode = 1
let g:vimtex_quickfix_latexlog = {
      \ 'overfull' : 0,
      \ 'underfull' : 0,
      \ 'packages' : {
      \   'default' : 0,
      \ },
      \}
let g:vimtex_text_obj_enabled = 0
let g:vimtex_view_enabled = 1 "default
"let g:vimtex_view_method = 'atril-previewer'
let g:vimtex_view_automatic = 0
augroup texmap
    au!
    autocmd FileType tex nmap <leader>m <Plug>(vimtex-imaps-list)
    autocmd FileType tex nmap <leader>c :VimtexCompileSS<CR>
    autocmd FileType tex nmap <leader>v :VimtexView<CR>
    autocmd FileType tex nmap ]] <Plug>(vimtex-]])
    autocmd FileType tex nmap [[ <Plug>(vimtex-[[)
    autocmd filetype tex set shiftwidth=2
    set shiftwidth=2
    set tabstop=2
augroup END

"{{{FastFold
""""""""""""
let g:fastfold_fold_movement_commands = []
let g:fastfold_skip_filetypes= []
let g:fastfold_fold_command_suffixes = []
"}}}
"}}}
