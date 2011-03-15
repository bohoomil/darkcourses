" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Description:  darkcourses, once upon a time based on zenburn
"               works with both gVim and Vim
" Maintainer:   bohoomil [at] gmail dot com
" Last Change:  March 02, 2011
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="darkcourses"
hi Boolean         guifg=#d9ca9e
hi Character       guifg=#d9ca9e 
hi Comment         guifg=#6C6C6C
hi Conditional     guifg=#afaf5f
hi Constant        guifg=#dfafaf
hi Cursor          guifg=#080808 guibg=#87afaf
hi Debug           guifg=#dfafaf
hi Define          guifg=#afaf5f 
hi Delimiter       guifg=#585858
hi DiffAdd         guifg=#5f8787 guibg=#313c36
hi DiffChange      guibg=#333333
hi DiffDelete      guifg=#333333 guibg=#464646
hi DiffText        guifg=#dc91b4 guibg=#41363c
hi Directory       guifg=#d7d7d7
hi ErrorMsg        guifg=#87d7af guibg=#080808
hi Exception       guifg=#d9ca9e
hi Float           guifg=#c6c6c6
hi FoldColumn      guifg=#87afaf guibg=#080808
hi Folded          guifg=#87afaf guibg=#080808
hi Function        guifg=#d7af5f
hi Identifier      guifg=#afaf5f
hi IncSearch       guibg=#af5f00 guifg=#626262
hi Keyword         guifg=#afaf5f
hi Label           guifg=#d7d787 gui=underline
hi LineNr          guifg=#626262
hi Macro           guifg=#afaf5f
hi ModeMsg         guifg=#afaf5f gui=none
hi MoreMsg         guifg=#dcdccc
hi Number          guifg=#5f5f87
hi Operator        guifg=#5f8700
hi PreCondit       guifg=#d7af87
hi PreProc         guifg=#af5f00
hi Question        guifg=#dcdccc
hi Repeat          guifg=#afaf5f
hi Search          guifg=#d75fff guibg=#626262
hi SpecialChar     guifg=#d7afaf
hi SpecialComment  guifg=#87af87
hi Special         guifg=#d7875f
hi SpecialKey      guifg=#afd7af
hi Statement       guifg=#5f5f87 gui=none
hi StatusLine      guifg=#768ea6 guibg=#1c1c1c gui=none
hi StatusLineNC    guifg=#768ea6 guibg=#1c1c1c
hi StorageClass    guifg=#9e9e9e gui=none
hi String          guifg=#d78787
hi Structure       guifg=#ffffaf gui=none
hi Tag             guifg=#d7afaf gui=none
hi Title           guifg=#efefef
hi Todo            guifg=#7f9f7f guibg=bg
hi Typedef         guifg=#dadada
hi Type            guifg=#875f87 gui=none
hi Underlined      guifg=#bdbdbd gui=underline
hi VertSplit       guifg=#2e3330 guibg=#688060
hi VisualNOS       guifg=#333333 guibg=#dc91b4 gui=none,underline
hi WarningMsg      guifg=#dcdccc guibg=#333333 gui=none
hi WildMenu        guibg=#2c302d guifg=#d7ffd7 gui=underline

hi SpellBad   guisp=#bf5f5f guifg=#dc8c6c
hi SpellCap   guisp=#588385 guifg=#8c8cbc
hi SpellRare  guisp=#8c6981 guifg=#bc8cbc
hi SpellLocal guisp=#7f9f7f guifg=#9ccc9c

