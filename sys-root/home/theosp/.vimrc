set nocompatible
set history=50		             " keep 50 lines of command line history
set backup

set backupdir=~/.vim/backup
set directory=~/.vim/tmp

set backspace=2

set magic " Allows pattern matching with special characters. (Example :%s/,/ /g)

set modeline

" auto completions
setlocal omnifunc=syntaxcomplete#Complete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" bash like tab completion
set wildmode=longest,list,full
set wildmenu

" Display Options
syntax on
set ruler		                 " show the cursor position all the time
set showmatch                    " When a bracket is inserted, briefly jump to the matching one
set number                       " Print the line number in front of each line
set background=dark              " When set to "dark", Vim will try to use colors that look good
                                 " on a dark background.
set visualbell t_vb=             " When no beep or flash is wanted, use ":set vb t_vb=".
                                 " Tabs to spaces

set nohlsearch                   " Disable search result highlighting

if $TERM == 'rxvt-256color'
    set t_Co=256                     " Set vim to 256 color mod
endif

colorscheme desert256            " For more info about set

" Tabs options
set expandtab                    " In Insert mode: Use the appropriate number of spaces to insert
                                 " a <tTab>
set tabstop=4                    " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=4                 " Number of spaces to use for each step of (auto)indent.

" File type specific auto indent
if has("autocmd")
  filetype indent on
  filetype plugin on " Enable ftplugins
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Keyboard shortcuts
    "Ctrl [hjkl] move between windows
    noremap <C-J> <C-W>j
    noremap <C-K> <C-W>k
    noremap <C-H> <C-W>h
    noremap <C-L> <C-W>l

    "    noremap <C-I> <C-A>

    " command line php file execution by '\p'
    autocmd FileType php noremap <Leader>p :w<CR>:!php % \| less<CR>
    autocmd FileType php noremap <Leader>c :w<CR>:!php -l % \| less<CR>

" Command line shortcuts
    " Allow to use :w!! to write to a file using sudo if you forgot to "sudo vim file" 
     cmap w!! %!sudo tee > /dev/null % 

" Search Options:
set ignorecase

map <F3> :set invrl<CR>
map <F4> :set invspell<CR>

" Plugins Options
    " NERDTree options
    let NERDTreeWinPos = "right"
    map <F2> :NERDTreeToggle<CR>
    " SuperTab Options
    let g:SuperTabMappingBackward   = '<tab>'
    let g:SuperTabMappingForward    = '<k-tab>'
    let g:SuperTabMappingTabLiteral = '<s-tab>'
    
    let g:html_indent_inctags = "html,body,head,tbody"
" About 256-color xterm in ubuntu:
" check: http://push.cx/2008/256-color-xterms-in-ubuntu :
" sudo aptitude install ncurses-term
" Add the following to .Xdefaults:
"    *customization: -color
"    XTerm*termName:  xterm-256color
" call: $ xrdb -merge ~/.Xdefaults
" colors verify that `tput` returns 256
" Add the following to .screenrc :
"    # terminfo and termcap for nice 256 color terminal
"    # allow bold colors - necessary for some reason
"    attrcolor b ".I"
"    # tell screen how to set colors. AB = background, AF=foreground
"    termcapinfo xterm 'Co#256:AB=\E[48;5;%dm:AF=\E[38;5;%dm'
"    # erase background with current bg color
"    defbce "on" 
"    # set TERM
"    term screen-256color-bce
" Add the following to .vimrc
"    set t_Co=256                     " Set vim to 256 color mod
"    colorscheme desert256            " For more info about set
imap <silent> <Leader><Leader>s <C-R>=system('s')<CR>

"vmap \g x<Esc>i<?php echo __('<Esc>pa'); ?><Esc>
vmap \g x<Esc>i<?=__('<Esc>pa'); ?><Esc>

function! HTMLEncode()
    perl << EOF
    use HTML::Entities;
    @pos = $curwin->Cursor();
    $line = $curbuf->Get($pos[0]);
    $encvalue = encode_entities($line);
    $curbuf->Set($pos[0],$encvalue)
EOF
endfunction

function! HTMLDecode()
    perl << EOF
    use HTML::Entities;
    @pos = $curwin->Cursor();
    $line = $curbuf->Get($pos[0]);
    $encvalue = decode_entities($line);
    $curbuf->Set($pos[0],$encvalue)
EOF
endfunction

map <Leader>he :call HTMLEncode()<CR>
map <Leader>hd :call HTMLDecode()<CR>
map <Leader>hp :call HtmlTagEncloseP()<CR>
vmap <Leader>ha :call HtmlTagEncloseA()<CR>

map <Leader>sh :set filetype=html<CR>

" Temp
map <Leader>1e :!update-dng eng<CR>
map <Leader>1s :!update-dng spa<CR>
map <Leader>1p :!update-dng por<CR>
map <Leader>1g :!update-dng ger<CR>
map <Leader>1i :!update-dng ita<CR>

map <Leader><Leader> "0p

map ++ "+y
map -- "+p
" My work :)
"
" string function GetFileName()
" int function FunctionExists( string functionName )
" string function GetFileExtension( [ string filename = <currentBufferFilename>, [ int extensionsCount = 1 ] ] )
" void ExtensionSpecificCompileAndRun()

" The following return the current buffer's file name
" --~~~~ Daniel Chcouri :: 2009-09-05 23:09:41
function! GetFileName()
    let filename = bufname("%")

    return filename
endfunction

" return 1 if function exists 0 if not
function! FunctionExists(functionName)
    try
        call function(a:functionName)
    catch /E700.*/ " E700 raised when the function doesn't exists
        return 0
    endtry

    return 1
endfunction

