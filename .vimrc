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
set nocompatible               " disable compatible with vim
set modeline                   " use mode-line
set modelines=5                " mode-line efective lins are until 5
set showmode                   " show current mode
set showcmd                    " show current command
set autoread                   " autoread when other process rewrites
set wildmenu                   " place of menu
set number                     " show line number
set title                      " show title
set backspace=start,eol,indent " backspace to delete everything

set swapfile       " enable swapfile
set directory=/tmp " where swapfile store
set backup         " enable backup
set backupdir=/tmp " where backupfile store
set viminfo='50,\"1000,n"~/.viminfo " recent 50files info, 1000registers store in ~/.viminfo

set hlsearch   " enable highlight when search words hit
set ignorecase " ignore capital or not
set smartcase  " do not ignore capital when search words includs both

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
set noexpandtab
set nosmarttab

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
syntax on
set nowrap

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

NeoBundle 'thinca/vim-quickrun' " {{{
augroup QuickRunPHPUnit
    autocmd!
    autocmd BufWinEnter,BufNewFile *Test.php set filetype=php.unit
augroup END
let g:quickrun_config = {}
let g:quickrun_config['php.unit'] = {'command': 'phpunit'}
" }}}

NeoBundle 'Shougo/unite.vim' " {{{
NeoBundle 'Shougo/neomru.vim'
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
    nnoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
    inoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
    nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
    inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
endfunction


" }}}

NeoBundle 'Shougo/vimfiler' " {{{
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default= 0
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
" }}}

NeoBundle 'Shougo/vimproc',{'build': {'unix': 'make -f make_unix.mak'}}
NeoBundle 'Shougo/vimshell' " {{{
nnoremap <silent> <Leader>sp :<C-u>VimShellPop<CR>
"}}}

NeoBundle has('lua') ? 'Shougo/neocomplete': 'Shougo/neocomplcache' " {{{

if neobundle#is_installed('neocomplete')
	let g:acp_enableAtStartup = 0
	let g:neocomplete#enable_at_startup = 1
	let g:neocomplete#enable_smart_case = 1
	let g:neocomplete#sources#syntax#min_keyword_length = 3
	let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

	" Define dictionary.
	let g:neocomplete#sources#dictionary#dictionaries = {
				\ 'default' : '',
				\ 'vimshell' : $HOME.'/.vimshell_hist',
				\ 'scheme' : $HOME.'/.gosh_completions',
				\ 'php' : '~/src/dict/php.dict',
				\ }

	" Define keyword.
	if !exists('g:neocomplete#keyword_patterns')
		let g:neocomplete#keyword_patterns = {}
	endif
	let g:neocomplete#keyword_patterns['default'] = '\h\w*'

	" Plugin key-mappings.
	inoremap <expr><C-g>     neocomplete#undo_completion()
	inoremap <expr><C-l>     neocomplete#complete_common_string()

	" Recommended key-mappings.
	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function()
		return neocomplete#close_popup() . "\<CR>"
		" For no inserting <CR> key.
		"return pumvisible() ? neocomplete#close_popup() : "\<CR>"
	endfunction
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y>  neocomplete#close_popup()
	inoremap <expr><C-e>  neocomplete#cancel_popup()
	" Close popup by <Space>.
	"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

	" For cursor moving in insert mode(Not recommended)
	"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
	"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
	"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
	"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
	" Or set this.
	"let g:neocomplete#enable_cursor_hold_i = 1
	" Or set this.
	"let g:neocomplete#enable_insert_char_pre = 1

	" AutoComplPop like behavior.
	"let g:neocomplete#enable_auto_select = 1

	" Shell like behavior(not recommended).
	"set completeopt+=longest
	"let g:neocomplete#enable_auto_select = 1
	"let g:neocomplete#disable_auto_complete = 1
	"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

	" Enable heavy omni completion.
	if !exists('g:neocomplete#sources#omni#input_patterns')
		let g:neocomplete#sources#omni#input_patterns = {}
	endif
	"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
	"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

	" For perlomni.vim setting.
	" https://github.com/c9s/perlomni.vim
	let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
elseif neobundle#is_installed('neocomplcache')
	let g:neocomplcache#enable_at_startup = 1
	let g:neocomplcache#enable_ignore_case=1
	let g:neocomplcache#enable_smart_case = 1
	if !exists('g:neocomplcache#keyword_patterns')
		let g:neocomplcache#keyword_patterns={}
	endif
	let g:neocomplcache#keyword_patterns._ = '\h\w*'

endif


" }}}

"NeoBundle 'violetyk/neocomplete-php.vim' " {{{
"let g:neocomplete_php_locale = 'ja'
" :PhpMakeDict ja " only once
" }}}

NeoBundle 'Shougo/neosnippet' " {{{
NeoBundle 'Shougo/neosnippet-snippets'

"<TAB>: completion
inoremap <expr><TAB>	pumvisible() ? "\<C-p>": "\<S-TAB>"
"
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB> neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)": pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)": "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets, ~/.vim/snippets'
" }}}

NeoBundle 'szw/vim-tags' " {{{
"au BufNewFile,BufRead *.php let g:vim_tags_project_tags_command = "ctags --languages=php -f ~/php.tags `pwd` 2>/dev/null &"
" }}}

NeoBundle 'tsukkee/unite-tag' " {{{
autocmd BufEnter *
\  if empty(&buftype) 
\|	nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
\| endif

" }}}
NeoBundle 'spolu/dwm.vim' " タイルマネージャ {{{
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
 
" Unite 設定
noremap zp :Unite buffer_tab file_mru<CR>
noremap zn :UniteWithBufferDir -buffer-name=files file file/new<CR>
NeoBundle 'kannokanno/unite-dwm' " 拡張 {{{
noremap zp :Unite buffer_tab file_mru<CR>
noremap zn :UniteWithBufferDir -buffer-name=files file file/new<CR>
noremap zd :Unite dwm<CR>
 
autocmd FileType unite call s:unite_my_settings()
 
function! s:unite_my_settings()
    " 上下に分割して開く
    nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
    inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
    " 左右に分割して開く
    nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
    inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
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
" }}}
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


NeoBundle 'Lokaltog/vim-powerline'

