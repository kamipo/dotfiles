set nocompatible

syntax on
filetype plugin indent on

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,iso-2022-jp,cp932
set fileformats=unix,dos,mac

set ambiwidth=double
set backspace=indent,eol,start
set formatoptions+=m

highlight ZenkakuSpace cterm=underline ctermfg=lightblue
match ZenkakuSpace /　/

nnoremap <C-o> :<C-u>call append(expand('.'), '')<Cr>j

inoremap <C-t> <C-v><Tab>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
"inoremap <C-h> <Left>
"inoremap <C-l> <Right>

set autoindent smartindent
set expandtab smarttab
set tabstop=4 softtabstop=4 shiftwidth=4

au FileType ruby set tabstop=2 softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.cgi set ft=perl

set showmatch
set number
set list
set listchars=tab:>-
set hidden
set wildmenu

set wrapscan
set ignorecase
set smartcase
set hlsearch
set incsearch

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
