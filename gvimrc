" .gvimrc
" David Hwang

" Remove toolbar
set guioptions-=T	" remove toolbar
set visualbell t_vb=	" avoid the visual bell

" make the color column grey in guivim
highlight ColorColumn guibg=darkgrey

" using the fonts I like
if has("gui_running")
	if has("gui_gtk2")
		set guifont=DejaVu\ Sans\ Mono\ 10
	elseif has("gui_macvim")
		set guifont=Monaco:h12,Menlo\ Regular:h12
		set transparency=5
	elseif has("gui_win32")
		set guifont=Consolas:h11
	elseif has("gui_kde")
	elseif has("x11")
	endif
endif

let $PS1="$ "
