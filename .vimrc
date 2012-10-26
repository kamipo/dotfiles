set nocompatible

" add runtimepathe .vim/bundle/*
call pathogen#runtime_append_all_bundles()

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

highlight ZenkakuSpace cterm=underline ctermfg=lightblue
match ZenkakuSpace /　/

inoremap <C-t> <C-v><Tab>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
"inoremap <C-h> <Left>
"inoremap <C-l> <Right>

"nnoremap <C-l> <ESC>:ls<CR>
nnoremap <C-p> <ESC>:bp<CR>
nnoremap <C-n> <ESC>:bn<CR>

nnoremap <C-o> :<C-u>call append(expand('.'), '')<Cr>j

noremap j gj
noremap k gk
noremap gj j
noremap gk k

nnoremap ,.  :<C-u>edit $MYVIMRC<Enter>
nnoremap ,s. :<C-u>source $MYVIMRC<Enter>

nnoremap gc `[V`]
vnoremap gc :<C-u>normal gc<Enter>
onoremap gc :<C-u>normal gc<Enter>

au FileType sql  set timeoutlen=0
au FileType sh   set tabstop=2 softtabstop=2 shiftwidth=2
au FileType zsh  set tabstop=2 softtabstop=2 shiftwidth=2
au FileType cpp  set tabstop=2 softtabstop=2 shiftwidth=2
au FileType ruby set tabstop=2 softtabstop=2 shiftwidth=2
au FileType perl compiler perl
au BufNewFile,BufRead *.cgi  set ft=perl
au BufNewFile,BufRead *.psgi set ft=perl

function! GetStatusEx()
    let str = &fileformat
    if has("multi_byte") && &fileencoding != ""
        let str = &fileencoding . ":" . str
    endif
    let str = "[" . str . "]"
    return str
endfunction
