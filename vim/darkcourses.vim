" darkcourses colours for (g)Vim
" Author:  bohoomil
" Date:    April, 2011
" Release: 1.0 final
"
" This theme is supposed to be used
" with darkcourses .Xdefaults colour settings.
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
hi Normal          guifg=#ABABAB guibg=#121212
hi Boolean         guifg=#BF7397
hi Character       guifg=#999999 guibg=#121212 gui=none 
hi Comment         guifg=#5E5D5E gui=italic
hi Conditional     guifg=#CCB462
hi Constant        guifg=#87870D
hi Cursor          guifg=#121212 guibg=#3F6142
hi Debug           guifg=#BF7397
hi Define          guifg=#CCB462 
hi Delimiter       guifg=#5E5D5E
hi DiffLine        guifg=#466380
hi DiffOldLine     guifg=#733939
hi DiffOldFile     guifg=#733939
hi DiffNewFile     guifg=#3f6142 
hi DiffAdded       guifg=#588C5C
hi DiffRemoved     guifg=#733939
hi DiffChanged     guifg=#588385
hi Directory       guifg=#3F6142
hi Error           guifg=#BF4C4C guibg=#121212
hi ErrorMsg        guifg=#BF4C4C guibg=#121212
hi Exception       guifg=#BF7397
hi Float           guifg=#588385
hi FoldColumn      guifg=#588385 guibg=#1C1C1C
hi Folded          guifg=#588385 guibg=#1C1C1C
hi Function        guifg=#87870D
hi Identifier      guifg=#CCB462
hi IncSearch       guibg=#FF5FFF guifg=#2E2E2E
hi Keyword         guifg=#CCB462 gui=none
hi Label           guifg=#CCB462
hi LineNr          guifg=#5E5D5E 
hi Macro           guifg=#CCB462
hi ModeMsg         guifg=#87870D
hi MoreMsg         guifg=#47B3AE
hi NonText         guifg=#5E5D5E
hi Number          guifg=#466380
hi Operator        guifg=#5F8700
hi PreCondit       guifg=#588C5C
hi PreProc         guifg=#8787D7
hi Question        guifg=#47B3AE
hi Repeat          guifg=#47B3AE
hi Search          guifg=#FF5FFF guibg=#2E2E2E
hi SpecialChar     guifg=#BF7397
hi SpecialComment  guifg=#87AF87
hi Special         guifg=#BF7397
hi SpecialKey      guifg=#588C5C
hi Statement       guifg=#466380 gui=none
hi StatusLine      guifg=#5F5F87 guibg=#1C1C1C gui=none
hi StatusLineNC    guifg=#1C1C1C guibg=#5F5F87
hi StorageClass    guifg=#588385 gui=none
hi String          guifg=#588C5C
hi Structure       guifg=#6A8FB3
hi Tag             guifg=#8C6981 gui=none
hi Title           guifg=#999999
hi Todo            guifg=#87AF87 guibg=#2E2E2E
hi Typedef         guifg=#BF4C4C
hi Type            guifg=#8C6981 gui=none
hi Underlined      guifg=#8787D7 guibg=#1C1C1C
hi VertSplit       guifg=#5F675F guibg=#2E2E2E
hi Visual          guifg=#FF8787 guibg=#2E2E2E
hi VisualNOS       guifg=#FF8787 guibg=#2E2E2E
hi WarningMsg      guifg=#BF4C4C guibg=#1C1C1C
hi WildMenu        guibg=#1C1C1C guifg=#8787D7

" spellchecking
hi SpellBad        guisp=#BF4C4C guifg=#BF4C4C  gui=underline
hi SpellCap        guisp=#47B3AE guifg=#EF5F5F  gui=underline
hi SpellRare       guisp=#6A8FB3 guifg=#6A8FB3  gui=underline
hi SpellLocal      guisp=#BF7397 guifg=#BF7387  gui=underline

" pmenu
hi PMenu           guifg=#999999 guibg=#1C1C1C
hi PMenuSel        guifg=#FFD7AF guibg=#1C1C1C

" html
hi htmlTag         guifg=#6A8FB3
hi htmlEndTag      guifg=#6A8FB3
hi htmlTagName     guifg=#D7AF57

" perl
hi perlSharpBang   guifg=#588C5C gui=italic
hi perlStatement   guifg=#BF7397
hi perlStatementStorage guifg=#733939
hi perlVarPlain    guifg=#588385
hi perlVarPlain2   guifg=#D7AF57

" ruby
hi rubySharpBang   guifg=#588C5C gui=italic

" mini buffer explorer
hi MBENormal               guifg=#5E5D5E 
hi MBEChanged              guifg=#733939
hi MBEVisibleNormal        guifg=#8C627F
hi MBEVisibleNormalActive  guifg=#BF6992
hi MBEVisibleChanged       guifg=#808080
hi MBEVisibleChangedActive guifg=#BF4C4C

"
" term zone
"
hi Normal          ctermfg=15
hi Boolean         ctermfg=13
hi Character       ctermfg=7
hi Comment         ctermfg=8   cterm=standout
hi Conditional     ctermfg=11
hi Constant        ctermfg=3
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
hi Float           ctermfg=14
hi FoldColumn      ctermfg=6   ctermbg=0
hi Folded          ctermfg=6   ctermbg=0
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
hi PreProc         ctermfg=104
hi Question        ctermfg=14
hi Repeat          ctermfg=14
hi Search          ctermfg=207 ctermbg=236
hi SpecialChar     ctermfg=13
hi SpecialComment  ctermfg=108
hi Special         ctermfg=13
hi SpecialKey      ctermfg=10
hi Statement       ctermfg=4
hi StatusLine      ctermfg=60  ctermbg=234   cterm=none
hi StatusLineNC    ctermfg=234 ctermbg=60
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
hi WildMenu        ctermbg=0   ctermfg=104
hi CursorLine      ctermbg=0   cterm=none

" spellchecking
hi SpellLocal      ctermfg=14  ctermbg=14  cterm=underline
hi SpellBad        ctermfg=9   ctermbg=9   cterm=underline
hi SpellCap        ctermfg=12  ctermbg=12  cterm=underline
hi SpellRare       ctermfg=13  ctermbg=13  cterm=underline

" pmenu
hi PMenu           ctermfg=7   ctermbg=0
hi PMenuSel        ctermfg=223 ctermbg=233

" html
hi htmlTag        ctermfg=12
hi htmlEndTag     ctermfg=12
hi htmlTagName    ctermfg=11

" perl
hi perlSharpBang  ctermfg=10  cterm=standout
hi perlStatement  ctermfg=13
hi perlStatementStorage ctermfg=1
hi perlVarPlain   ctermfg=6
hi perlVarPlain2  ctermfg=11

" ruby
hi rubySharpBang  ctermfg=10  cterm=standout

" mini buffer explorer
hi MBENormal               ctermfg=8
hi MBEChanged              ctermfg=1
hi MBEVisibleNormal        ctermfg=5
hi MBEVisibleNormalActive  ctermfg=13
hi MBEVisibleChanged       ctermfg=7
hi MBEVisibleChangedActive ctermfg=9

