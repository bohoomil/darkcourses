" vimrc by bohoomil
" vim:ft=vim:

" pathogen
filetype off 
call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
let Vimplate = "/usr/bin/vimplate"

set nocompatible
set encoding=utf8
set modeline
filetype plugin on
syntax on


"    "
" ui "
"    "
" wrap'n'jump by display lines
"set background=dark

if &t_Co < 256
"if $TERM =~ '^linux'
	colorscheme dc3c    " colourscheme for the 8 colour linux term
else
	colorscheme dc3
endif

set tw=0 
set wrap
set linebreak
set display+=lastline

set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands

" buftabs
noremap <F11> :bprev<CR>
noremap <F12> :bnext<CR>
let g:buftabs_only_basename=1
let g:buftabs_separator = "."
let g:buftabs_marker_start = "["
let g:buftabs_marker_end = "]"
let g:buftabs_marker_modified = "*"

" statusline
set cmdheight=1     " command line height
set laststatus=2    " condition to show status line, 2=always.
set ruler           " show cursor position in status line
set showmode        " show mode in status line
set showcmd         " show partial commands in status line
" fileformat, encoding, type, buffer num, RO/HELP/PREVIEW, mod flag, filepath; spacer;  line pos, line/total, percentage
set statusline=%{&ff}\ \%{&fenc}\ \b%1.3n\ \%#StatusFTP#\%Y\ \%#StatusRO#\%R\ \%#StatusHLP#\%H\ \%#StatusPRV#\%W\ \%#StatusModFlag#\%M\ \%#StatusLine#\%f\%=\%1.7c\ \%1.7l/%L\ \%p%%

" NERDTree config
nmap <silent> <F9> :NERDTreeToggle<CR>
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\env','\.vim$', '\~$', '\.pyc$', '\.swp$', '\.egg-info$', '^dist$', '^build$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\~$']
let NERDTreeShowBookmarks=1
let NERDTreeHightlightCursorline=1


"           "
" filetypes "
"           "
" txt2tags
au BufNewFile,BufRead *.t2t set ft=txt2tags
au Filetype txt2tags source $HOME/.vim/syntax/txt2tags.vim
au BufNewFile,BufRead *.t2t set wrap
au BufNewFile,BufRead *.t2t set lbr
au! BufRead,BufNewFile *.json set filetype=json foldmethod=syntax 

" latex
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "xetex"
let g:Tex_DefaultTargetFormat = "pdf"
let g:Tex_CompileRule_pdf = "xelatex -interaction=nonstopmode $*"
let g:Tex_ViewRule_pdf = "acroread"

" Gentoo-specific settings for ebuilds.  These are the federally-mandated
" required tab settings.  See the following for more information:
" http://www.gentoo.org/proj/en/devrel/handbook/handbook.xml
" Note that the rules below are very minimal and don't cover everything.
" Better to emerge app-vim/gentoo-syntax, which provides full syntax,
" filetype and indent settings for all things Gentoo.
au BufRead,BufNewFile *.e{build,class} let is_bash=1|setfiletype sh
au BufRead,BufNewFile *.e{build,class} set ts=4 sw=4 noexpandtab

" tmux
let tmux = "/usr/share/vim/vim73/syntax/tmux.vim"
au BufRead,BufNewFile .tmux.conf set filetype=tmux.conf
au Syntax newlang source /usr/share/vim/vim73/syntax/tmux.vim

" logs
au BufNewFile,BufRead *.log set ft=messages
au BufNewFile,BufRead *.log{.*} set ft=messages

" Syntax highlighting for subtitle files 
au BufNewFile,BufRead *.srt setf srt
au BufNewFile,BufRead *.mpsub setf mpsub
au BufNewFile,BufRead *.sub setf sub

au BufNewFile,BufRead Trolltech.conf,.mpdasrc,.xchm,.*toprc setf cfg

" other file types
if has("autocmd")
	"always jump to the last cursor position
	autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif
	autocmd BufRead *.txt set tw=80 " limit width to n cols for txt files
	"autocmd FileType eml set tw=80  " limit width to n cols for email files
	autocmd BufRead *.eml set tw=0 fo=cq wm=0 " no automatic wrapping, rewrapping will wrap to 80
	autocmd BufRead ~/.mutt/temp/mutt-* set tw=80 ft=mail " nocindent spell   " width, mail syntax hilight, spellcheck
endif

" automatically give executable permissions if file 
" begins with #! and contains '/bin/' in the path
au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent execute "!chmod a+x <afile>" | endif | endif

augroup mkd
autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
augroup END

" html conversion (:help 2html.vim)
let g:html_use_css = 1
let g:use_xhtml = 1
let g:html_use_encoding = "utf8"
let g:html_number_lines = 1


"          "
" keyboard "
"          "
" map keys to toggle functions
function! MapToggle(key, opt)
	let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
	exec 'nnoremap '.a:key.' '.cmd
	exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)

" semicolon enters ex mode
map ; :

" space bar un-highligts search
noremap <silent> <Space> :silent noh<Bar>echo<CR>

" keys & functions
MapToggle <F5> spell
MapToggle <F6> hlsearch

set noexpandtab
set noautoindent     " set noautoindent to prevent vim from
                     " inserting unwanted indents when pasting
set tabstop=2        " set tab keys to 2 spaces
set shiftwidth=2
set nu!              " line numbering
set smartindent
set bs=2             " backspace

" tab key in visual mode
vmap <tab> >gv
vmap <S-tab> <gv

" leader
let mapleader = ","
let g:BASH_MapLeader  = '.'

" urxvt home / end
" the second is for insert mode
map  <Esc>[7~ <Home>
map  <Esc>[8~ <End>
imap <Esc>[7~ <Home>
imap <Esc>[8~ <End>

"set nolist  " list disables linebreak
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk
nmap <silent> k gk
nmap <silent> j gj


"       "
" mouse "
"       "
if has('mouse')
	set mouse=a
endif
set mousemodel=popup_setpos

" improves redrawing for newer computers
set tf
set nolazyredraw        " turn off lazy redraw
set nohlsearch          " highlight no search results
set wildmenu
set spelllang=en        " set spelling lang
set clipboard=unnamed   " yank and copy to X clipboard


"                     "
" searching & history "
"                     "
set hlsearch          " highlight all search results
set incsearch         " increment search
set ignorecase        " case-insensitive search; opposite noignorecase
set smartcase         " uppercase causes case-sensitive search
set wrapscan          " searches wrap back to the top of file

set nobackup          " don't create backup files
set noswapfile        " don't create swap file

set history=50        " keep 50 lines of command line history
set incsearch         " do incremental searching


"      "
" misc "
"      "
" allows writing to files with root priviledges
cmap w!! w !sudo tee % > /dev/null

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

