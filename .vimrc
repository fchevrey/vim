inoremap ..		->
inoremap ...		...
iabbrev if 		if<space>()<enter>{<tab><enter>}<delete>
"<c-u>normal! F)vi(<cr>
iabbrev {}  		<enter>{<tab><enter>\<enter>}
"autocmd BufNewFile *.zz	ifndef<space>_H<enter>\<space>define<space>_H 
"autocmd BufNewFile *.h	execute normal! ipouet bufname("#")\<cr>' 
"autocommands
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o# define " . gatename . "\n"
  execute "normal! o#endif"
  execute "normal! kO\n"
endfunction
function! s:insert_class()
  let gatename = substitute(expand("%:r"), "\\.class", "", "g")
  execute "normal! iClass " . gatename
  execute "normal! o{"
  execute "normal! o\tpublic :"
  execute "normal! o\t\t" . gatename . "(void);"
  execute "normal! o\t\t~" . gatename . "(void);"
  execute "normal! o\tprivate :"
  execute "normal! o};"
endfunction

augroup CFile
	autocmd!
	autocmd BufNewFile *.h call <SID>insert_gates()
	autocmd BufNewFile *.hpp call <SID>insert_gates()
	autocmd BufNewFile *.class.hpp call <SID>insert_class()
augroup END
