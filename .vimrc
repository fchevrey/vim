inoremap ..		->
inoremap ...		...
iabbrev cout		std::cout<space><<<space><<<space>std::endl;
iabbrev cin			std::cin<space>>><space>;
iabbrev getl		std::getline(std::cin,<space>);<enter>if<>space(std::cin.eof())<enter>return<space>;
iabbrev #i			#include
iabbrev #o			#include<space><iostream><enter>
iabbrev #s			#include<space><string><enter>
"iabbrev if 		if ()<cr>{<cr>}<Esc>2kf(a
"<c-u>normal! F)vi(<cr>
"iabbrev while 		while ()<cr>{<cr>}<Esc>2kf(a
"iabbrev {}  		<enter>{<tab><enter>\<enter>}
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
  execute "normal! iclass " . gatename
  execute "normal! o{"
  execute "normal! opublic :"
  execute "normal! o\t" . gatename . "(void);"
  execute "normal! o\t" . gatename . "(" . gatename . " const & src);"
  execute "normal! o\t~" . gatename . "(void);"
  execute "normal! o"
  execute "normal! o\t" . gatename . " &\toperator=(" . gatename . " const & rhs);"
  execute "normal! oprivate :"
  execute "normal! o};"
endfunction

augroup CFile
	autocmd!
	autocmd BufNewFile *.h call <SID>insert_gates()
	autocmd BufNewFile *.hpp call <SID>insert_gates()
	autocmd BufNewFile *.class.hpp call <SID>insert_class()
augroup END
