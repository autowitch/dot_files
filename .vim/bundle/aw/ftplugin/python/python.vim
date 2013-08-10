setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
" setlocal textwidth=80
setlocal smarttab
setlocal expandtab


" !command Pyflakes :call Pyflakes()
" function! Pyflakes()
"     let tmpfile = tempname()
"     execute "w" tmpfile
"     execute "set makeprg=(pyflakes\\ " . tmpfile . "\\\\\\|sed\\ s@" . tmpfile ."@%@)"
"     make
"     cw
" endfunction

" !command Pylint :call Pylint()
" function! Pylint()
"     setlocal makeprg=(echo\ '[%]';\ pylint\ %)
"     setlocal efm=%+P[%f],%t:\ %#%l:%m
"     silent make
"     cwindow
" endfunction


" autocmd BufWrite *.{py} :call Pyflakes()


" :let w:m1=matchadd('Search', '\%<133v.\%>80v', -1)
" :let w:m2=matchadd('ErrorMsg', '\%>132v.\+', -1)

