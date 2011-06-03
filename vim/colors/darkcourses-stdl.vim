" darkcourses colours for (g)Vim
" Author:  bohoomil
" Date:    April, 2011
" Release: 1.0 semi-final
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
hi Normal                  guifg=#999999 guibg=#020202
hi Boolean                 guifg=#B248B2
hi Character               guifg=#808080 guibg=#020202 gui=none 
hi Comment                 guifg=#4C4C4C gui=italic
hi Conditional             guifg=#CCBB66
hi Constant                guifg=#80800D
hi Cursor                  guifg=#020202 guibg=#336633
hi Debug                   guifg=#B248B2
hi Define                  guifg=#CCBB66 
hi Delimiter               guifg=#4C4C4C
hi DiffLine                guifg=#406080
hi DiffOldLine             guifg=#803333
hi DiffOldFile             guifg=#803333
hi DiffNewFile             guifg=#336633 
hi DiffAdded               guifg=#4C994C
hi DiffRemoved             guifg=#803333
hi DiffChanged             guifg=#408080
hi Directory               guifg=#336633
hi Error                   guifg=#B23635 guibg=#020202
hi ErrorMsg                guifg=#B23635 guibg=#020202
hi Exception               guifg=#B248B2
hi Float                   guifg=#47B3B3
hi FoldColumn              guifg=#408080 guibg=#121212
hi Folded                  guifg=#408080 guibg=#121212
hi Function                guifg=#80800D
hi Identifier              guifg=#CCBB66
hi IncSearch               guibg=#FF5FFF guifg=#262626
hi Keyword                 guifg=#CCBB66 gui=none
hi Label                   guifg=#CCBB66
hi LineNr                  guifg=#4C4C4C 
hi Macro                   guifg=#CCBB66
hi ModeMsg                 guifg=#80800D
hi Moded                   guifg=#B23635 guibg=#1A1A1A
hi ModeMsg                 guifg=#80800D
hi MoreMsg                 guifg=#47B3B3
hi NonText                 guifg=#4C4C4C
hi Number                  guifg=#406080
hi Operator                guifg=#AF5F00
hi PreCondit               guifg=#4C994C
hi PreProc                 guifg=#8787D7
hi Question                guifg=#47B3B3
hi Repeat                  guifg=#47B3B3
hi Search                  guifg=#FF5FFF guibg=#262626
hi SpecialChar             guifg=#B248B2
hi SpecialComment          guifg=#87AF87
hi Special                 guifg=#B248B2
hi SpecialKey              guifg=#4C994C
hi Statement               guifg=#406080 gui=none
hi StorageClass            guifg=#408080 gui=none
hi String                  guifg=#4C994C
hi Structure               guifg=#487DB3
hi Tag                     guifg=#663366 gui=none
hi Title                   guifg=#808080
hi Todo                    guifg=#4C994C guibg=#1A1A1A
hi Typedef                 guifg=#B23635
hi Type                    guifg=#663366 gui=none
hi Underlined              guifg=#8787D7 guibg=#020202
hi VertSplit               guifg=#5F675F guibg=#262626
hi Visual                  guifg=#FF8787 guibg=#262626
hi VisualNOS               guifg=#FF8787 guibg=#262626
hi WarningMsg              guifg=#B23635 
hi WildMenu                guibg=#121212 guifg=#8787D7
hi CursorLine              guibg=#121212 gui=none

hi StatusLine              guifg=#808080 guibg=#1A1A1A gui=none
hi StatusLineNC            guifg=#1A1A1A guibg=#808080
hi StatusModFlag           guifg=#B23635 guibg=#1A1A1A gui=bold
hi StatusRO                guifg=#408080 guibg=#1A1A1A gui=bold
hi StatusHLP               guifg=#336633 guibg=#1A1A1A gui=bold
hi StatusPRV               guifg=#80800D guibg=#1A1A1A gui=bold
hi StatusFTP               guifg=#335A80 guibg=#1A1A1A gui=bold

" spellchecking
hi SpellBad                guisp=#B23635 guifg=#B23635 gui=underline
hi SpellCap                guisp=#47B3B3 guifg=#EF5F5F gui=underline
hi SpellRare               guisp=#487DB3 guifg=#487DB3 gui=underline
hi SpellLocal              guisp=#B248B2 guifg=#BF7387 gui=underline

" pmenu
hi PMenu                   guifg=#808080 guibg=#1A1A1A
hi PMenuSel                guifg=#D0D0D0 guibg=#4C4C4C

" html
hi htmlTag                 guifg=#487DB3
hi htmlEndTag              guifg=#487DB3
hi htmlTagName             guifg=#D7AF57

" perl
hi perlSharpBang           guifg=#4C994C gui=italic
hi perlStatement           guifg=#B248B2
hi perlStatementStorage    guifg=#803333
hi perlVarPlain            guifg=#408080
hi perlVarPlain2           guifg=#D7AF57

" ruby
hi rubySharpBang           guifg=#4C994C gui=italic

