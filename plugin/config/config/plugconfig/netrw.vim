let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 20

function! OpenToRight()
	:normal v
	let g:path=expand('%:p')
	execute 'q!'
	execute 'belowright vnew' g:path
	:normal <C-w>l
endfunction

function! OpenBelow()
	:normal v
	let g:path=expand('%:p')
	execute 'q!'
	execute 'belowright new' g:path
	:normal <C-w>l
endfunction

function! OpenTab()
	:normal v
	let g:path=expand('%:p')
	execute 'q!'
	execute 'tabedit' g:path
	:normal <C-w>l
endfunction

function! NetrwMappings()
		" Hack fix to make ctrl-l work properly
		noremap <buffer> <A-l> <C-w>l
		noremap <buffer> <C-l> <C-w>l
		noremap <silent> <A-f> :call ToggleNetrw()<CR>
		noremap <buffer> V :call OpenToRight()<cr>
		noremap <buffer> H :call OpenBelow()<cr>
		noremap <buffer> T :call OpenTab()<cr>
endfunction

augroup netrw_mappings
		autocmd!
		autocmd filetype netrw call NetrwMappings()
augroup END

" Allow for netrw to be toggled
" function! ToggleNetrw()
" 		if g:NetrwIsOpen
" 				let i = bufnr("$")
" 				while (i >= 1)
" 						if (getbufvar(i, "&filetype") == "netrw")
" 								silent exe "bwipeout " . i
" 						endif
" 						let i-=1
" 				endwhile
" 				let g:NetrwIsOpen=0
" 		else
" 				let g:NetrwIsOpen=1
" 				silent Lexplore
" 		endif
" endfunction

" Check before opening buffer on any file
function! NetrwOnBufferOpen()
	if exists('b:noNetrw')
			return
	endif
	" call ToggleNetrw()
endfun

" Close Netrw if it's the only buffer open
autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif

" Make netrw act like a project Draw
augroup ProjectDrawer
	autocmd!
	" Don't open Netrw
	autocmd VimEnter ~/.config/joplin/tmp/*,/tmp/calcurse*,~/.calcurse/notes/*,~/vimwiki/*,*/.git/COMMIT_EDITMSG let b:noNetrw=1
	autocmd VimEnter * :call NetrwOnBufferOpen()
augroup END

let g:NetrwIsOpen=0
