" .vimrc
" David Hwang

"""""""""""""""""""" SYSTEM SPECIFIC """""""""""""""""""""""""""""""""""""""""""
function! MyDiff()
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

"""""""""""""""""""" VUNDLE """"""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'

" ui related
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" unite related
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/neomru.vim'
Plugin 'Shougo/vimfiler.vim'
Plugin 'tsukkee/unite-tag'

" syntax related
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'kchmck/vim-coffee-script'
Plugin 'fatih/vim-go'

call vundle#end()

"""""""""""""""""""" COMMANDS """"""""""""""""""""""""""""""""""""""""""""""""""
"%% auto expands to the path of the current folder
cnoremap <expr> %% getcmdtype() == ":" ? expand('%:h').'/' : '%%'

filetype on     "recognize filetype
filetype indent on
filetype plugin on

highlight ColorColumn ctermbg=darkgrey
colorscheme wombat

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
set noundofile			"no undofile
set noerrorbells vb t_vb=	"no errorbells
set number
set ruler       		"show line status at bottom
set showcmd     		"show partially typed commands
set showmatch   		"show matching braces
set showmode    		"show mode at the bottom
set tags=./tags;
set timeoutlen=1500		"1.5 second delay (helpful for leader key)
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*\\tmp\\*,*.exe
set wildmode=list:longest,full  "command line completion

"""""""""""""""""""" FILE EXTENSIONS """""""""""""""""""""""""""""""""""""""""""
" markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" ruby
autocmd BufNewFile,BufReadPost *.jbuilder set filetype=ruby
autocmd BufNewFile,BufReadPost *.axlsx set filetype=ruby
" coffee
autocmd BufNewFile,BufReadPost *.coffee set filetype=coffee

"""""""""""""""""""" LANGUAGE SPECIFIC TAB BEHAVIOR """"""""""""""""""""""""""""
function! StripTrailingWhiteSpace()
	autocmd BufWritePre <buffer> :%s/\s\+$//e
endfunction

" 4 space hard tab
autocmd FileType bash,c,cpp,java,perl,sh,xml setlocal noexpandtab ts=4 sts=4 sw=4
autocmd FileType bash,c,cpp,java,perl,sh,xml call StripTrailingWhiteSpace()

" 4 space soft tab
autocmd FileType php,python setlocal expandtab sw=4 sts=4 ts=4
autocmd FileType php,python call StripTrailingWhiteSpace()

" 2 space soft tab
autocmd FileType css,eruby,haml,html,javascript,markdown,ruby,sass,scss,yaml,coffee setlocal expandtab ts=2 sts=2 sw=2
autocmd FileType css,eruby,haml,html,javascript,markdown,ruby,sass,scss,yaml,coffee call StripTrailingWhiteSpace()

"""""""""""""""""""" PLUGINS """""""""""""""""""""""""""""""""""""""""""""""""""
"markdown
let g:markdown_fenced_languages = ['bash=sh', 'html', 'java', 'javascript', 'python', 'ruby']

"netrw
let g:netrw_alto=1
let g:netrw_altv=1
let g:netrw_liststyle=3

"""""""""""""""""""" LEADER """"""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>g :Gblame<cr>

""""""""""""""""""""" AIRLINE """"""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='light'
let g:airline#extensions#tabline#enabled = 1

"""""""""""""""""""" UNITE """""""""""""""""""""""""""""""""""""""""""""""""""""
call unite#custom#profile('default', 'context', {
\   'winheight': 20,
\ })

"""
" All the below are Unite commands
" \ is to create a new window?
" \\ is to replace the current window

"file fuzzy search (like ctrlp)
call unite#custom#source('file_rec,file_rec/async', 'matchers', 'matcher_fuzzy')
call unite#custom#source('file_rec,file_rec/async', 'sorters', 'sorter_rank')
let g:unite_source_rec_async_command =
\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', '']
nnoremap <leader>p :Unite -prompt=>> -start-insert file_rec/async:!<cr>
nnoremap <leader><leader>p :Unite -no-split -prompt=>> -start-insert file_rec/async:!<cr>

"grep
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '-i --vimgrep'
nnoremap <leader>f :Unite -auto-preview grep:.<cr>
nnoremap <leader><leader>f :Unite -no-split -auto-preview grep:.<cr>

"file
"" in VimFiler, o is open
nnoremap <leader>e :VimFiler -explorer -status<cr>
nnoremap <leader><leader>e :VimFiler -status<cr>

"buffer
nnoremap <leader>b :Unite buffer<cr>
nnoremap <leader><leader>b :Unite -no-split buffer<cr>

"ctags
let g:unite_source_tag_max_fname_length = 60
let g:unite_source_tag_show_kind = 0
let g:unite_source_tag_strict_truncate_string = 0
noremap <leader>t :Unite -prompt=>> -start-insert tag<cr>
nnoremap <leader><leader>t :Unite -no-split -prompt=>> -start-insert tag<cr>

"mru
nnoremap <leader>m :Unite file_mru<cr>
nnoremap <leader><leader>m :Unite -no-split file_mru<cr>

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
	" exit with esc
	nmap <buffer> <ESC> <Plug>(unite_exit)
	imap <buffer> <ESC> <Plug>(unite_exit)

	" refresh unite
	nmap <buffer> <C-r> <Plug>(unite_redraw)
	imap <buffer> <C-r> <Plug>(unite_redraw)

	" split control
	inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
	nnoremap <silent><buffer><expr> <C-s> unite#do_action('split')
	inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
	nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
endfunction

