set nocompatible

" Plugin settings must come before unbundle: it sources every
" bundle/*/plugin/*.vim right away, and plugins read these at load time.
let g:ale_linters_explicit = 1
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_linters = {
\   'ruby':       ['rubocop'],
\   'javascript': ['eslint'],
\ }
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0

runtime bundle/vim-unbundle/plugin/unbundle.vim
runtime macros/matchit.vim
packadd comment

syntax on
filetype plugin on
filetype indent on

colorscheme jellybeans

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,iso-2022-jp,cp932
set fileformats=unix,dos,mac

set backspace=indent,eol,start

set ambiwidth=double
set formatoptions+=m
set list
set listchars=tab:>-,extends:<,trail:-
set number
set hidden

set wildmenu
set wildoptions=fuzzy
set path+=**
set showmatch

set wrapscan
set ignorecase
set smartcase
set incsearch
set hlsearch

set autoindent
set smartindent
set expandtab
set smarttab

set tabstop=4
set softtabstop=4
set shiftwidth=4

set directory=~/.vim/tmp

set laststatus=2
set statusline=[%n]\ %t\ %y%{GetStatusEx()}\ %m%h%r=%l/%L,%c%V\ %P

function! GetStatusEx()
    let str = &fileformat
    if has("multi_byte") && &fileencoding != ""
        let str = &fileencoding . ":" . str
    endif
    let str = "[" . str . "]"
    return str
endfunction

highlight ZenkakuSpace cterm=underline ctermfg=lightblue
match ZenkakuSpace /　/

inoremap <C-t> <C-v><Tab>

inoremap <C-c> <ESC>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

noremap <Space>h ^
noremap <Space>l $

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap ; :

nnoremap <C-p> :bp<CR>
nnoremap <C-n> :bn<CR>

nnoremap ,.  :<C-u>edit $MYVIMRC<CR>
nnoremap ,s. :<C-u>source $MYVIMRC<CR>

au FileType sql  set timeoutlen=0
au FileType sh   set tabstop=2 softtabstop=2 shiftwidth=2
au FileType zsh  set tabstop=2 softtabstop=2 shiftwidth=2
au FileType ruby set tabstop=2 softtabstop=2 shiftwidth=2
au FileType yaml set tabstop=2 softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.schema set ft=ruby

nmap <Leader>c gccj
nmap <Leader>x gcc
