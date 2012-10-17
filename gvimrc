" .gvimrc
" David Hwang
" 08/18/2012

" using the colorscheme I like
colorscheme blacksea

" make the color column grey in guivim
highlight ColorColumn guibg=darkgrey

" using the fonts I like
if has("gui_running")
	if has("gui_gtk2")
		set guifont=Monospace 10,DejaVu\ Sans\ Mono\ 10
	elseif has("gui_macvim")
		set guifont=Monaco:h12,Menlo\ Regular:h12
	elseif has("gui_win32")
		set guifont=Consolas:h11,DejaVu\ Sans\ Mono:h10
	elseif has("gui_kde")
	elseif has("x11")
	endif
endif