" mini buffer explorer
hi MBENormal               guifg=#4C4C4C 
hi MBEChanged              guifg=#803333
hi MBEVisibleNormal        guifg=#8C627F
hi MBEVisibleNormalActive  guifg=#BF6992
hi MBEVisibleChanged       guifg=#808080
hi MBEVisibleChangedActive guifg=#B23635

"
" term zone
"
hi Normal                  ctermfg=246 ctermbg=232
hi Boolean                 ctermfg=135
hi Comment                 ctermfg=240 cterm=none
hi Conditional             ctermfg=180
hi Constant                ctermfg=238
hi Cursor                  ctermbg=63
hi Debug                   ctermfg=135
hi Define                  ctermfg=180
hi Delimiter               ctermfg=236
hi DiffLine                ctermfg=24 
hi DiffOldLine             ctermfg=52
hi DiffOldFile             ctermfg=52
hi DiffNewFile             ctermfg=22
hi DiffAdded               ctermfg=35
hi DiffRemoved             ctermfg=52
hi DiffChanged             ctermfg=31
hi Directory               ctermfg=22
hi Error                   ctermfg=124   ctermbg=232
hi ErrorMsg                ctermfg=124   ctermbg=232
hi Exception               ctermfg=135
hi Float                   ctermfg=74
hi FoldColumn              ctermfg=31   ctermbg=232
hi Folded                  ctermfg=31   ctermbg=232
hi Function                ctermfg=58
hi Identifier              ctermfg=180
hi IncSearch               ctermbg=207 ctermfg=236
hi Keyword                 ctermfg=180
hi Label                   ctermfg=180
hi LineNr                  ctermfg=240
hi Macro                   ctermfg=180
hi ModeMsg                 ctermfg=58
hi MoreMsg                 ctermfg=74
hi NonText                 ctermfg=236 
hi Number                  ctermfg=24
hi Operator                ctermfg=130
hi PreCondit               ctermfg=35  cterm=none
hi PreProc                 ctermfg=104
hi Question                ctermfg=74
hi Repeat                  ctermfg=74
hi Search                  ctermfg=207 ctermbg=236
hi SpecialChar             ctermfg=135
hi SpecialComment          ctermfg=108
hi Special                 ctermfg=135
hi SpecialKey              ctermfg=35
hi Statement               ctermfg=24
hi StorageClass            ctermfg=31
hi String                  ctermfg=35
hi Structure               ctermfg=63
hi Tag                     ctermfg=53
hi Title                   ctermfg=244   ctermbg=none cterm=bold
hi Todo                    ctermfg=35  ctermbg=232
hi Typedef                 ctermfg=124
hi Type                    ctermfg=53
hi Underlined              ctermfg=104 ctermbg=232
hi VertSplit               ctermfg=65  ctermbg=236
hi Visual                  ctermfg=210 ctermbg=236
hi VisualNOS               ctermfg=210 ctermbg=236
hi WarningMsg              ctermfg=124   
hi WildMenu                ctermbg=232   ctermfg=104
hi CursorLine              ctermbg=232   cterm=none

" statusline
hi StatusLine              ctermfg=244   ctermbg=234    cterm=none
hi StatusLineNC            ctermfg=232   ctermbg=244
hi StatusModFlag           ctermfg=124   ctermbg=234    cterm=bold
hi StatusRO                ctermfg=31   ctermbg=234    cterm=bold
hi StatusHLP               ctermfg=22   ctermbg=234    cterm=bold
hi StatusPRV               ctermfg=58   ctermbg=234    cterm=bold
hi StatusFTP               ctermfg=24   ctermbg=234    cterm=bold

" spellchecking
hi SpellLocal              ctermfg=250  ctermbg=74   cterm=underline
hi SpellBad                ctermfg=250  ctermbg=124  cterm=underline
hi SpellCap                ctermfg=250  ctermbg=63   cterm=underline
hi SpellRare               ctermfg=250  ctermbg=135  cterm=underline

" pmenu
hi PMenu                   ctermfg=244    ctermbg=232
hi PMenuSel                ctermfg=232 ctermbg=236

" html
hi htmlTag                 ctermfg=63
hi htmlEndTag              ctermfg=63
hi htmlTagName             ctermfg=58

" perl
hi perlSharpBang           ctermfg=35  cterm=none
hi perlStatement           ctermfg=135
hi perlStatementStorage    ctermfg=52
hi perlVarPlain            ctermfg=31
hi perlVarPlain2           ctermfg=180

" ruby
hi rubySharpBang           ctermfg=35  cterm=none

" mini buffer explorer
hi MBENormal               ctermfg=236
hi MBEChanged              ctermfg=52
hi MBEVisibleNormal        ctermfg=53
hi MBEVisibleNormalActive  ctermfg=135
hi MBEVisibleChanged       ctermfg=244
hi MBEVisibleChangedActive ctermfg=124

if ($TERM =~ "rxvt" || "xterm")
	hi Comment                 ctermfg=240   cterm=italic
endif

if ($TERM =~ "screen" || "tmux")
	hi Comment                 ctermfg=240   cterm=standout
endif

