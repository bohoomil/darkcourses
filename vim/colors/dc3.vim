" dc3 a.k.a. darcourses v. 3 colour scheme for Vim
" Author:  bohoomil
" Date:    July, 2011
" Release: 1.0
"
" This theme is supposed to be used
" with dc2 .Xdefaults colour settings.
" GUI part is .Xdefaults independent.

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="dc3"

hi Normal                  ctermfg=none
hi Boolean                 ctermfg=13
hi Character               ctermfg=15
hi Comment                 ctermfg=8    ctermbg=none  cterm=none
hi Conditional             ctermfg=6
hi Constant                ctermfg=3
hi Constant                ctermfg=3
hi Cursor                  ctermbg=4
hi Debug                   ctermfg=13
hi Define                  ctermfg=130
hi Delimiter               ctermfg=8
hi DiffLine                ctermfg=4 
hi DiffOldLine             ctermfg=1   ctermbg=none
hi DiffOldFile             ctermfg=1   ctermbg=none
hi DiffNewFile             ctermfg=2   ctermbg=none
hi DiffAdd                 ctermfg=10  ctermbg=none
hi DiffAdded               ctermfg=10  ctermbg=none
hi DiffDelete              ctermfg=1   ctermbg=none
hi DiffRemoved             ctermfg=1   ctermbg=none
hi DiffChange              ctermfg=6   ctermbg=none
hi DiffChanged             ctermfg=6   ctermbg=none
hi DiffText                ctermfg=4   ctermbg=none
hi Directory               ctermfg=2
hi Error                   ctermfg=9   ctermbg=none
hi ErrorMsg                ctermfg=9   ctermbg=none
hi Exception               ctermfg=13
hi Float                   ctermfg=14
hi FoldColumn              ctermfg=14   ctermbg=0
hi Folded                  ctermfg=14   ctermbg=0
hi Function                ctermfg=3
hi Identifier              ctermfg=11  cterm=none
hi IncSearch               ctermbg=207 ctermfg=235
hi Keyword                 ctermfg=4
hi Label                   ctermfg=5
hi LineNr                  ctermfg=8 
hi Macro                   ctermfg=3   cterm=none
hi MatchParen              ctermfg=0   ctermbg=14
hi ModeMsg                 ctermfg=11
hi MoreMsg                 ctermfg=14
hi NonText                 ctermfg=8   ctermbg=none 
hi Number                  ctermfg=10
hi Operator                ctermfg=9
hi PreCondit               ctermfg=13  cterm=none
"hi PreProc                 ctermfg=67
hi PreProc                 ctermfg=67
hi Question                ctermfg=14
hi Repeat                  ctermfg=14
hi Search                  ctermfg=207 ctermbg=235
hi SpecialChar             ctermfg=13
hi SpecialComment          ctermfg=108
hi Special                 ctermfg=13
hi SpecialKey              ctermfg=10
hi Statement               ctermfg=4   ctermbg=none
hi StorageClass            ctermfg=4
hi String                  ctermfg=2   ctermbg=none
hi Structure               ctermfg=67
hi Tag                     ctermfg=5
hi Title                   ctermfg=7   ctermbg=none cterm=bold
hi Todo                    ctermfg=10  ctermbg=0
hi Typedef                 ctermfg=4
hi Type                    ctermfg=5
hi Underlined              ctermfg=7
hi VertSplit               ctermfg=65  ctermbg=235
hi Visual                  ctermfg=210 ctermbg=235
hi VisualNOS               ctermfg=10  ctermbg=235  cterm=bold
hi WarningMsg              ctermfg=9   
hi WildMenu                ctermbg=0   ctermfg=5
hi CursorLine              ctermbg=0   cterm=none

" statusline
hi StatusLine              ctermfg=7   ctermbg=0    cterm=none
hi StatusLineNC            ctermfg=0   ctermbg=7
hi StatusModFlag           ctermfg=9   ctermbg=0    cterm=none
hi StatusRO                ctermfg=13  ctermbg=0    cterm=none
hi StatusHLP               ctermfg=10  ctermbg=0    cterm=none
hi StatusPRV               ctermfg=11  ctermbg=0    cterm=none
hi StatusFTP               ctermfg=12  ctermbg=0    cterm=none

" spellchecking
hi SpellLocal              ctermfg=0   ctermbg=14  cterm=underline
hi SpellBad                ctermfg=15  ctermbg=1   cterm=underline
hi SpellCap                ctermfg=0   ctermbg=12  cterm=underline
hi SpellRare               ctermfg=0   ctermbg=13  cterm=underline

" pmenu
hi Pmenu                   ctermfg=7    ctermbg=0
hi PmenuSel                ctermfg=none ctermbg=8 
hi PmenuSbar               ctermfg=8    ctermbg=15

" html
hi htmlTag                 ctermfg=12
hi htmlEndTag              ctermfg=4
hi htmlTagName             ctermfg=11

" xml
hi xmlTag                  ctermfg=4
hi xmlEndTag               ctermfg=4
hi xmlTagName              ctermfg=3

" perl
hi perlStatement           ctermfg=13
hi perlStatementStorage    ctermfg=1
hi perlVarPlain            ctermfg=6
hi perlVarPlain2           ctermfg=11

" mini buffer explorer
hi MBENormal               ctermfg=8
hi MBEChanged              ctermfg=1
hi MBEVisibleNormal        ctermfg=5
hi MBEVisibleNormalActive  ctermfg=13
hi MBEVisibleChanged       ctermfg=7
hi MBEVisibleChangedActive ctermfg=9

" rst
hi rstEmphasis             ctermfg=7   cterm=underline

