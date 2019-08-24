" settings
autocmd!
syntax on
" TODO: do not set colorscheme when on macOS, it works without it and loses colors with it
colorscheme pablo "slate murphy torte zellner
set hlsearch incsearch ignorecase smartcase
nohlsearch
set number relativenumber
set showmode showcmd ruler
set tabstop=4 shiftwidth=4 autoindent smartindent cpoptions-=I
set backspace=indent,eol,start
set showtabline=2
set scrolloff=4
set nowrap
set autoread
set title
set splitbelow splitright
set foldenable foldmethod=indent foldlevelstart=9999
set wildmenu wildchar=<Tab>
set mouse=a
set clipboard^=unnamed
set keymodel+=startsel
set ttimeoutlen=0
set noswapfile

" gui settings
set guifont=Consolas:h15:cANSI
set guioptions+=c
set guioptions-=t
set guioptions-=T
set guioptions-=m
set guioptions-=e
highlight Normal guibg=#242424
highlight Visual guibg=#484848
highlight Special guifg=#0080ff
highlight Comment ctermfg=8 guifg=#808080 " change ctermfg to 6 (cyan)?
highlight Statement ctermfg=3 " change ctermfg to 1? keep Label's ctermfg 3? (it is linked)
highlight LineNr guifg=#909090
highlight CursorLineNr guibg=#333333
highlight clear NonText
highlight link NonText LineNr
highlight Folded guibg=#303030
highlight CursorLine guibg=NONE

" don't bother me about capitals when quitting or saving
command! Q q
command! W w

" make it clear what tab is selected
highlight TabLine guibg=#404040 term=reverse cterm=reverse gui=NONE
highlight TabLineSel guibg=NONE gui=NONE
highlight TabLineFill guibg=black gui=NONE

" make the status line more visible
highlight StatusLine cterm=reverse ctermbg=black
highlight StatusLineNC guifg=white guibg=#2C2C2C gui=NONE
" change status bar color in insert mode
autocmd InsertEnter * highlight StatusLine ctermfg=2 guibg=#bbee1d guifg=#333333
autocmd InsertLeave * highlight StatusLine ctermfg=7 guibg=#545454 guifg=white
doautocmd InsertLeave

" wildmenu cyan highlight
highlight WildMenu ctermbg=cyan

" current cursor line in bold
set cursorline
highlight CursorLine cterm=bold

" completion menu black and white
highlight Pmenu ctermbg=black ctermfg=black cterm=bold
highlight PmenuSel ctermbg=white ctermfg=black cterm=NONE

" matching paren in green
highlight MatchParen cterm=bold ctermfg=green ctermbg=NONE

" see whitespace at the end of a line in red
highlight link endSpaces SpellBad
autocmd InsertEnter * syntax clear endSpaces
autocmd InsertEnter * syntax match endSpaces /\(\%#.\+\)\@<!\(\%#\@!\s\)\+\%#\@!$/
autocmd InsertLeave * syntax clear endSpaces
autocmd InsertLeave * syntax match endSpaces /\s\+$/
syntax match endSpaces /\s\+$/

" see 80th character in a line instead of a full column
syntax match ColorColumn /\%80v./

" no shift for command
noremap ; :

" save with F12
noremap <F12> :w<Enter>

" quit with F9
noremap <F9> :confirm q<Enter>

" remove last search highlights with F4
noremap <silent> <F4> :nohlsearch<Enter>

" edit .vimrc with F8
noremap <F8> :tabnew $MYVIMRC<Enter>

" reload .vimrc with F7
noremap <F7> :source $MYVIMRC<Enter>

" completion in insert with Ctrl+Space
inoremap <C-@> <C-x><C-U>

" disable Ex mode (type visual to go to normal mode)
noremap Q <Nop>

" simple split switching
"noremap <C-S-H> <C-W>h
"noremap <C-S-J> <C-W>j
"noremap <C-S-K> <C-W>k
"noremap <C-S-L> <C-W>l

" scroll with ctrl+j/k
noremap <C-K> <C-Y>
noremap <C-J> <C-E>
" tab switching with ctrl+h/l
noremap <C-H> gT
noremap <C-L> gt

" status line
set laststatus=2 statusline=\ %{mode(1)}\ \|\ %<%f%h%m%r%=<%v>\ %l\ /\ %L\ Lines
" to see all modes, :h vim-modes

" syntax and highlight check
noremap <leader>syn :echo 'Highlight Groups: ' . join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), ', ')<Enter>

" complete filenames
fun! CompleteFilenames(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a'
            let start -= 1
        endwhile
        return start
    else
        " find filenames matching with "a:base"
        let res = []
        for m in split(system("ls"), "\n")
            if m =~ '^' . a:base
                call add(res, m)
            endif
        endfor
        return res
    endif
endfun
set completefunc=CompleteFilenames

" color test
function! ColorTest(w, h)
    tabnew
    execute "normal! i#\<Esc>dl".a:w."pdd".a:h."pkdd"
    set buftype=nofile readonly

    for i in range(a:w * a:h)
        execute "syntax match color".i." '\\%".(i / a:w + 1)."l\\%".(i % a:w + 1)."c.'"
        execute "highlight color".i." ctermfg=".i." ctermbg=".i
    endfor

    redraw
    echo "Remember to set t_Co!"
endfunction