" non-GUI 
if &t_Co > 255
	hi Boolean         ctermfg=181
	hi Character       ctermfg=248
	hi Comment         ctermfg=242
    hi Conditional     ctermfg=143
    hi Constant        ctermfg=181
	hi Cursor          ctermfg=232   ctermbg=109
	hi Debug           ctermfg=181
    hi Define          ctermfg=143
    hi Delimiter       ctermfg=240
    hi DiffAdd         ctermfg=66    ctermbg=237
    hi DiffChange      ctermbg=236
    hi DiffDelete      ctermfg=236   ctermbg=232
    hi DiffText        ctermfg=217   ctermbg=237
    hi Directory       ctermfg=188
	hi ErrorMsg        ctermfg=115   ctermbg=232
    hi Exception       ctermfg=249
    hi Float           ctermfg=251
    hi FoldColumn      ctermfg=109   ctermbg=232
    hi Folded          ctermfg=109   ctermbg=232
    hi Function        ctermfg=179
    hi Identifier      ctermfg=143
    hi IncSearch       ctermbg=130   ctermfg=241
    hi Keyword         ctermfg=143
    hi Label           ctermfg=186   cterm=underline
	hi LineNr          ctermfg=241   ctermbg=232
    hi Macro           ctermfg=143
    hi ModeMsg         ctermfg=143   cterm=none
    hi MoreMsg         ctermfg=15
    hi Number          ctermfg=60
    hi Operator        ctermfg=64
    hi PreCondit       ctermfg=180
    hi PreProc         ctermfg=130
    hi Question        ctermfg=15
    hi Repeat          ctermfg=143
    hi Search          ctermfg=171   ctermbg=241  cterm=none
    hi SpecialChar     ctermfg=181
    hi SpecialComment  ctermfg=108
    hi Special         ctermfg=173
    hi SpecialKey      ctermfg=151
    hi Statement       ctermfg=60
    hi StatusLine      ctermfg=242   ctermbg=214  cterm=none
    hi StatusLineNC    ctermfg=242   ctermbg=214  
    hi StorageClass    ctermfg=249   cterm=bold
    hi String          ctermfg=174
    hi Structure       ctermfg=229   cterm=bold
    hi Tag             ctermfg=181   cterm=bold
    hi Title           ctermfg=7     ctermbg=234     cterm=bold
    hi Todo            ctermfg=108   ctermbg=234     cterm=bold
    hi Typedef         ctermfg=253   cterm=bold
    hi Type            ctermfg=96    cterm=none
    hi Underlined      ctermfg=104   ctermbg=232     cterm=bold
    hi VertSplit       ctermfg=236   ctermbg=65
    hi VisualNOS       ctermfg=236   ctermbg=210     cterm=bold
    hi WarningMsg      ctermfg=15    ctermbg=236     cterm=bold
    hi WildMenu        ctermbg=236   ctermfg=194     cterm=bold
    hi CursorLine      ctermbg=236   cterm=none

    " spellchecking, always "bright" background
    hi SpellLocal ctermfg=14  ctermbg=237
    hi SpellBad   ctermfg=9   ctermbg=237
    hi SpellCap   ctermfg=12  ctermbg=237
    hi SpellRare  ctermfg=13  ctermbg=237

    " pmenu
    hi PMenu      ctermfg=248  ctermbg=0
	hi PMenuSel   ctermfg=223 ctermbg=232

    if exists("g:darkcourses_high_Contrast")
        hi Normal  ctermfg=248 ctermbg=232
		hi NonText ctermfg=232

        if exists("g:darkcourses_color_also_Ignore")
            hi Ignore          ctermfg=232
        endif
    else
        hi Normal ctermfg=248 ctermbg=232
        hi Cursor          ctermbg=109
        hi diffadd         ctermbg=232
        hi diffdelete      ctermbg=232
        hi difftext        ctermbg=232
        hi errormsg        ctermbg=232
        hi foldcolumn      ctermbg=232
        hi folded          ctermbg=232
        hi incsearch       ctermbg=179
        hi linenr          ctermbg=232
        hi search          ctermbg=232
        hi statement       ctermbg=232
        hi statusline      ctermbg=233
        hi statuslinenc    ctermbg=233
        hi title           ctermbg=232
        hi todo            ctermbg=232
        hi underlined      ctermbg=232
        hi vertsplit       ctermbg=65
        hi visualnos       ctermbg=210
		hi warningmsg      ctermbg=232
        hi wildmenu        ctermbg=232
        hi NonText         ctermfg=232
        
        if exists("g:darkcourses_color_also_Ignore")
            hi Ignore          ctermfg=232
        endif
    endif

    if exists("g:darkcourses_alternate_Error")
        hi Error ctermfg=210 ctermbg=52 gui=bold
    else
        hi Error ctermfg=223 ctermbg=95 gui=bold
    endif
endif

if exists("g:darkcourses_force_dark_Background")
    " Force dark background, because of a bug in VIM:  VIM sets background
    " automatically during "hi Normal ctermfg=X"; it misinterprets the high
    " value (234 or 237 above) as a light color, and wrongly sets background to
    " light.  See ":help highlight" for details.
    set background=dark
endif

if exists("g:darkcourses_high_Contrast")
    " use new darker background
    hi Normal          guifg=#bdbdbd guibg=#080808
    hi CursorLine      guibg=#121212
    hi Pmenu           guibg=#242424 guifg=#ccccbc
    hi PMenuSel        guibg=#353a37 guifg=#ccdc90
    hi PmenuSbar       guibg=#2e3330 guifg=#000000
    hi PMenuThumb      guibg=#a0afa0 guifg=#040404
    hi MatchParen      guifg=#f0f0c0 guibg=#383838
    hi SignColumn      guifg=#9fafaf guibg=#181818
    hi TabLineFill     guifg=#cfcfaf guibg=#181818
    hi TabLineSel      guifg=#efefef guibg=#1c1c1b
    hi TabLine         guifg=#b6bf98 guibg=#181818
    hi CursorColumn    guifg=#dcdccc guibg=#2b2b2b
    hi NonText         guifg=#080808
else
    " Original, lighter background
    hi Normal          guifg=#b8b8b8 guibg=#080808
    hi CursorLine      guibg=#434443
    hi Pmenu           guibg=#2c2e2e guifg=#9f9f9f
    hi PMenuSel        guibg=#242424 guifg=#d0d0a0
    hi PmenuSbar       guibg=#2e3330 guifg=#000000
    hi PMenuThumb      guibg=#a0afa0 guifg=#040404
    hi MatchParen      guifg=#b2b2a0 guibg=#2e2e2e
    hi SignColumn      guifg=#9fafaf guibg=#343434
    hi TabLineFill     guifg=#cfcfaf guibg=#353535
    hi TabLineSel      guifg=#efefef guibg=#3a3a39
    hi TabLine         guifg=#b6bf98 guibg=#353535
    hi CursorColumn    guifg=#dcdccc guibg=#4f4f4f
    hi NonText         guifg=#5b605e
endif


if exists("g:darkcourses_alternate_Visual")
    hi Visual          guifg=#000000 guibg=#71d3b4 gui=none
    hi VisualNOS       guifg=#000000 guibg=#71d3b4 gui=none
else
    hi Visual          guifg=#233323 guibg=#71d3b4 gui=none
    hi VisualNOS       guifg=#233323 guibg=#71d3b4 gui=none
endif

if exists("g:darkcourses_alternate_Error")
    hi Error        guifg=#e37170 guibg=#664040 gui=none
else
    hi Error        guifg=#e37170 guibg=#3d3535 gui=none
endif

if exists("g:darkfcourses_alternate_Include")
    hi Include      guifg=#ffcfaf
else
    hi Include      guifg=#dfaf8f
endif

if exists("g:darkcourses_color_also_Ignore")
    hi Ignore guifg=#545a4f
endif

