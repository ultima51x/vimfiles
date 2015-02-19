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

"fileformats to show
set ff=unix
set fileformats=unix,dos

filetype on     "recognize filetype
filetype indent on
filetype plugin on

set guioptions-=T

"vimgrep
set grepprg=grep\ -nrI\ --exclude-dir=.vim\ --exclude-dir=.git\ --exclude-dir=target\ --exclude-dir=tmp\ --exclude-dir=log\ --exclude-dir=public/assets\ --exclude=*.min.js\ --exclude=*.log\ --exclude=tags\ $*\ /dev/null

set cc=81
highlight ColorColumn ctermbg=darkgrey

"[Normal tabbing]
autocmd FileType human,mail set formatoptions+=t ts=8 sw=8 noexpandtab

"[4 space hard tab]
autocmd FileType bash,c,cpp,java,javascript,perl,sh set noexpandtab ts=4 sts=4 sw=4

"[4 space soft tab]
autocmd FileType php,python set expandtab sw=4 sts=4 ts=4

"[2 space soft tab]
autocmd FileType css,eruby,html,ruby,sass,scss,xml,yaml set expandtab ts=2 sts=2 sw=2 

"Strip whitespace
autocmd FileType bash,c,cpp,java,javascript,perl,sh,php,python,css,eruby,html,ruby,sass,scss,xml,yaml autocmd BufWritePre <buffer> :%s/\s\+$//e

"pathogen
call pathogen#infect()

"netrw
let g:netrw_alto=1
let g:netrw_altv=1
let g:netrw_liststyle=3

"CtrlP
"Key map CtrlP to ctrl-p 
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
                          \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
let g:ctrlp_working_path_mode = 0
let g:ctrlp_by_filename = 0
let g:ctrlp_regexp = 1
let g:ctrlp_match_window = 'max:20'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
	\ 'dir': '\.git$\|\.hg$\|\.svn$\|\log$',
	\ 'file': '\.exe$\|\.so$\|\.dll$',
	\ }

"Leader mappings
nnoremap <leader>b :TagbarToggle<cr>
nnoremap <leader>e :Ex<cr>
nnoremap <leader>m :CtrlPMRU<cr>
nnoremap <leader>p :CtrlP<cr>
nnoremap <leader>t :CtrlPTag<cr>
nnoremap <leader>q :copen<cr>

"%% auto expands to the path of the current folder
cnoremap <expr> %% getcmdtype() == ":" ? expand('%:h').'/' : '%%'

