set nocompatible              " be iMproved, required
filetype off                  " required

set nobackup
set noswapfile

set ft=txt
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"Bundle 'vim-scripts/ctags.vim'

"Plugin 'dhruvasagar/vim-open-url'
Plugin 'universal-ctags/ctags'
Plugin 'vim-scripts/openurl.vim'
Plugin 'junegunn/vim-slash'
Plugin 'gmarik/Vundle.vim'
Plugin 'bkad/CamelCaseMotion'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdtree-project-plugin'
Bundle 'vim-scripts/taglist.vim'
Bundle 'MrPeterLee/VimWordpress'
Bundle 'Shougo/neocomplcache' 
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/neosnippet-snippets'

Bundle 'jistr/vim-nerdtree-tabs'
" Bundle 'orthez/vim-nerdtree-tabs'
" Bundle 'orthez/nerdtree-ag'
Bundle 'rking/ag.vim'
Bundle 'Yggdroot/indentLine'

Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-repeat'
Bundle 'orthez/vim-snippets-additional'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'MarcWeber/vim-addon-mw-utils'

call vundle#end()            " required
filetype plugin indent on    " required

set tags=./tags,tags;$HOME "set tag dir

"path to current software project
"set path=
""always reload vimrc, if changed
autocmd! bufwritepost .vimrc source %
set autochdir
"source ~/.vim/autoload/feraltogglecommentify.vim
"

"nmap cl :TC<CR> "toggle comment on line
"nmap cp vip:CC<CR> "comment paragraph
"nmap vp vip:UC<CR> "uncomment paragraph

"set autoindent
set timeoutlen=300 "timeout for key combinations


let g:Tex_UseSimpleLabelSearch=1
let g:Tex_BIBINPUTS="."
let g:tex_flavor='latex'

"noremap mm M
"noremap mh H
"noremap ml L
"noremap mk $
"noremap mj 0

set synmaxcol=120
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

set grepprg=grep\ -nH\ $*

"show linenumbers on the left
set number
set pastetoggle=<F11> 

"short cmds to quickly invoke make file commands, % displays filename,
" %:r "display filename without file extension
"nmap gm :!cd ~/git/KlamptTests/build && make<CR>
"nmap grl :!cd ~/git/fastReplanning/build && make -j5 && sudo make install<CR>
"nmap gr :!rosmake feasibility && rosrun feasibility MainProject<CR>
"nmap gdb :!rosmake feasibility && gdb -ex run ~/git/feasibility/bin/MainProject<CR>
nmap gff :!g++ % -o %.exe && ./%.exe<CR>
"nmap gm :!make -j5<CR>
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

"delete/change a functionname with all its arguments and the braces
nmap cif diwc%
nmap dif diwd%
nmap vif viww%

nmap gk O<Esc>j
nmap gj o<Esc>k
nmap gm O<Esc>78i#<Esc>I//<Esc>yyo<Esc>I//<Esc>p


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

"nnoremap <silent> <S-H> :tabp<CR>
"nnoremap <silent> <S-L> :tabn<CR>

" Shortcuts to move between tabs with Ctrl+Shift+Left/Right
function! TabLeft()
   if tabpagenr() == 1
      execute "tabm"
   else
      execute "tabm -1"
   endif
endfunction

function! TabRight()
   if tabpagenr() == tabpagenr('$')
      execute "tabm" 0
   else
      execute "tabm +1"
   endif
endfunction

nmap <silent><S-H> :execute TabLeft()<CR>
nmap <silent><S-L> :execute TabRight()<CR>

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
"nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
"nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>
"nnoremap S O<ESC>j 

"default: no spell checking
let g:SpellCheckingIsOn=0
set nospell
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

if has ('autocmd') " Remain compatible with earlier versions
  augroup reload_vimrc
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif

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

"convert all umlaute to html language
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

filetype plugin on
filetype plugin indent on

syntax on
let g:zenburn_high_Contrast=1
let g:zenburn_old_Visual = 1
set t_Co=256
colors zenburn
colorscheme zenburn

function! SaveSess()
  execute 'mksession! ~/.vim/session.vim'
  echo "saved session"
endfunction

"inoremap <C-s> :call SaveSess()<CR>

let g:tex_conceal = ""
nmap <C-O> :tabnew 

nmap gw :!pdftotext %:p:r.pdf -enc UTF-8 - \| wc -m<CR>

autocmd! Filetype * set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd! Filetype txt set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd! Filetype c,cc,cpp,h,hh,hpp set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd! Filetype py,xml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

"autocmd! FileType javascript nnoremap <buffer> <S-T> I//<esc>
"autocmd! FileType python     nnoremap <buffer> <S-T> I#<esc>
"autocmd! FileType c,cc,cpp,h,hh,hpp     nnoremap <buffer> <S-T> I//<esc>
"autocmd! FileType make set noexpandtab shiftwidth=8 softtabstop=0
"
nmap k kzz
nmap j jzz
nmap <C-D> <C-D>zz
nmap <C-U> <C-U>zz

autocmd FileType c,cc,cpp,h,hh,hpp setlocal commentstring=//%s

"convert all math equations for wordpress as $$ -> $latex$
:command! Blog2LatexWordpress :%s/\$\(latex\_.\)\?\(\_.\{-}\)\$/\$latex \2\$/ige

nnoremap gp :Blog2LatexWordpress<CR>:BlogSave publish<CR>
nnoremap gbp :BlogSave publish<CR>
nnoremap gbn :BlogNew<CR>
nnoremap gbx :BlogSave publish<CR>:BlogList<CR>
nnoremap <C-s> :BlogSave publish<CR>
nnoremap gbl :BlogList<CR>

let g:indentLine_char = '|'
let g:indentLine_color_term = 239


onoremap <silent> i$ :<c-u>normal! T$vt$<cr>
onoremap <silent> a$ :<c-u>normal! T$hvt$l<cr>
vnoremap i$ T$ot$
vnoremap a$ T$hot$l

call Load("~/.vim/keymaps")
call Load("~/.vim/statusline")

nnoremap ; :
noremap <plug>(slash-after) zz
nnoremap n nzz
nnoremap N Nzz
nnoremap gn <C-]>zz
nnoremap gN <C-T>zz

let g:netrw_browsex_viewer="google-chrome"
let g:open_url_browser_default="google-chrome"
let g:open_url_browser="google-chrome"

"command! OpenUrl :call OpenUrl()
let NERDTreeWinSize = 38

function! TwoSpaceToFourSpace()
  set ts=2 sts=2 noet
  retab!
  set ts=4 sts=4 et
  retab
  set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
endfunction
