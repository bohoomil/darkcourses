" darkcourses colours for Vim
" Author:  bohoomil
" Date:    April, 2011
" Release: 1.0 final
"
" This theme is supposed to be used
" with darkcourses .Xdefaults color settings.
" GUI part is .Xdefaults independent.

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="darkcourses"

"
" gui zone
"
hi Normal          guifg=#999999 guibg=#121212
hi Boolean         guifg=#BF7397
hi Character       guifg=#999999 guibg=#121212 gui=none 
hi Comment         guifg=#5E5D5E
hi Conditional     guifg=#BDA45A
hi Constant        guifg=#BF7397
hi Cursor          guifg=#121212 guibg=#6A8FB3
hi Debug           guifg=#BF7397
hi Define          guifg=#BDA45A 
hi Delimiter       guifg=#5E5D5E
hi DiffLine        guifg=#466380
hi DiffOldLine     guifg=#734545
hi DiffOldFile     guifg=#734545
hi DiffNewFile     guifg=#3f6142 
hi DiffAdded       guifg=#588C5C
hi DiffRemoved     guifg=#734545
hi DiffChanged     guifg=#588385
hi Directory       guifg=#3F6142
hi Error           guifg=#BF5F5F guibg=#121212
hi ErrorMsg        guifg=#BF5F5F guibg=#121212
hi Exception       guifg=#BF7397
hi Float           guifg=#BF5F5F
hi FoldColumn      guifg=#588385 guibg=#1C1C1C
hi Folded          guifg=#588385 guibg=#1C1C1C
hi Function        guifg=#808045
hi Identifier      guifg=#BDA45A
hi IncSearch       guibg=#FF5FFF guifg=#2E2E2E
hi Keyword         guifg=#BDA45A gui=none
hi Label           guifg=#BDA45A
hi LineNr          guifg=#5E5D5E 
hi Macro           guifg=#BDA45A
hi ModeMsg         guifg=#808045
hi MoreMsg         guifg=#47B3AE
hi NonText         guifg=#5E5D5E
hi Number          guifg=#466380
hi Operator        guifg=#5F8700
hi PreCondit       guifg=#588C5C
hi PreProc         guifg=#AF5F00
hi Question        guifg=#47B3AE
hi Repeat          guifg=#47B3AE
hi Search          guifg=#FF5FFF guibg=#2E2E2E
hi SpecialChar     guifg=#BF7397
hi SpecialComment  guifg=#87AF87
hi Special         guifg=#BF7397
hi SpecialKey      guifg=#588C5C
hi Statement       guifg=#466380 gui=none
hi StatusLine      guifg=#768EA6 guibg=#1C1C1C gui=none
hi StatusLineNC    guifg=#1C1C1C guibg=#768EA6
hi StorageClass    guifg=#588385 gui=none
hi String          guifg=#588C5C
hi Structure       guifg=#6A8FB3
hi Tag             guifg=#8C6981 gui=none
hi Title           guifg=#999999
hi Todo            guifg=#87AF87 guibg=#2E2E2E
hi Typedef         guifg=#BF5F5F
hi Type            guifg=#8C6981
hi Underlined      guifg=#8787D7 guibg=#1C1C1C
hi VertSplit       guifg=#5F675F guibg=#2E2E2E
hi Visual          guifg=#FF8787 guibg=#2E2E2E
hi VisualNOS       guifg=#FF8787 guibg=#2E2E2E
hi WarningMsg      guifg=#BF5F5F guibg=#1C1C1C
hi WildMenu        guibg=#1C1C1C guifg=#47B3AE

" spellchecking
hi SpellBad        guisp=#5E5D5E guifg=#5E5D5E
hi SpellCap        guisp=#47B3AE guifg=#EF5F5F
hi SpellRare       guisp=#6A8FB3 guifg=#6A8FB3
hi SpellLocal      guisp=#BF7397 guifg=#BF7387

" pmenu
hi PMenu           guifg=#999999 guibg=#1C1C1C
hi PMenuSel        guifg=#FFD7AF guibg=#1C1C1C

"
" term zone
"
hi Normal          ctermfg=7
hi Boolean         ctermfg=13
hi Character       ctermfg=7
hi Comment         ctermfg=8
hi Conditional     ctermfg=11
hi Constant        ctermfg=13
hi Cursor          ctermfg=233 ctermbg=12
hi Debug           ctermfg=13
hi Define          ctermfg=11
hi Delimiter       ctermfg=8
hi DiffLine        ctermfg=4 
hi DiffOldLine     ctermfg=1
hi DiffOldFile     ctermfg=1
hi DiffNewFile     ctermfg=2
hi DiffAdded       ctermfg=10
hi DiffRemoved     ctermfg=1
hi DiffChanged     ctermfg=6
hi Directory       ctermfg=2
hi Error           ctermfg=9   ctermbg=233
hi ErrorMsg        ctermfg=9   ctermbg=233
hi Exception       ctermfg=13
hi Float           ctermfg=9
hi FoldColumn      ctermfg=6 ctermbg=0
hi Folded          ctermfg=6 ctermbg=0
hi Function        ctermfg=3
hi Identifier      ctermfg=11
hi IncSearch       ctermbg=207 ctermfg=236
hi Keyword         ctermfg=11
hi Label           ctermfg=11
hi LineNr          ctermfg=8   ctermbg=233
hi Macro           ctermfg=11
hi ModeMsg         ctermfg=3
hi MoreMsg         ctermfg=14
hi NonText         ctermfg=8   ctermbg=233
hi Number          ctermfg=4
hi Operator        ctermfg=64
hi PreCondit       ctermfg=10  cterm=none
hi PreProc         ctermfg=130
hi Question        ctermfg=14
hi Repeat          ctermfg=14
hi Search          ctermfg=207 ctermbg=236
hi SpecialChar     ctermfg=13
hi SpecialComment  ctermfg=108
hi Special         ctermfg=13
hi SpecialKey      ctermfg=10
hi Statement       ctermfg=4
hi StatusLine      ctermfg=66  ctermbg=0   cterm=none
hi StatusLineNC    ctermfg=0   ctermbg=66 
hi StorageClass    ctermfg=6
hi String          ctermfg=10
hi Structure       ctermfg=12
hi Tag             ctermfg=5
hi Title           ctermfg=7   ctermbg=234 cterm=bold
hi Todo            ctermfg=108 ctermbg=234
hi Typedef         ctermfg=9
hi Type            ctermfg=5
hi Underlined      ctermfg=104 ctermbg=233
hi VertSplit       ctermfg=65  ctermbg=236
hi Visual          ctermfg=210 ctermbg=236
hi VisualNOS       ctermfg=210 ctermbg=236
hi WarningMsg      ctermfg=9   ctermbg=0
hi WildMenu        ctermbg=0   ctermfg=14
hi CursorLine      ctermbg=0   cterm=none

" spellchecking
hi SpellLocal      ctermfg=14  ctermbg=14
hi SpellBad        ctermfg=9   ctermbg=9
hi SpellCap        ctermfg=12  ctermbg=12
hi SpellRare       ctermfg=13  ctermbg=13

" pmenu
hi PMenu           ctermfg=7   ctermbg=0
hi PMenuSel        ctermfg=223 ctermbg=233

