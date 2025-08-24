set nocompatible

runtime bundle/vim-unbundle/unbundle.vim
runtime macros/matchit.vim

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

let g:ctrlp_map = '<c-o>'
let g:EnhCommentifyBindInInsert = 'No'
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=233
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235

au FileType sql  set timeoutlen=0
au FileType sh   set tabstop=2 softtabstop=2 shiftwidth=2
au FileType zsh  set tabstop=2 softtabstop=2 shiftwidth=2
au FileType ruby set tabstop=2 softtabstop=2 shiftwidth=2
au FileType yaml set tabstop=2 softtabstop=2 shiftwidth=2
au BufNewFile,BufRead *.schema set ft=ruby

let g:quickrun_no_default_key_mappings = 1
nmap <Leader>r <Plug>(quickrun)
vmap <Leader>r <Plug>(quickrun)

let g:go_version_warning = 0

let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['perl', 'php', 'ruby', 'javascript'],
                           \ 'passive_filetypes': [] }
