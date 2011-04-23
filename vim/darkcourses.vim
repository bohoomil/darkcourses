" Vim color file by bohoomil
" darkcourses, in the early days based on zenburn
"
" It's usable, but still needs lots of polish.
"
set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="darkcourses"

" gui
hi Boolean         guifg=#d9ca9e
hi Character       guifg=#d9ca9e 
hi Comment         guifg=#6C6C6C
hi Conditional     guifg=#afaf5f
hi Constant        guifg=#dfafaf
hi Cursor          guifg=#121212 guibg=#87afaf
hi Debug           guifg=#dfafaf
hi Define          guifg=#afaf5f 
hi Delimiter       guifg=#585858
hi DiffAdd         guifg=#5f8787 guibg=#313c36
hi DiffChange      guibg=#333333
hi DiffDelete      guifg=#333333 guibg=#464646
hi DiffText        guifg=#dc91b4 guibg=#41363c
hi Directory       guifg=#d7d7d7
hi Error           guifg=#af5f00 guibg=#121212
hi ErrorMsg        guifg=#87d7af guibg=#121212
hi Exception       guifg=#d9ca9e
hi Float           guifg=#c6c6c6
hi FoldColumn      guifg=#87afaf guibg=#121212
hi Folded          guifg=#87afaf guibg=#121212
hi Function        guifg=#d7af5f
hi Identifier      guifg=#afaf5f
hi IncSearch       guibg=#af5f00 guifg=#626262
hi Keyword         guifg=#afaf5f
hi Label           guifg=#d7d787
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

hi SpellBad        guisp=#bf5f5f guifg=#dc8c6c
hi SpellCap        guisp=#588385 guifg=#8c8cbc
hi SpellRare       guisp=#8c6981 guifg=#bc8cbc
hi SpellLocal      guisp=#7f9f7f guifg=#9ccc9c

" term
hi Normal          ctermfg=7
hi Boolean         ctermfg=13
hi Character       ctermfg=7
hi Comment         ctermfg=8
hi Conditional     ctermfg=11
hi Constant        ctermfg=13
hi Cursor          ctermfg=233   ctermbg=12
hi Debug           ctermfg=13
hi Define          ctermfg=11
hi Delimiter       ctermfg=8
hi DiffAdd         ctermfg=3
hi DiffChange      ctermfg=13
hi DiffDelete      ctermfg=10
hi DiffText        ctermfg=6
hi Directory       ctermfg=2
hi Error           ctermfg=9     ctermbg=233
hi ErrorMsg        ctermfg=9     ctermbg=233
hi Exception       ctermfg=13
hi Float           ctermfg=9
hi FoldColumn      ctermfg=109
hi Folded          ctermfg=109
hi Function        ctermfg=3
hi Identifier      ctermfg=11
hi IncSearch       ctermbg=130   ctermfg=241
hi Keyword         ctermfg=11
hi Label           ctermfg=11
hi LineNr          ctermfg=8     ctermbg=233
hi Macro           ctermfg=11
hi ModeMsg         ctermfg=3
hi MoreMsg         ctermfg=14
hi Number          ctermfg=4
hi Operator        ctermfg=64
hi PreCondit       ctermfg=10    cterm=none
hi PreProc         ctermfg=130
hi Question        ctermfg=14
hi Repeat          ctermfg=14
hi Search          ctermfg=171   ctermbg=241  cterm=none
hi SpecialChar     ctermfg=13
hi SpecialComment  ctermfg=108
hi Special         ctermfg=5
hi SpecialKey      ctermfg=10
hi Statement       ctermfg=4
hi StatusLine      ctermfg=66    ctermbg=0    cterm=none
"hi StatusLineNC    ctermfg=0     ctermbg=0    cterm=none 
hi StorageClass    ctermfg=6
hi String          ctermfg=10
hi Structure       ctermfg=12
hi Tag             ctermfg=5
hi Title           ctermfg=7     ctermbg=234   cterm=bold
hi Todo            ctermfg=108   ctermbg=234
hi Typedef         ctermfg=9
hi Type            ctermfg=5
hi Underlined      ctermfg=104   ctermbg=233
hi VertSplit       ctermfg=65    ctermbg=236
hi VisualNOS       ctermfg=210   ctermbg=236
hi WarningMsg      ctermfg=9     ctermbg=0
hi WildMenu        ctermbg=0     ctermfg=14
hi CursorLine      ctermbg=0     cterm=none

" spellchecking
hi SpellLocal      ctermfg=14    ctermbg=237
hi SpellBad        ctermfg=9     ctermbg=237
hi SpellCap        ctermfg=12    ctermbg=237
hi SpellRare       ctermfg=13    ctermbg=237

" pmenu
hi PMenu           ctermfg=7     ctermbg=0
hi PMenuSel        ctermfg=223   ctermbg=233

