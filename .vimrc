" vim: set ft=vim ts=4 sw=4 sts=4  foldmethod=marker :
" 
" VIM seting file
"
" Author : Hajime MATSUMOTO <mail@hazime.org>
" 

" setting {{{
set nocompatible               " disable compatible with vim
set autoread                   " autoread when other process rewrites
set backspace=start,eol,indent " backspace to delete everything

set swapfile       " enable swapfile
set directory=/tmp " where swapfile store
set backup         " enable backup
set backupdir=/tmp " where backupfile store
set viminfo='50,\"1000,n"~/.viminfo " recent 50files info, 1000registers store in ~/.viminfo

set ignorecase " ignore capital or not
set smartcase  " do not ignore capital when search words includs both
set splitright
set splitbelow
set wrap
set textwidth=0


" restore last edited position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" }}}

" display {{{
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932

set hlsearch   " enable highlight when search words hit
set ruler
set title
set modeline                   " use mode-line
set modelines=5                " mode-line efective lins are until 5
set showmode                   " show current mode
set showcmd                    " show current command
set wildmenu                   " place of menu
set number                     " show line number
set scrolloff=8
syntax on
set t_Co=256
set lcs=tab:>-,trail:-,nbsp:%
set list
highlight SpecialKey cterm=NONE ctermfg=7 guifg=7
highlight JpSpace cterm=underline ctermfg=7 guifg=7
highlight FirstSpace cterm=underline ctermfg=7 guifg=7
au BufRead,BufNew * match JpSpace /　/
au BufRead,BufNew * match FirstSpace /^\s/
" }}}

" mouse {{{
set mouse=a " enable mouse
set ttymouse=xterm2 " mouse can drag
" }}}

" indent {{{
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set cindent
set noexpandtab
set nosmarttab
filetype plugin indent on
" }}}

" keybind {{{
nnoremap ZZ :wq
nnoremap ZQ <Nop>
nnoremap Q <Nop>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
inoremap jj <ESC>

set pastetoggle=<F2>
nnoremap <Space>m :<C-u>marks
nnoremap <Space>r :<C-u>register

nnoremap <Leader>v <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <ESC><ESC> :nohlsearch<CR><ESC> 

nnoremap ; :
let mapleader = ","
noremap \ ,
" }}}

" Programming {{{
set showmatch
set foldmethod=syntax
set grepprg=internal
autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
autocmd FileType sass       setlocal sw=2 sts=2 ts=2 et
autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
" }}}

" status line {{{
set showcmd
set laststatus=2
" }}}

" NeoBundle {{{
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
filetype on


NeoBundle 'othree/html5.vim.git'
NeoBundle 'tpope/vim-surround'
NeoBundle 'h1mesuke/vim-alignta.git' 
NeoBundle 'tpope/vim-fugitive' 


" quick run
NeoBundle 'thinca/vim-quickrun' 

" Shougo Series
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc',{'build': {'unix': 'make -f make_unix.mak'}}
NeoBundle 'Shougo/vimshell'
NeoBundle has('lua') ? 'Shougo/neocomplete': 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/neosnippet' 
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'szw/vim-tags'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'spolu/dwm.vim'
NeoBundle 'kannokanno/unite-dwm'
" }}}

" plugin setting {{{

if neobundle#is_installed('neocomplete')
	let g:neocomplcate#enable_at_startup=1
endif
if neobundle#is_installed('neocomplcache')
	let g:neocomplcache#enable_at_startup=1
endif

nnoremap [vimfiler] <Nop>
nmap <Leader>f [vimfiler]
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default= 0
nnoremap <silent> [vimfiler]i :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>

nnoremap [vimshell] <Nop>
nmap <Leader>s [vimshell]
nnoremap <silent> [vimshell]p :<C-u>VimShellPop<CR>
nnoremap <silent> [vimshell]b :<C-u>VimShellBufferDir -popup<CR>
nnoremap <silent> [vimshell]t :<C-u>VimShellTab<CR>
nnoremap <silent> [vimshell]rb :<C-u>VimShellInteractive irb<CR>
nnoremap <silent> [vimshell]py :<C-u>VimShellInteractive python<CR>
nnoremap <silent> [vimshell]my :<C-u>VimShellInteractive mysql -u root -p<CR>

nnoremap [unite] <Nop>
nmap <Leader>u [unite]
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]r :<C-u>UniteWithBufferDir -buffer-name=register register<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> [unite]d :<C-u>Unite dwm<CR>
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    " タブで開く
    nnoremap <silent> <buffer> <expr> <C-T> unite#do_action('tabopen')
    inoremap <silent> <buffer> <expr> <C-T> unite#do_action('tabopen')
    " vimfiler で開く
    nnoremap <silent> <buffer> <expr> <C-O> unite#do_action('vimfiler')
    inoremap <silent> <buffer> <expr> <C-O> unite#do_action('vimfiler')
    " dwm.vim で開く
    nnoremap <silent> <buffer> <expr> <C-N> unite#do_action('dwm_new')
    inoremap <silent> <buffer> <expr> <C-N> unite#do_action('dwm_new')
    " 終了
    nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
    inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
endfunction

nnoremap <c-j> <c-w>w
nnoremap <c-k> <c-w>W
nmap <m-r> <Plug>DWMRotateCounterclockwise
nmap <m-t> <Plug>DWMRotateClockwise
nmap <c-n> <Plug>DWMNew
nmap <c-c> <Plug>DWMClose
nmap <c-@> <Plug>DWMFocus
nmap <c-Space> <Plug>DWMFocus
nmap <c-l> <Plug>DWMGrowMaster
nmap <c-h> <Plug>DWMShrinkMaster
" }}} 
"color scheme
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
colorscheme jellybeans
"colorscheme railscasts
" use power line
NeoBundle 'Lokaltog/vim-powerline'