" Description:
" string function GetFileExtension( [ string filename = <currentBufferFilename>, [ int extensionsCount = 1 ] ] )
"
" Returns the first extension for filename.
"
" For files that begins with '.', we return all the name after the dot.
"
" Parameters:
" filename: The filename for which we return the extension. by default set to the current buffer filename.
" extensionCount: The amount of extensions to return, by default set to 1. 
"
" Return Values:
" A string with the extension.
"
" Examples:
" GetFileExtension( "file.inc.php" ) => `php`
" GetFileExtension( "file.inc.php", 2 ) => `inc.php`
" GetFileExtension( ".vimrc", 2 ) => `vimrc`
"
" --~~~~ Daniel Chcouri :: 2009-09-06 00:11:03
function! GetFileExtension( ... )
    " Only 1 argument allowed
    if( a:0 > 2 )
        throw "GetFileName() Error, wrong arguments count: GetFileExtension( (int)extensionsCount )"
    endif

    " set defults
    let filename = GetFileName() " The current buffer filename 
    let extensionsCount = 1
    if(a:0 > 0)
            let filename = a:1 
        if(a:0 > 1)
            let extensionsCount = a:2
        endif
    endif

    let filenameModifier = "" 

    while extensionsCount > 0
        let filenameModifier .= ":e"

        let extensionsCount -= 1
    endwhile

    " for files that begins with '.' we returns all the name after the '.'
    if(filename[0] == '.')
        return strpart(filename, 1)
    endif

    " Try extracting the extension using fnamemodify
    let extension = fnamemodify(filename, filenameModifier)
    
    return extension 
endfunction

" This function compile and run the current buffer according to it's extension .
" since we can't use a function to source a file with the same function name
" we first check the function doesn't set before we load it, (in order to be
" able to reload this file without restarting vim)
if(!FunctionExists("ExtensionSpecificCompileAndRun"))
    function ExtensionSpecificCompileAndRun()
        let extension = GetFileExtension() " Get the current buffer extension
        
        try
            throw extension
        catch 'php'
            !php %
        catch 'vimrc'
            source % " actually it's impossible to reload fu
        catch /.*/ " Default, unknown filetype
            echo 'No compile and run routine set for this filetype'
        endtry
    endfunction
endif

"
" Html related functions 
"
function! HtmlTagEncloseP () range
    try
        execute a:firstline . "," . a:lastline . "s/^\\(\\s*\\)\\(.\\+\\)$/\\1<p>\\2<\\/p>/g"
    catch /.*/ " If this isn't visual mod
        normal i<p></p>
    endtry
endfunction

function! HtmlTagEncloseH (level) range
    execute a:firstline . "," . a:lastline . "s/^\\(\\s*\\)\\(.\\+\\)$/\\1<h" . a:level . ">\\2<\\/h" . a:level . ">/g"
endfunction

function! HtmlTagEncloseA () range
" Note: expecting mod to be visual

    try
        throw visualmode()
        catch 'v'
            silent exec "normal! `<v`>x`<i<a href=\"\">gpa</a>`<"
            call search("\"\"")
        catch 'V'
            silent exec "normal! `<^v`>hx^a<a href=\"\">gpa</a>`<h"
            call search("\"\"")
        catch /.*/ " Visual block 
            echo "HtmlTagEncloseA Doesn't work with visual block mode"
    endtry
endfunction

function! HtmlTagEncloseLi () range
    execute a:firstline . "," . a:lastline . "s/^\\(\\s*\\)\\(.\\+\\)$/\\1<li>\\2<\\/li>/g"
endfunction

" Text manipulations functions
function! PrepareTextForHtml_Range () range
    " Call CleanText_Range() for the range
    execute a:firstline . "," . a:lastline . " call CleanText_Range ()"

    try
        execute a:firstline . "," . a:lastline . "s/[“”]/\"/g"
    catch
    endtry

    try
        execute a:firstline . "," . a:lastline . "s/’/\'/g"
    catch
    endtry

    try
        execute a:firstline . "," . a:lastline . 's/&/&amp;/g'
    catch
    endtry
endfunction

function! PrepareTextForHtml ()
    " I'm calling the non-range version of CleanText
    " even though CleanText_Range is being called on PrepareTextForHtml()
    " which we call later, because CleanText() also take care over the
    " empty lines at the EOF
    call CleanText()

    execute "0," . line("$") . " call PrepareTextForHtml_Range ()"
endfunction

function! CleanText_Range () range
    " Delete spaces in the EOL
    try
        execute a:firstline . "," . a:lastline . 's/\s\+$//g'
    catch
    endtry

    " Replace multiple spaces with single
    try
        execute a:firstline . "," . a:lastline . 's/\s\+/ /g'
    catch
    endtry

    " Replace more than three new lines with two
    try
        execute a:firstline . "," . a:lastline . 's/\n\{3,\}//g'
    catch
    endtry
endfunction

function! CleanText ()
        execute "0," . line("$") . " call CleanText_Range ()"

        " Delete empty lines at the EOF
        while getline("$") =~ "^\s*$"
            normal Gdd
        endwhile
endfunction

function! CleanHtml()
    %s/<style.\{-}>\_.\{-}<\/style>//g
    %s/<script.\{-}>\_.\{-}<\/script>//g
    %s/<.\{-}>//g
endfunction

" Folding shortcuts
map <buffer> f za
map <buffer> F :call ToggleFold()<CR>
let b:folded = 1

function! ToggleFold()
    if( b:folded == 0 )
        exec "normal! zM"
        let b:folded = 1
    else
        exec "normal! zR"
        let b:folded = 0
    endif
endfunction

" Save file's current folding on window close and reload it next time
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

" auto formatting settings (:help fo-table):
" For auto-wrapping add t
set formatoptions=croql

set textwidth=79

" Set window's minimal height
set wh=40
