" vim: set ft=vim ts=4 sw=4 sts=4  foldmethod=marker :
" 
" VIM seting file
"
" Author : Hajime MATSUMOTO <mail@hazime.org>
"

"
" commands {{{
"
command! Ev edit $MYVIMRC " EDIT vimrc
command! Rv source $MYVIMRC " RELOAD vimrc
" }}}

" general {{{
set nocompatible " disable compatible with vim
set modeline " use mode-line
set modelines=5 " mode-line efective lins are until 5
set showmode " show current mode
set showcmd " show current command
set autoread " autoread when other process rewrites
set wildmenu " place of menu
set number " show line number
set title "show title

set swapfile " enable swapfile
set directory=/tmp " where swapfile store
set backup " enable backup
set backupdir=/tmp " where backupfile store
"set viminfo= " disable viminfo
set viminfo='50,\"1000,n"~/.viminfo " recent 50files info, 1000registers store in ~/.viminfo

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

set tabstop=4 " tab size is 4 space
set shiftwidth=4
set softtabstop=4

" tab sizes of file types 
autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
autocmd FileType sass       setlocal sw=2 sts=2 ts=2 et
autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
" }}}

" tips {{{
" Remenver where you ware, when you leave this file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif


" f1 to esc for miss typing
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" when insert mode type jj to nomal mode
inoremap jj <ESC>

" <F2> to pastetoggle
set pastetoggle=<F2>

" nomalmode semicolon is colon
nnoremap ; :

nnoremap <Space>m :<C-u>marks
nnoremap <Space>r :<C-u>register


" how to split
nnoremap <Leader>v <C-w>v<C-w>l

" how to move split
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" }}}

" Programming {{{
set showmatch
set foldmethod=syntax
set grepprg=internal
" }}}

set splitright
set splitbelow

" neo bandle scripts {{{
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
" }}}

NeoBundle 'yuratomo/gmail.vim'
"NeoBundle 'The-NERD-tree' " file explore
" * disable cose of using unite/vimfiler
NeoBundle 'othree/html5.vim.git' " html5 syntac
NeoBundle 'tpope/vim-surround'

NeoBundle 'h1mesuke/vim-alignta.git' " align {{{
set ambiwidth=double
xnoremap <silent> a: :Alignta  01 :<CR>
xnoremap al :Alignta<Space>
" }}}

NeoBundle 'tpope/vim-fugitive' " git {{{
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" }}}

NeoBundle 'nathanaelkane/vim-indent-guides' " indent_guides {{{
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=red ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
" }}}

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'

" unite settings for unite {{{
nnoremap [unite] <Nop>
nmap <Space>f [unite]

let g:unite_source_file_mru_limit = 50

let g:unite_enable_start_insert = 1
if executable('ack-grep')
    let g:unite_source_grep_command = 'ack-grep'
    let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
    let g:unite_source_recursive_opt = ''
endif

" bookmark save to home
let g:unite_source_bookmark_directory = $HOME . '/.unite/bookmark'


nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]r :<C-u>UniteWithBufferDir -buffer-name=register register<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>

autocmd FileType unite call s:unite_my_settings()
function s:unite_my_settings() 
    nmap <buffer> <ESC> <Plug>(unite_exit)
    imap <buffer> jj <Plug>(unite_insert_leave)
    nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
    inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
endfunction


" }}}

NeoBundle 'Shougo/vimfiler' " {{{
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default= 0
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
" }}}

NeoBundle 'Shougo/neocomplcache' " {{{
" See http://qiita.com/suzuken@github/items/95b8a7a0d007e6e09d78
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_under_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" }}}

NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neosnippet' " {{{
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

if has('conceal')
    set conceallevel=2 concealcursor=i
endif

let g:neosnippet#enable_snipmate_compatibility=1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets, ~/.vim/snippets'

" }}}

NeoBundle 'thinca/vim-quickrun' " {{{
augroup QuickRunPHPUnit
    autocmd!
    autocmd BufWinEnter,BufNewFile *test.php set filetype=php.unit
augroup END
let g:quickrun_config = {}
let g:quickrun_config['php.unit'] = {'command': 'phpunit'}
" }}}


" appearence {{{
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
" }}}

