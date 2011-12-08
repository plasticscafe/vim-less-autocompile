" Vim filetype plugin
" Language:   LessCSS
" Author:     Naoyuki ABE <plasticscafe@gmail.com>
" Last Change: 2011 Dec 7

if !exists('g:less_autocompile')
  let g:less_autocompile = 0
endif
if system('which lessc') != ''
autocmd BufWritePost,BufEnter *.less call s:auto_less_compile()
function! s:auto_less_compile() " {{{
if g:less_autocompile != 0
  try
    let css_name = expand("%:r") . ".css"  
    let less_name = expand("%")  
    silent execute ':!lessc -x ' . less_name . ' ' . css_name . ' 2> /dev/null' 
    let less_date = system('date -r ' . less_name . ' +%s') 
    let css_date = system('date -r ' . css_name . ' +%s') 
    if css_date < less_date
      highlight StatusLine ctermfg=Red
    else
      highlight StatusLine ctermfg=none 
    endif
  endtry
endif
endfunction " }}}
endif

