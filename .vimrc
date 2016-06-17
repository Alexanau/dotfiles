runtime! ftplugin/man.vim

set ruler
set whichwrap+=>,<,h,l,[,]
set number
set autoindent
set tabstop=2
set backspace=2
set shiftwidth=2
set expandtab
syntax on       

"new escape mode
inoremap <ESC>h <Left>
inoremap <ESC>j <C-o>gj
inoremap <ESC>k <C-o>gk
inoremap <ESC>l <Right>
inoremap <ESC>H <C-o>^
inoremap <ESC>L <C-o>$
inoremap <C-H> <C-o>^
inoremap <C-L> <C-o>$
inoremap lkj <ESC>

nnoremap <ESC>H ^
nnoremap <ESC>L $
"move logical line inplace of physical ones
inoremap <NUL> <C-n>
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

nnoremap ; :
vnoremap ; :
"0"""""
  "1""""""""
    "2"""""""
  "1""""""
  "1""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
