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
hi Normal                  guifg=#B3B3B3 guibg=#080808
hi Boolean                 guifg=#BF7397
hi Character               guifg=#808080 guibg=#080808 gui=none 
hi Comment                 guifg=#595959 gui=italic
hi Conditional             guifg=#CCB462
hi Constant                guifg=#87870D
hi Cursor                  guifg=#080808 guibg=#356139
hi Debug                   guifg=#BF7397
hi Define                  guifg=#CCB462 
hi Delimiter               guifg=#595959
hi DiffLine                guifg=#406080
hi DiffOldLine             guifg=#732E2E
hi DiffOldFile             guifg=#732E2E
hi DiffNewFile             guifg=#356139 
hi DiffAdded               guifg=#4D8C51
hi DiffRemoved             guifg=#732E2E
hi DiffChanged             guifg=#498285
hi Directory               guifg=#356139
hi Error                   guifg=#B23535 guibg=#080808
hi ErrorMsg                guifg=#B23535 guibg=#080808
hi Exception               guifg=#BF7397
hi Float                   guifg=#498285
hi FoldColumn              guifg=#498285 guibg=#121212
hi Folded                  guifg=#498285 guibg=#121212
hi Function                guifg=#87870D
hi Identifier              guifg=#CCB462
hi IncSearch               guibg=#FF5FFF guifg=#262626
hi Keyword                 guifg=#CCB462 gui=none
hi Label                   guifg=#CCB462
hi LineNr                  guifg=#595959 
hi Macro                   guifg=#CCB462
hi ModeMsg                 guifg=#87870D
hi Moded                   guifg=#B23535 guibg=#121212
hi MoreMsg                 guifg=#47B3AE
hi NonText                 guifg=#595959
hi Number                  guifg=#406080
hi Operator                guifg=#AF5F00
hi PreCondit               guifg=#4D8C51
hi PreProc                 guifg=#8787D7
hi Question                guifg=#47B3AE
hi Repeat                  guifg=#47B3AE
hi Search                  guifg=#FF5FFF guibg=#262626
hi SpecialChar             guifg=#BF7397
hi SpecialComment          guifg=#87AF87
hi Special                 guifg=#BF7397
hi SpecialKey              guifg=#4D8C51
hi Statement               guifg=#406080 gui=none
hi StatusLine              guifg=#5F5F87 guibg=#121212 gui=none
hi StatusLineNC            guifg=#121212 guibg=#5F5F87
hi StorageClass            guifg=#498285 gui=none
hi String                  guifg=#4D8C51
hi Structure               guifg=#5B88B3
hi Tag                     guifg=#8C6981 gui=none
hi Title                   guifg=#999999
hi Todo                    guifg=#87AF87 guibg=#121212
hi Typedef                 guifg=#B23535
hi Type                    guifg=#8C6981 gui=none
hi Underlined              guifg=#8787D7 guibg=#080808
hi VertSplit               guifg=#5F675F guibg=#262626
hi Visual                  guifg=#FF8787 guibg=#262626
hi VisualNOS               guifg=#FF8787 guibg=#262626
hi WarningMsg              guifg=#B23535 guibg=#080808
hi WildMenu                guibg=#121212 guifg=#8787D7
hi CursorLine              guibg=#121212 gui=none

" spellchecking
hi SpellBad                guisp=#B23535 guifg=#B23535 gui=underline
hi SpellCap                guisp=#47B3AE guifg=#EF5F5F gui=underline
hi SpellRare               guisp=#5B88B3 guifg=#5B88B3 gui=underline
hi SpellLocal              guisp=#BF7397 guifg=#BF7387 gui=underline

" pmenu
hi PMenu                   guifg=#999999 guibg=#1C1C1C
hi PMenuSel                guifg=#FFD7AF guibg=#1C1C1C

" html
hi htmlTag                 guifg=#5B88B3
hi htmlEndTag              guifg=#5B88B3
hi htmlTagName             guifg=#D7AF57

" perl
hi perlSharpBang           guifg=#4D8C51 gui=italic
hi perlStatement           guifg=#BF7397
hi perlStatementStorage    guifg=#732E2E
hi perlVarPlain            guifg=#498285
hi perlVarPlain2           guifg=#D7AF57

" ruby
hi rubySharpBang           guifg=#4D8C51 gui=italic

