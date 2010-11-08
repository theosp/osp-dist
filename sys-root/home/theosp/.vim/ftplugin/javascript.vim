" <S-e> sudo execute the code using node.js {{{
nnoremap <buffer> <silent> <S-e> :w<Cr>:!sudo node %<Cr>
" }}}

" <S-c> for Checking the code with jslint {{{
    " get the full path to ./mylintrun.js - a script that reads js code from
    " stdin and validate it with jslint with customized options
    let s:mylintrun = expand('<sfile>:h') . "/javascript/mylintrun.js"

    " pre_mylintrun_filter is a python script we run on the js file before passing
    " it to mylintrun.js
    let s:pre_mylintrun_filter = expand('<sfile>:h') . "/javascript/mylintrun_filter.py"

    " set :make command
    let &makeprg = "cat % \\\| " . s:pre_mylintrun_filter . " \\\| node " . s:mylintrun . " %"
    " set the errorformat according to mylintrun.js errors output
    set errorformat=%f:%l:%c:%m

    nnoremap <buffer> <silent> <S-c> :w<Cr>:make<Cr>:cw<Cr>i
" }}}

" vim:fdm=marker:
