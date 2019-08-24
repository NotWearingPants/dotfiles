syntax on
colorscheme industry

set nocompatible noswapfile
set encoding=utf-8
set number " relativenumber
set spelllang=en_us
set showtabline=2
set laststatus=2
set showmode showcmd ruler
set incsearch hlsearch ignorecase smartcase
set shiftwidth=0 tabstop=4
set noexpandtab autoindent shiftround smarttab
set numberwidth=4
set scrolloff=3
set nowrap
set wildmenu
set backspace=indent,eol,start
set autoread
set mouse=a
set clipboard^=unnamed,unnamedplus
set title
set cursorline
" :h 'shortmess'

command! Q q
command! W w

let mapleader=","
nnoremap ; :
nnoremap <silent> <leader>% :source $MYVIMRC<Enter>
nnoremap <silent> <leader>rc :tabnew $MYVIMRC<Enter>
nnoremap <silent> <leader>sp :set spell!<Enter>
nnoremap <silent> <leader>q :confirm q<Enter>
nnoremap <silent> <leader>w :w<Enter>
nnoremap <silent> <leader>l :noh<Enter>
nnoremap <silent> <leader>t :tabnew<Enter>
nnoremap <leader>e :e 
" nnoremap <silent> <leader><leader> ???

set guifont=Courier_New:h16:cANSI " or Consolas?
set guioptions-=t
set guioptions-=T
set guioptions-=m
set guioptions-=e
set guioptions+=c

highlight Normal guibg=#181818 guifg=white gui=none
highlight TabLine guibg=#282828 guifg=white gui=none
highlight TabLineSel guibg=NONE guifg=white gui=none
highlight TabLineFill guibg=black gui=none
highlight CursorLine guibg=Grey12 " gui=bold
highlight StatusLine guibg=Grey15 guifg=Grey80 gui=bold

let MODES = {
	\'n': 'NORMAL',
	\'i': 'INSERT',
	\'v': 'VISUAL',
	\'V': 'V-LINE',
	\'R': 'REPLACE',
\}

set statusline=%1*\ %{get(MODES,mode(1),mode(1))}\ %*\ %f\ %h%m%r%<%=%2*%{&spell?'[SPL]':''}%*\ <%v>\ L%l/%L\ 
" \u25B6 \u25BA
highlight User1 gui=reverse,bold
highlight User2 gui=none guifg=yellow guibg=Grey15
