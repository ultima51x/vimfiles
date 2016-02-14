" .vimrc
" David Hwang

"""""""""""""""""""" SYSTEM SPECIFIC """""""""""""""""""""""""""""""""""""""""""
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

if has("win32")
	source $VIMRUNTIME/vimrc_example.vim
	source $VIMRUNTIME/mswin.vim
	behave mswin
	set diffexpr=MyDiff()
endif
if has('syntax') && (&t_Co > 2)
	syntax on
endif

"""""""""""""""""""" COMMANDS """"""""""""""""""""""""""""""""""""""""""""""""""
"%% auto expands to the path of the current folder
cnoremap <expr> %% getcmdtype() == ":" ? expand('%:h').'/' : '%%'

execute pathogen#infect()

filetype on     "recognize filetype
filetype indent on
filetype plugin on

highlight ColorColumn ctermbg=darkgrey

"""""""""""""""""""" SETTINGS """"""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start	"allows backspace over indents/eol
set colorcolumn=81		"number of lines to use for highlight
set fileformats=unix,dos,mac	"fileformats to try to read when opening file
set formatoptions-=t		"do not auto-wrap text using textwidth
set grepprg=grep\ -nrI\ --exclude-dir=.vim\ --exclude-dir=.git\ --exclude-dir=target\ --exclude-dir=tmp\ --exclude-dir=log\ --exclude-dir=public/assets\ --exclude=*.min.js\ --exclude=*.log\ --exclude=tags\ $*\ /dev/null	"vimgrep settings
set history=5000		"history
set hlsearch			"highlights search
set incsearch   		"search as you type
set laststatus=2 		"always show status line (needed for airline)
set mouse=a     		"enable mouse for all modes
set nobackup			"no backups
set noerrorbells vb t_vb=	"no errorbells
set number
set ruler       		"show line status at bottom
set showcmd     		"show partially typed commands
set showmatch   		"show matching braces
set showmode    		"show mode at the bottom
set tags=./tags;
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*\\tmp\\*,*.exe
set wildmode=list:longest,full  "command line completion

"""""""""""""""""""" FILE EXTENSIONS """""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

"""""""""""""""""""" LANGUAGE SPECIFIC TAB BEHAVIOR """"""""""""""""""""""""""""
function StripTrailingWhiteSpace()
	autocmd BufWritePre <buffer> :%s/\s\+$//e
endfunction

" 4 space hard tab
autocmd FileType bash,c,cpp,java,javascript,perl,sh setlocal noexpandtab ts=4 sts=4 sw=4
autocmd FileType bash,c,cpp,java,javascript,perl,sh call StripTrailingWhiteSpace()

" 4 space soft tab
autocmd FileType markdown,php,python setlocal expandtab sw=4 sts=4 ts=4
autocmd FileType markdown,php,python call StripTrailingWhiteSpace()

" 2 space soft tab
autocmd FileType css,eruby,haml,html,ruby,sass,scss,xml,yaml setlocal expandtab ts=2 sts=2 sw=2 
autocmd FileType css,eruby,haml,html,ruby,sass,scss,xml,yaml call StripTrailingWhiteSpace()

"""""""""""""""""""" PLUGINS """""""""""""""""""""""""""""""""""""""""""""""""""
"CtrlP
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
			\ 'dir': '\.git$\|\.hg$\|\.svn$\|\log$\|\tmp$',
			\ 'file': '\.exe$\|\.so$\|\.dll$',
			\ }

"markdown
let g:markdown_fenced_languages = ['bash=sh', 'html', 'java', 'javascript', 'python', 'ruby']

"netrw
let g:netrw_alto=1
let g:netrw_altv=1
let g:netrw_liststyle=3

"syntastic - these were beginner recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"""""""""""""""""""" LEADER """"""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>e :Vex<cr>
nnoremap <leader>g :Gblame<cr>
nnoremap <leader>p :CtrlP<cr>
nnoremap <leader>q :copen<cr>
nnoremap <leader>r :CtrlPMRU<cr>
nnoremap <leader>t :CtrlPTag<cr>

