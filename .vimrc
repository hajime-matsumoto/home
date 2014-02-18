" vim: set ft=vim
" 
" VIM seting file
"
" Author : Hajime MATSUMOTO <mail@hazime.org>
"

"
" commands
"
command! Ev edit $MYVIMRC " EDIT vimrc
command! Rv source $MYVIMRC " RELOAD vimrc

set nocompatible " disable compatible with vim
set modeline " use mode-line
set modelines=5 " mode-line efective lins are until 5
set showmode " show current mode
set showcmd " show current command
set autoread " autoread when other process rewrites
"set wildmenu " place of menu
set number " show line number
set title "show title

set swapfile " enable swapfile
set directory=/tmp " where swapfile store
set backup " enable backup
set backupdir=/tmp " where backupfile store
"set viminfo= " disable viminfo
set viminfo='50,\"1000,n"~/.viminfo " recent 50files info, 1000registers store in ~/.viminfo



" Remenver where you ware, when you leave this file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif


" f1 to esc for miss typing
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

set hlsearch " enable highlight when search words hit
set ignorecase " ignore capital or not
set smartcase " do not ignore capital when search words includs both

" escx2 swip highlights
nnoremap <ESC><ESC> :nohlsearch<CR><ESC> 

" move to next line ignore logical line
" move to prev line ignore logical line
nnoremap j gj
nnoremap k gk
set scrolloff=1000 " position fixed  to center

set mouse=a " enable mouse
set ttymouse=xterm2 " mouse can drag

set tabstop=4 " tab size is 4 space
set shiftwidth=4
set softtabstop=4

" tab sizes of file types
autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
autocmd FileType sass       setlocal sw=2 sts=2 ts=2 et
autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et

" auto indents
set autoindent
set smartindent
set cindent

" save tab to space
set expandtab
set smarttab

" enable plugin indent
filetype plugin indent on

" look and feel for status line
set showcmd
set laststatus=2
set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L

" encoding
set encoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,cp932,

" neo bandle
filetype off
if has('vim_starting')
  set runtimepath+=~/src/neobundle
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
filetype plugin indent on
" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

NeoBundle 'The-NERD-tree' " file explore
NeoBundle 'othree/html5.vim.git' " html5 syntac
NeoBundle 'h1mesuke/vim-alignta.git' " align
set ambiwidth=double
xnoremap <silent> a: :Alignta  01 :<CR>
xnoremap al :Alignta<Space>

NeoBundle 'tpope/vim-fugitive' " git
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

NeoBundle 'nathanaelkane/vim-indent-guides' " indent_guides
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=red ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'tpope/vim-surround'


" appearence
"source ~/.vimrc.appearence
"NeoBundle 'ujihisa/unite-colorscheme'
"NeoBundle 'ujihisa/unite-font'
"NeoBundle 'altercation/solarized'
"NeoBundle 'altercation/vim-colors-solarized'
"NeoBundle 'croaker/mustang-vim'
"NeoBundle 'jeffreyiacono/vim-colors-wombat'
"NeoBundle 'nanotech/jellybeans.vim'
"NeoBundle 'vim-scripts/Lucius'
"NeoBundle 'vim-scripts/Zenburn'
"NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'jpo/vim-railscasts-theme'
"NeoBundle 'therubymug/vim-pyte'
"NeoBundle 'tomasr/molokai'

"NeoBundle 'nanotech/jellybeans.vim'
"NeoBundle 'w0ng/vim-hybrid'
"NeoBundle 'vim-scripts/twilight'
"NeoBundle 'jonathanfilip/vim-lucius'
"NeoBundle 'jpo/vim-railscasts-theme'
"NeoBundle 'vim-scripts/Wombat'
"NeoBundle 'vim-scripts/rdark'

" カラースキーマ
"colorscheme molokai
"colorscheme jellybeans
"colorscheme hybrid
"colorscheme desert
colorscheme railscasts
