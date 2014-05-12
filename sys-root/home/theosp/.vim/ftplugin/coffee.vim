set tabstop=2
set shiftwidth=2

" <S-e> compile and show output {{{
nnoremap <buffer> <silent> <S-e> :w<Cr>:!coffee -c %<Cr>:!vimcat %:p:r.js \| less -r; rm %:p:r.js<Cr>