" mini buffer explorer
hi MBENormal               guifg=#595959 
hi MBEChanged              guifg=#732E2E
hi MBEVisibleNormal        guifg=#8C627F
hi MBEVisibleNormalActive  guifg=#BF6992
hi MBEVisibleChanged       guifg=#808080
hi MBEVisibleChangedActive guifg=#B23535

"
" term zone
"
"hi Normal                  ctermfg=15
hi Boolean                 ctermfg=13
"hi Character               ctermfg=7
hi Comment                 ctermfg=8   cterm=standout
hi Conditional             ctermfg=11
hi Constant                ctermfg=3
hi Cursor                  ctermfg=232 ctermbg=12
hi Debug                   ctermfg=13
hi Define                  ctermfg=11
hi Delimiter               ctermfg=8
hi DiffLine                ctermfg=4 
hi DiffOldLine             ctermfg=1
hi DiffOldFile             ctermfg=1
hi DiffNewFile             ctermfg=2
hi DiffAdded               ctermfg=10
hi DiffRemoved             ctermfg=1
hi DiffChanged             ctermfg=6
hi Directory               ctermfg=2
hi Error                   ctermfg=9   ctermbg=232
hi ErrorMsg                ctermfg=9   ctermbg=232
hi Exception               ctermfg=13
hi Float                   ctermfg=14
hi FoldColumn              ctermfg=6   ctermbg=233
hi Folded                  ctermfg=6   ctermbg=233
hi Function                ctermfg=3
hi Identifier              ctermfg=11
hi IncSearch               ctermbg=207 ctermfg=235
hi Keyword                 ctermfg=11
hi Label                   ctermfg=11
hi LineNr                  ctermfg=8   ctermbg=232
hi Macro                   ctermfg=11
hi Moded                   ctermfg=9   ctermbg=233
hi ModeMsg                 ctermfg=3
hi MoreMsg                 ctermfg=14
hi NonText                 ctermfg=8   ctermbg=232
hi Number                  ctermfg=4
hi Operator                ctermfg=130
hi PreCondit               ctermfg=10  cterm=none
hi PreProc                 ctermfg=104
hi Question                ctermfg=14
hi Repeat                  ctermfg=14
hi Search                  ctermfg=207 ctermbg=235
hi SpecialChar             ctermfg=13
hi SpecialComment          ctermfg=108
hi Special                 ctermfg=13
hi SpecialKey              ctermfg=10
hi Statement               ctermfg=4
hi StatusLine              ctermfg=60  ctermbg=233 cterm=none
hi StatusLineNC            ctermfg=233 ctermbg=60
hi StorageClass            ctermfg=6
hi String                  ctermfg=10
hi Structure               ctermfg=12
hi Tag                     ctermfg=5
hi Title                   ctermfg=7   ctermbg=233 cterm=bold
hi Todo                    ctermfg=108 ctermbg=233
hi Typedef                 ctermfg=9
hi Type                    ctermfg=5
hi Underlined              ctermfg=104 ctermbg=232
hi VertSplit               ctermfg=65  ctermbg=235
hi Visual                  ctermfg=210 ctermbg=235
hi VisualNOS               ctermfg=210 ctermbg=235
hi WarningMsg              ctermfg=9   ctermbg=232
hi WildMenu                ctermbg=233 ctermfg=104
hi CursorLine              ctermbg=233 cterm=none

" spellchecking
hi SpellLocal              ctermfg=15  ctermbg=14  cterm=underline
hi SpellBad                ctermfg=15   ctermbg=9   cterm=underline
hi SpellCap                ctermfg=15  ctermbg=12  cterm=underline
hi SpellRare               ctermfg=15  ctermbg=13  cterm=underline

" pmenu
hi PMenu                   ctermfg=7   ctermbg=0
hi PMenuSel                ctermfg=223 ctermbg=0

" html
hi htmlTag                 ctermfg=12
hi htmlEndTag              ctermfg=12
hi htmlTagName             ctermfg=11

" perl
hi perlSharpBang           ctermfg=10  cterm=standout
hi perlStatement           ctermfg=13
hi perlStatementStorage    ctermfg=1
hi perlVarPlain            ctermfg=6
hi perlVarPlain2           ctermfg=11

" ruby
hi rubySharpBang           ctermfg=10  cterm=standout

" mini buffer explorer
hi MBENormal               ctermfg=8
hi MBEChanged              ctermfg=1
hi MBEVisibleNormal        ctermfg=5
hi MBEVisibleNormalActive  ctermfg=13
hi MBEVisibleChanged       ctermfg=7
hi MBEVisibleChangedActive ctermfg=9

