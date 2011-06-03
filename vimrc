" vimrc by bohoomil
" vim:fenc=utf-8:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=vim:

" pathogen
filetype off 
call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set nocompatible
set encoding=utf8
set modeline
filetype plugin on
syntax on


"    "
" ui "
"    "
"if &t_Co < 256
if &term=~'linux'
"if ($TERM) == 'linux'
	colorscheme miro8     " colourscheme for the 8 colour linux term
else
	colorscheme darkcourses
endif

set background=dark
set guicursor=a:blinkon0
set nu!                    " line numbering
set smartindent

" wrap'n'jump by display lines
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


"           "
" filetypes "
"           "
" txt2tags
au BufNewFile,BufRead *.t2t set ft=txt2tags
au Filetype txt2tags source $HOME/.vim/syntax/txt2tags.vim
"au BufNewFile,BufRead *.t2t set spell
au BufNewFile,BufRead *.t2t set wrap
au BufNewFile,BufRead *.t2t set lbr
"au Filetype txt2tags noremap <F10> :TlistToggle<Enter>

" txt2tags taglist support
let tlist_txt2tags_settings='txt2tags;d:Titles'

" latex
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "xetex"
let g:Tex_DefaultTargetFormat = "pdf"
let g:Tex_CompileRule_pdf = "xelatex -interaction=nonstopmode $*"
let g:Tex_ViewRule_pdf = "acroread"

" tmux
let tmux = "/usr/share/vim/vim73/syntax/tmux.vim"
au BufRead,BufNewFile .tmux.conf set filetype=tmux.conf
au Syntax newlang source /usr/share/vim/vim73/syntax/tmux.vim

" logs
au BufNewFile,BufRead *.log set ft=messages
au BufNewFile,BufRead *.log{.*} set ft=messages

" other file types
if has("autocmd")
	" always jump to the last cursor position
	autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif
	autocmd BufRead *.txt set tw=80 " limit width to n cols for txt files
    "autocmd FileType eml set tw=80  " limit width to n cols for email files
    autocmd BufRead *.eml set tw=0 fo=cq wm=0 " no automatic wrapping, rewrapping will wrap to 80
    autocmd BufRead ~/.mutt/temp/mutt-* set tw=80 ft=mail " nocindent spell   " width, mail syntax hilight, spellcheck
    "autocmd FileType tex set tw=197   " wrap at 197 chars for LaTeX files
endif

" highlight all characters past 75 columns
"augroup vimrc_autocmds
"  autocmd BufEnter * highlight OverLength ctermbg=0 guibg=#1A1A1A
"  autocmd BufEnter * match OverLength /\%75v.*/
"augroup END

" automatically give executable permissions if file 
" begins with #! and contains '/bin/' in the path
function ModeChange()
	if getline(1) =~ "^#!"
		if getline(1) =~ "/bin/"
			silent !chmod a+x <afile> 
		endif
	endif
endfunction
au BufWritePost * call ModeChange()

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
set tabstop=4        " set tab keys to 4 spaces
set shiftwidth=4
set noautoindent     " set noautoindent to prevent vim from
                     " inserting unwanted indents when pasting
" backspace
set bs=2

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

let MRU_File = "/home/bohoomil/.vim/vim_mru_files"
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'
let MRU_Max_Entries = 20
let MRU_Max_Menu_Entries = 4

map <C-f> :FufFile /home/bohoomil/<CR>

set tags+=ftags


"      "
" misc "
"      "
" allows writing to files with root priviledges
cmap w!! w !sudo tee % > /dev/null

let tumblr_email = ''
let tumblr_password = ''
let tumblr_tumblelog = ''


"                        "
" gvim specific settings "
"                        "
if has ("gui_running")
    " only initialize window size if it has not been initialized yet
	if !exists ("s:my_windowInitialized_variable")
		let s:my_windowInitialized_variable=1

	" feel free to :set background=light for a different style
	set background=dark
	colorscheme darkcourses

	set guifont=Envy\ Code\ R\ 10.5

	" geometry
	set lines=70 columns=120

	set winaltkeys=no

    " menubar / toolbar on / off
    map <silent> <F2> :if &guioptions =~# 'T' <Bar>
	\set guioptions-=T <Bar>
	\set guioptions-=m <bar>
	\else <Bar>
	\set guioptions+=T <Bar>
	\set guioptions+=m <Bar>
	\endif<CR>
	
    " remove scrollbars in gVim
	set guioptions+=LlRrb
	set guioptions-=LlRrb
	
    " turn off toolbar
    set guioptions+=T
	set guioptions-=T

	" toolbar -- exclusions
	aunmenu ToolBar.Make
	aunmenu ToolBar.RunCtags
	aunmenu ToolBar.SaveSesn
	aunmenu ToolBar.LoadSesn
	aunmenu ToolBar.SaveAll
	aunmenu ToolBar.FindHelp

	endif
endif

