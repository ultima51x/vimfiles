" .vimrc
" David Hwang

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

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

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

"check dir of current file first then go back; check current working directory
set tags=./tags;

"don't write backups
set nobackup
set nowritebackup
set noswapfile

set history=5000	"history
set incsearch   "search as you type

filetype on     "recognize filetype
filetype indent on
filetype plugin on

set guioptions-=T

"vimgrep
set grepprg=grep\ -nrI\ --exclude-dir=.vim\ --exclude-dir=target\ --exclude-dir=tmp\ --exclude-dir=log\ --exclude="*.min.js"\ --exclude="*.log"\ --exclude="tags"\ $*\ /dev/null

set cc=81
highlight ColorColumn ctermbg=darkgrey

"autoindent smartindent not set because it seems it's done automatically

autocmd FileType c,cpp,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e

"For normal stuff
autocmd FileType mail,human set formatoptions+=t ts=8 sw=8 noexpandtab

"For php TODO
autocmd FileType php set expandtab sw=4 sts=4 ts=4

"For perl [4 space tab] TODO test
autocmd FileType perl set noexpandtab ts=4 sts=4 sw=4

"For css [4 space tab]
autocmd FileType css set noexpandtab ts=4 sts=4 sw=4 
autocmd BufRead,BufNewFile *.scss set filetype=css

"For html/css [2 space expandtab] 
autocmd FileType html,xml set noexpandtab ts=4 sts=4 sw=4

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
autocmd BufRead,BufNewFile *.css.erb set filetype=ruby
autocmd BufRead,BufNewFile *.scss.erb set filetype=ruby
autocmd BufRead,BufNewFile *.html.erb set filetype=ruby
autocmd BufRead,BufNewFile *.js.erb set filetype=ruby
autocmd BufRead,BufNewFile *.yaml set filetype=ruby

"Strip whitespace
autocmd FileType php,perl,css,html,c,cpp,java,bash,sh,javascript,python,ruby autocmd BufWritePre <buffer> :%s/\s\+$//e

"Launch pathogen
call pathogen#infect()

"CtrlP
"Key map CtrlP to ctrl-p 
let g:ctrlp_working_path_mode = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_match_window = 'max:20'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = {
	\ 'dir': '\.git$\|\.hg$\|\.svn$\|\log$',
	\ 'file': '\.exe$\|\.so$\|\.dll$',
	\ }

nmap <F8> :TagbarToggle<CR>
