" .vimrc
" David Hwang
" 08/18/2012

"Additional stuff for Windows vim
if has("unix")
	set nocompatible
else
	set nocompatible
	source $VIMRUNTIME/vimrc_example.vim
	source $VIMRUNTIME/mswin.vim
	behave mswin
	set diffexpr=MyDiff()
endif
function MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	let eq = ''
	if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
			let cmd = '""' . $VIMRUNTIME . '\diff"'
			let eq = '"'
		else
			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
		endif
	else
		let cmd = $VIMRUNTIME . '\diff'
	endif
	silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"primary file format is unix, dos, then mac
set fileformats=unix,dos,mac

"syntax highlighting if it can be done
if has('syntax') && (&t_Co > 2)
	syntax on
endif

set mouse=a     	"enable mouse
set visualbell t_vb=
set noerrorbells	"no errorbells
set showmode    "show mode at the bottom
set showcmd     "show partially typed commands
set ruler       "show line status at bottom
set number      "show line numbers
set showmatch   "show matching braces
set hlsearch	"highlights good

set wildmode=list:longest,full  "command line completion

set formatoptions-=t	"do not textwrap

"allows backspace over indents, eols
set backspace=indent,eol,start

"don't write backups
set nobackup
set nowritebackup
set noswapfile

set history=100	"history
set incsearch   "search as you type

filetype on     "recognize filetype
filetype indent on
filetype plugin on

set guioptions-=T

set cc=81
highlight ColorColumn ctermbg=darkgrey

"autoindent smartindent not set because it seems it's done automatically

"For normal stuff
autocmd FileType mail,human set formatoptions+=t ts=8 sw=8 noexpandtab

"For php TODO
autocmd FileType php set expandtab sw=4 sts=4 ts=4

"For perl [4 space tab] TODO test
autocmd FileType perl set noexpandtab ts=4 sts=4 sw=4

"For css [4 space tab]
autocmd FileType css set noexpandtab ts=4 sts=4 sw=4 

"For html/css [2 space expandtab] 
autocmd FileType html,xml set expandtab ts=2 sts=2 sw=2

"For c-style [4 space tab]
autocmd FileType c,cpp,java set noexpandtab ts=4 sts=4 sw=4

"For bash [4 space tab]
autocmd FileType bash,sh set noexpandtab ts=4 sts=4 sw=4

"For javascript [4 space tab] TODO
autocmd FileType javascript set noexpandtab ts=4 sts=4 sw=4

"For python
autocmd FileType python set expandtab ts=4 sts=4 sw=4

"For ruby
autocmd FileType ruby set expandtab ts=2 sts=2 sw=2 

"Launch pathogen
call pathogen#infect()

"Launch NERDtree when you are opening current directory
autocmd vimenter * if argc() == 0 | NERDTree | endif

"Key map CtrlP to ctrl-p 
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_extensions = ['tag']
let g:ctrlp_custom_ignore = {
	\ 'dir': '\.git$\|\.hg$\|\.svn$',
	\ 'file': '\.exe$\|\.so$\|\.dll$',
	\ }
