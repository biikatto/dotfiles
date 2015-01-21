setlocal foldmethod=syntax
" setlocal foldexpr=GetChuckFold(v:lnum)
setlocal foldtext=ChuckFoldText()

function! ChuckFoldText()
    return getline(v:foldstart)
endfunction

noremap <silent> <buffer> <leader>l :<C-u>silent !chuck --loop & > /dev/null 2>&1<C-r><CR><CR><C-l>
noremap <silent> <buffer> <leader>a :<C-u>silent !chuck + % > /dev/null 2>&1<C-r><CR><CR><C-l>
noremap <silent> <buffer> <leader>k :<C-u>silent !chuck --kill > /dev/null 2>&1<C-r><CR><CR><C-l>
noremap <silent> <buffer> <leader>r :<C-u>silent !chuck --remove.all > /dev/null 2>&1<C-r><CR><CR><C-l>
noremap <leader>s :<C-u> !chuck ^<CR>
noremap <leader>p :<C-u> !chuck --probe<CR>

" iabbrev { {<cr>}<esc>==k==A

" iabbrev if if(){<cr>x<cr>}<esc>=kA<backspace><esc>khxi


" function! GetChuckFold(lnum)
"     if getline(a:lnum) =~ '^\s*$'
"         return '-1'
"     endif
"     if getline(a:lnum) =~ '^\s*fun\s\+\w\+\s\+\w\+(.*)'
"         return '1'
"     endif
"     return '0'
" endfunction

" function! IndentLevel()
"     return indent(a:lnum) / &shiftwidth
" endfunction

" function! NextNonBlankLine(lnum)
"     let numlines = line('$')
"     let current = a:lnum + 1

"     while current <+ numlines
"         if getline(current) =~? '\S'
"             return current
"         endif

"         let current += 1
"     endwhile
    
"     return -2
" endfunction
