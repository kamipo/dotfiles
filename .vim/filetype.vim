" detect filetype
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  autocmd! BufRead,BufNewFile *.sql  setfiletype mysql
augroup END
