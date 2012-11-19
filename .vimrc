""always reload vimrc, if changed
autocmd! bufwritepost .vimrc source %

"map hon :%d<CR>
"ap hof :%d -r<CR>

"ap hon :%!xxd<CR>
"ap hof :%!xxd -r<CR>

"turn on spell checking
set spell spelllang=en_us
set clipboard="unamedplus,autoselect,exclude:cons\|linux"

"swap highlighted word in visual mode (reverse letter order)
vmap fR c<C-O>:set ri<CR><C-R>"<Esc>:set nori<CR>
"restrict lines to have N letters, automatically wrap if x>N
set textwidth=80
set wrapmargin=80
"change remember history to 50 cmds
set history=500

"path to current software project
set path=/home/orthez/git/mlr/share/**

"change background color for vim
highlight Normal ctermfg=white ctermbg=white
colorscheme blink

"syntax highlighting
syntax on

" auto-completion
"set completeopt=menu
set completeopt=menuone,longest
set wildmenu
set wildmode=list:longest


"forward tab completion
function! TabComplete(dir)
	if pumvisible()
		if "up" == a:dir
			return "\<C-P>"
		else
			return "\<C-N>"
		endif
	endif
	if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
		return "\<Tab>"
	elseif exists('&omnifunc') && &omnifunc != ''
		return "\<C-X>\<C-O>"
	else
		if "up" == a:dir
			return "\<C-P>"
		else
			return "\<C-N>"
		endif
	endif
endfunction
inoremap <S-Tab> <C-R>=TabComplete("up")<CR>
inoremap <Tab> <C-R>=TabComplete("down")<CR>


"jump directly to search result, as you type!
set incsearch

"show uncompleted cmd in lower right corner
set showcmd

"Sudo to write
command! W :w
command! Wq :wq
command! WS :execute ':silent w !sudo tee %' | :edit!


"enable filetype detection
filetype plugin on
filetype indent on

set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

"show linenumbers on the left
set number

"settings for tabs 
set autoindent
set copyindent
set smartindent
set tabstop=8
set shiftwidth=8
"set expandtab

"short cmds to quickly invoke make file commands, % displays filename,
" %:r "display filename without file extension
nmap gm :!make<CR>
nmap gc :!make clean && make && make run<CR>
"nmap gfc :!make clean && make && gdb -ex run ./x.exe<CR>
"nmap gfr :!make run FILE=%<CR>
"nmap gfm :!make all FILE=%<CR>
nmap gfm :!make all FILE=%<CR>
nmap gfm :!make && make debug<CR>
"nmap gfc :!make all FILE=% && make run FILE=%<CR>
nmap gfb :!rm -rf *~ *.log *.aux *.dvi *.toc %:r.pdf *.bbl *.blg && pdflatex % && bibtex %:r && pdflatex % && pdflatex % && apvlv %:r.pdf&<CR><CR>
nmap gfv :!rm -rf *~ *.log *.aux *.dvi *.toc %:r.pdf *.bbl *.blg && pdflatex % && bibtex %:r && latex % && pdflatex % && apvlv %:r.pdf<CR>
nmap gfc :!rm -rf *~ *.log *.aux *.dvi *.toc %:r.pdf *.bbl *.blg && pdflatex % && apvlv %:r.pdf<CR>
nmap gfl :!rm -rf *~ *.log *.aux *.dvi *.toc %:r.pdf *.bbl *.blg <CR>
nmap gfr :!apvlv %:r.pdf<CR>
nmap gl :!make clean<CR>
nmap gr :!make run<CR>
nmap ge :!./x.exe -openHand 1 -openArm 1 -openSkin 1<CR>

"step out of insert mode with hh instead of ESC

"delete a character in insert mode
inoremap xx <C-O>x
inoremap xb <C-O>h<C-O>x

"delete a word in insert mode
inoremap xdw <C-O>dw

"delete/change a functionname with all its arguments and the braces
nmap cif diwc%
nmap dif diwd%
nmap vif viww%

"reload vimrc
nmap <S-A-r> :source $MYVIMRC<CR>

"moving between split windows
"<C-W>_ augment window (up/down)
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
"nmap <C-H> <C-W>h<C-W>=<C-W>20>
"nmap <C-L> <C-W>l<C-W>=<C-W>20>

"tabs
nmap <C-L> :tabn<CR>
nmap <C-H> :tabp<CR>
nmap <C-A> :buffers<CR>
nmap <C-O> :tabe 

nnoremap <silent> <S-H> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <S-L> :execute 'silent! tabmove ' . tabpagenr()<CR>


"some easier folding commands
"nmap z<C-j> zczjzo 
"nmap z<C-k> zczkzo

nmap Y y$ "till the end of link yank
noremap  <f1> :w<return>
inoremap <f1> <c-o>:w<return>

"highlight lines, which are greater than 80 columns
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

"highlight current cursor line
set cursorline
"add term=underline and cterm=underline for a line under the current line
highlight CursorLine ctermbg=black ctermfg=white cterm=bold term=bold

"cursor lightning specifications
highlight Cursor ctermfg=white ctermbg=white
highlight iCursor ctermfg=white ctermbg=white

"cursor for n-v-c normal-visual-caret mode a:all modes
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=a:blinkwait10
set guicursor+=i:blinkwait10

"use s and S to insert a single char + combine this with [count] and the
"repeat command .
function! RepeatChar(char, count)
   return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
"nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S O<ESC>j 

"save session (tabs and buffer) via F2, reload F3
nmap <F2> :mksession! ~/.vim/sessions/%:t.session<CR>
nmap <F3> :source ~/.vim/sessions/%:t.session<CR>

"Experimental stuff which does not work yet
nnoremap :rename :echo "RENAME"

function! RenameText(lhs, rhs) range
  let arg1 = ''.a:lhs
  let arg2 = ''.a:rhs
  for row in range(a:firstline, a:lastline)
    let line = getline(row)
    let replace = substitute(line, arg1, arg2, 'ig')
    call setline(row,replace)
  endfor
endfunction
:command! -nargs=* Rename 1,$call RenameText(<f-args>)


"
"reload vimrc
nmap <F4> :source ~/.vimrc<CR>



"hi User1 ctermbg=lightred ctermfg=DarkMagenta guibg=black guifg=yellow
hi User1 ctermbg=white ctermfg=black guibg=black guifg=yellow
hi User2 ctermbg=white ctermfg=black guibg=black guifg=green
hi UserError ctermbg=white ctermfg=red guibg=black guifg=red
"andreas statusline style
"%L:total lines,%l:current line,%c:current column,%v columns total in this line
"%F: filename, %1*: choose color User1, %* default color
"%=:right align, %m: display [+] if buffer is modified
set laststatus=2
set statusline=
set statusline+=%<
set statusline+=%1*
set statusline+=%#UserError#%h%m%r%1*
set statusline+=[
set statusline+=%2*%l%1*
set statusline+=/
set statusline+=%L
set statusline+=\ --\ 
set statusline+=%2*%c%1*]\ 
set statusline+=[%2*%P%1*]
set statusline+=\ \ %b,0x%-8B
set statusline+=%=
set statusline+=%{MyMessage()}
set statusline+=%20.F
set statusline+=%10.y
set statusline+=%*

function! MyMessage()
	return "Freeze IDE >> "
endfunction
