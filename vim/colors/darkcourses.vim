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
hi Cursor                  guifg=#335A80 guibg=#335A80
hi Debug                   guifg=#B248B2
hi Define                  guifg=#CCBB66 
hi Delimiter               guifg=#4C4C4C
hi DiffLine                guifg=#406080
hi DiffOldLine             guifg=#803333
hi DiffOldFile             guifg=#803333
hi DiffNewFile             guifg=#336633 
hi DiffAdd                 guifg=#4C994C
hi DiffAdded               guifg=#4C994C
hi DiffDelete              guifg=#4C994C
hi DiffRemoved             guifg=#803333
hi DiffChange              guifg=#408080
hi DiffChanged             guifg=#408080
hi DiffText                guifg=#335A80
hi Directory               guifg=#336633
hi Error                   guifg=#B23535 guibg=#020202
hi ErrorMsg                guifg=#B23535 guibg=#020202
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
hi Moded                   guifg=#B23535 guibg=#1A1A1A
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
hi Typedef                 guifg=#B23535
hi Type                    guifg=#663366 gui=none
hi Underlined              guifg=#8787D7 guibg=#020202
hi VertSplit               guifg=#5F675F guibg=#262626
hi Visual                  guifg=#FF8787 guibg=#262626
hi VisualNOS               guifg=#4C994C guibg=#262626 gui=bold
hi WarningMsg              guifg=#B23535 
hi WildMenu                guibg=#121212 guifg=#8787D7
hi CursorLine              guibg=#121212 gui=none

hi StatusLine              guifg=#808080 guibg=#1A1A1A gui=none
hi StatusLineNC            guifg=#1A1A1A guibg=#808080
hi StatusModFlag           guifg=#B23535 guibg=#1A1A1A gui=bold
hi StatusRO                guifg=#408080 guibg=#1A1A1A gui=bold
hi StatusHLP               guifg=#336633 guibg=#1A1A1A gui=bold
hi StatusPRV               guifg=#80800D guibg=#1A1A1A gui=bold
hi StatusFTP               guifg=#335A80 guibg=#1A1A1A gui=bold

" spellchecking
hi SpellBad                guisp=#B23535 guifg=#B23535 gui=underline
hi SpellCap                guisp=#1A1A1A guifg=#487DB3 gui=underline
hi SpellRare               guisp=#1A1A1A guifg=#B248B2 gui=underline
hi SpellLocal              guisp=#1A1A1A guifg=#47B3B3 gui=underline

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
hi MBEVisibleChangedActive guifg=#B23535

"
" term zone
"
hi Normal                  ctermfg=none
hi Boolean                 ctermfg=13
hi Comment                 ctermfg=8    cterm=none
hi Conditional             ctermfg=11
hi Constant                ctermfg=3
hi Cursor                  ctermfg=4    ctermbg=4
hi Debug                   ctermfg=13
hi Define                  ctermfg=11
hi Delimiter               ctermfg=8
hi DiffLine                ctermfg=4 
hi DiffOldLine             ctermfg=1
hi DiffOldFile             ctermfg=1
hi DiffNewFile             ctermfg=2
hi DiffAdd                 ctermfg=10  ctermbg=none
hi DiffAdded               ctermfg=10
hi DiffDelete              ctermfg=1   ctermbg=none
hi DiffRemoved             ctermfg=1
hi DiffChange              ctermfg=6   ctermbg=none
hi DiffChanged             ctermfg=6
hi DiffText                ctermfg=4   ctermbg=none
hi Directory               ctermfg=2
hi Error                   ctermfg=9   ctermbg=none
hi ErrorMsg                ctermfg=9   ctermbg=none
hi Exception               ctermfg=13
hi Float                   ctermfg=14
hi FoldColumn              ctermfg=6   ctermbg=0
hi Folded                  ctermfg=6   ctermbg=0
hi Function                ctermfg=3
hi Identifier              ctermfg=11
hi IncSearch               ctermbg=207 ctermfg=235
hi Keyword                 ctermfg=11
hi Label                   ctermfg=11
hi LineNr                  ctermfg=8 
hi Macro                   ctermfg=11
hi ModeMsg                 ctermfg=3
hi MoreMsg                 ctermfg=14
hi NonText                 ctermfg=8 
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
hi StorageClass            ctermfg=6
hi String                  ctermfg=10
hi Structure               ctermfg=12
hi Tag                     ctermfg=5
hi Title                   ctermfg=7   ctermbg=none cterm=bold
hi Todo                    ctermfg=10  ctermbg=0
hi Typedef                 ctermfg=9
hi Type                    ctermfg=5
hi Underlined              ctermfg=104 ctermbg=232
hi VertSplit               ctermfg=65  ctermbg=235
hi Visual                  ctermfg=210 ctermbg=235
hi VisualNOS               ctermfg=10  ctermbg=235  cterm=bold
hi WarningMsg              ctermfg=9   
hi WildMenu                ctermbg=0   ctermfg=104
hi CursorLine              ctermbg=0   cterm=none

" statusline
hi StatusLine              ctermfg=7   ctermbg=0    cterm=none
hi StatusLineNC            ctermfg=0   ctermbg=7
hi StatusModFlag           ctermfg=9   ctermbg=0    cterm=bold
hi StatusRO                ctermfg=6   ctermbg=0    cterm=bold
hi StatusHLP               ctermfg=2   ctermbg=0    cterm=bold
hi StatusPRV               ctermfg=3   ctermbg=0    cterm=bold
hi StatusFTP               ctermfg=4   ctermbg=0    cterm=bold

" spellchecking
hi SpellLocal              ctermfg=0   ctermbg=14  cterm=underline
hi SpellBad                ctermfg=15  ctermbg=9   cterm=underline
hi SpellCap                ctermfg=0   ctermbg=12  cterm=underline
hi SpellRare               ctermfg=0   ctermbg=13  cterm=underline

" pmenu
hi PMenu                   ctermfg=7    ctermbg=0
hi PMenuSel                ctermfg=none ctermbg=8 

" html
hi htmlTag                 ctermfg=12
hi htmlEndTag              ctermfg=12
hi htmlTagName             ctermfg=3

" perl
hi perlSharpBang           ctermfg=10  cterm=none
hi perlStatement           ctermfg=13
hi perlStatementStorage    ctermfg=1
hi perlVarPlain            ctermfg=6
hi perlVarPlain2           ctermfg=11

" ruby
hi rubySharpBang           ctermfg=10  cterm=none

" mini buffer explorer
hi MBENormal               ctermfg=8
hi MBEChanged              ctermfg=1
hi MBEVisibleNormal        ctermfg=5
hi MBEVisibleNormalActive  ctermfg=13
hi MBEVisibleChanged       ctermfg=7
hi MBEVisibleChangedActive ctermfg=9

if ($TERM =~ "rxvt" || "xterm")
	hi Comment                 ctermfg=8   cterm=italic
endif

if ($TERM =~ "screen" || "tmux")
	hi Comment                 ctermfg=8   cterm=standout
endif

