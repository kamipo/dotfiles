set nocompatible

runtime bundle/vim-unbundle/unbundle.vim

syntax on
filetype plugin on
filetype indent on

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,iso-2022-jp,cp932
set fileformats=unix,dos,mac

set ambiwidth=double
set backspace=indent,eol,start
set formatoptions+=m
set list
set listchars=tab:>-,extends:<,trail:-
set number
set hidden

set wildmenu
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

inoremap <C-d> $
inoremap <C-a> @
inoremap <C-t> <C-v><Tab>

inoremap <C-c> <ESC>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap ; :

nnoremap <C-p> :bp<CR>
nnoremap <C-n> :bn<CR>

nnoremap ,.  :<C-u>edit $MYVIMRC<CR>
nnoremap ,s. :<C-u>source $MYVIMRC<CR>

source $VIMRUNTIME/macros/matchit.vim

let g:EnhCommentifyBindInInsert = 'No'

let g:ctrlp_map = '<c-o>'

au FileType sql  set timeoutlen=0
au FileType sh   set tabstop=2 softtabstop=2 shiftwidth=2
au FileType zsh  set tabstop=2 softtabstop=2 shiftwidth=2
au FileType cpp  set tabstop=2 softtabstop=2 shiftwidth=2
au FileType ruby set tabstop=2 softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.cgi  set ft=perl
au BufNewFile,BufRead *.psgi set ft=perl

map ,pt <Esc>:%! perltidy -se<CR>
map ,ptv <Esc>:'<,'>! perltidy -se<CR>

let g:quickrun_no_default_key_mappings = 1
nmap <Leader>r <Plug>(quickrun)
vmap <Leader>r <Plug>(quickrun)
