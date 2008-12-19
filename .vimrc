set nocompatible

syntax on
filetype plugin indent on

" encoding
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

inoremap <C-t> <C-v><Tab>
"inoremap <C-h> <Left>
"inoremap <C-j> <Down>
"inoremap <C-k> <Up>
"inoremap <C-l> <Right>

" indent
set autoindent smartindent
set expandtab smarttab
set tabstop=4 softtabstop=4 shiftwidth=4

autocmd FileType ruby set tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.cgi  set filetype=perl
autocmd BufNewFile,BufRead *.tt   set filetype=xhtml
autocmd BufNewFile,BufRead *.as   set filetype=actionscript
autocmd BufNewFile,BufRead *.mxml set filetype=mxml

set showmatch
set number
set list
set listchars=tab:>-
set hidden
set wildmenu

" search
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
