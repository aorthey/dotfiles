set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'rking/ag.vim'
Bundle 'orthez/vim-nerdtree-tabs'
Bundle 'orthez/nerdtree-ag'
call vundle#end()            " required
filetype plugin indent on    " required

"path to current software project
"set path=
""always reload vimrc, if changed
autocmd! bufwritepost .vimrc source %
"source ~/.vim/autoload/feraltogglecommentify.vim

"nmap cl :TC<CR> "toggle comment on line
"nmap cp vip:CC<CR> "comment paragraph
"nmap vp vip:UC<CR> "uncomment paragraph

autocmd Filetype c,cc,cpp,h,hh,hpp set tabstop=8 softtabstop=8 shiftwidth=8 expandtab
autocmd Filetype * set tabstop=8 softtabstop=8 shiftwidth=8 expandtab
"set autoindent
set timeoutlen=300 "timeout for key combinations

let g:Tex_UseSimpleLabelSearch=1
let g:Tex_BIBINPUTS="."

"map hon :%d<CR>
"ap hof :%d -r<CR>

"ap hon :%!xxd<CR>
"ap hof :%!xxd -r<CR>

"turn on spell checking
set spell spelllang=en_us
set clipboard="unamedplus,autoselect,exclude:cons\|linux"

"(reverse letter order) in visual mode
vmap fR c<C-O>:set ri<CR><C-R>"<Esc>:set nori<CR>

"restrict lines to have N letters, automatically wrap if x>N
set textwidth=80
set wrapmargin=80
set history=500
set ruler
set hidden
runtime macros/matchit.vim

"disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

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
filetype indent off

set grepprg=grep\ -nH\ $*
"let g:tex_flavor='latex'

"show linenumbers on the left
set number

"settings for tabs 
"set autoindent
"set copyindent
"set smartindent
"set pastetoggle=<F11> 
"set expandtab

"short cmds to quickly invoke make file commands, % displays filename,
" %:r "display filename without file extension
nmap gm :!cd ~/git/feasibility/build && make<CR>
nmap grl :!cd ~/git/fastReplanning/build && make -j5 && sudo make install<CR>
nmap gr :!rosmake feasibility && rosrun feasibility MainProject<CR>
nmap gdb :!rosmake feasibility && gdb -ex run ~/git/feasibility/bin/MainProject<CR>
nmap gff :!g++ % -o %.exe && ./%.exe<CR>
nmap gm :!make -j5<CR>
nmap gc :!make clean && make -j5 && make run<CR>
"nmap gfc :!make clean && make && gdb -ex run ./x.exe<CR>
"nmap gfr :!make run FILE=%<CR>
"nmap gfm :!make all FILE=%<CR>
"nmap gfm :!make all FILE=%<CR>
"nmap gfm :!make && make debug<CR>
"nmap gfc :!make all FILE=% && make run FILE=%<CR>
nmap gfb :!rm -rf *~ *.log *.aux *.dvi *.toc %:r.pdf *.bbl *.blg && pdflatex % && bibtex %:r && pdflatex % && pdflatex % && apvlv %:r.pdf&<CR><CR>
nmap gfv :!rm -rf *~ *.log *.aux *.dvi *.toc %:r.pdf *.bbl *.blg && pdflatex % && bibtex %:r && latex % && pdflatex % && apvlv %:r.pdf<CR>
nmap gfc :!rm -rf *~ *.log *.aux *.dvi *.toc %:r.pdf *.bbl *.blg && pdflatex % && apvlv %:r.pdf<CR>
nmap gfl :!rm -rf *~ *.log *.aux *.dvi *.toc %:r.pdf *.bbl *.blg <CR>
nmap gfr :!apvlv %:r.pdf<CR>
nmap gl :!make clean<CR>
"nmap gr :!make run<CR>
nmap ge :!./x.exe -openHand 1 -openArm 1 -openSkin 1<CR>

"step out of insert mode with hh instead of ESC

"delete a character in insert mode
"inoremap xx <C-O>x
"inoremap xb <C-O>h<C-O>x

"delete a word in insert mode
"inoremap xdw <C-O>dw

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

nnoremap <silent> <S-H> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <S-L> :execute 'silent! tabmove ' . tabpagenr()<CR>

"some easier folding commands
"nmap z<C-j> zczjzo 
"nmap z<C-k> zczkzo

nmap Y y$ "till the end of link yank
noremap  <f1> :w<return>
inoremap <f1> <c-o>:w<return>

"highlight lines, which are greater than 80 columns
"highlight OverLength ctermbg=2 ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

"highlight current cursor line
set cursorline
"add term=underline and cterm=underline for a line under the current line
highlight CursorLine ctermbg=5 cterm=bold term=bold

"cursor lightning specifications
"highlight Cursor ctermfg=white ctermbg=white
"highlight iCursor ctermfg=white ctermbg=white

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

let g:SpellCheckingIsOn=1
function! ToggleSpellChecking()
  if g:SpellCheckingIsOn 
    set nospell
    let g:SpellCheckingIsOn=0
  else
    set spell
    let g:SpellCheckingIsOn=1
  endif
endfunction
noremap gn :call ToggleSpellChecking()<CR>

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

function! CopyFile()
  let g:Newfile = expand("%:p:h")."/".input(expand("%:p:h")."/")
  let g:Oldfile = expand("%")
  exec ':silent !cp '.g:Oldfile.' '.g:Newfile
  exec ':tabedit '.g:Newfile
endfunction
map cf :call CopyFile()<CR>

"reload vimrc
nmap <F4> :source ~/.vimrc<CR>

"substitute all uml to their html code (&auml;&ouml;)
function! UMLtoHTML(string)
	if a:string =~# 'ä'
		return '&auml;'
	elseif a:string =~# 'Ä'
		return '&auml;'
	elseif a:string =~# 'ö'
		return '&ouml;'
	elseif a:string =~# 'Ö'
		return '&Ouml;'
	elseif a:string =~# 'ü'
		return '&uuml;'
	elseif a:string =~# 'Ü'
		return 'Uuuml;'
	else
		return '&szlig;'
	endif
endfunction
:command! Huml :%s/[ÄÖÜäöüß]/\=UMLtoHTML(submatch(0))/g

map ;g é

"open link under line in firefox
nnoremap gl :silent !firefox <C-R>=escape("<C-R><C-F>", "#?&;\|%")<CR><CR><CR>

"search /i
set ignorecase

set clipboard+=unnamed
set clipboard+=unnamedplus
"push current absolute filepath into clipboard
nmap yng :call system("xclip -i -selection clipboard", expand("%:p"))<CR>
nmap ynl :call system("xclip -i -selection clipboard", expand("%"))<CR>
"push current line content into clipboard
nmap yl :call system("xclip -i -selection clipboard", getline("."))<CR>
vnoremap <c-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>
nmap yip vip<c-c>
vnoremap y y:call system("xclip -i -selection clipboard", getreg("\""))<CR>

function! Load(file)
  if filereadable(glob(a:file)) 
    exec ':source '.a:file
  endif
endfunction

"change background color for vim
syntax on
let g:zenburn_high_Contrast=1
set t_Co=256
colors zenburn
colorscheme zenburn

function! SaveSess()
  execute 'mksession! ~/.vim/session.vim'
  echo "saved session"
endfunction

inoremap <C-s> :call SaveSess()<CR>

filetype on
filetype plugin on
filetype indent on
syntax on

call Load("~/.vimrc.keymaps")
call Load("~/.vimrc.statusline")
