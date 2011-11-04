" dc3 a.k.a. darcourses v. 3 colour scheme for Vim
" " " " linux console mode " " " "
" Author:  bohoomil
" Date:    November, 2011
" Release: 1.0
"
" This theme is supposed to be used
" with dc3 .Xdefaults colour settings
" (should be included in the shell rc file
" in order to make them work in a X-less 
" environment). Additionaly, a conditional
" statement must be placed in .vimrc in the 
" theme loading section.

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="dc3c"

hi Normal                  ctermfg=white
hi Boolean                 ctermfg=magenta cterm=bold
hi Character               ctermfg=white
hi Comment                 ctermfg=black   ctermbg=none     cterm=bold
hi Conditional             ctermfg=cyan
hi Constant                ctermfg=yellow
hi Debug                   ctermfg=magenta cterm=bold
hi Define                  ctermfg=yellow  cterm=bold
hi Delimiter               ctermfg=black   cterm=bold
hi DiffLine                ctermfg=blue
hi DiffOldLine             ctermfg=red     ctermbg=none
hi DiffOldFile             ctermfg=red     ctermbg=none
hi DiffNewFile             ctermfg=green   ctermbg=none
hi DiffAdd                 ctermfg=green   ctermbg=none     cterm=bold
hi DiffAdded               ctermfg=green   ctermbg=none     cterm=bold
hi DiffDelete              ctermfg=red     ctermbg=none
hi DiffRemoved             ctermfg=red     ctermbg=none
hi DiffChange              ctermfg=cyan    ctermbg=none
hi DiffChanged             ctermfg=cyan    ctermbg=none
hi DiffText                ctermfg=blue    ctermbg=none     cterm=bold
hi Directory               ctermfg=green
hi Error                   ctermfg=red     ctermbg=none     cterm=bold
hi ErrorMsg                ctermfg=red     ctermbg=none     cterm=bold
hi Exception               ctermfg=magenta cterm=bold
hi Float                   ctermfg=cyan    cterm=bold
hi FoldColumn              ctermfg=black   ctermbg=white
hi Folded                  ctermfg=black   ctermbg=white
hi Function                ctermfg=yellow
hi Identifier              ctermfg=yellow  cterm=none       cterm=bold
hi IncSearch               ctermfg=white   ctermbg=magenta  cterm=bold
hi Keyword                 ctermfg=blue
hi Label                   ctermfg=magenta
hi LineNr                  ctermfg=black   cterm=bold
hi Macro                   ctermfg=yellow
hi MatchParen              ctermfg=black   ctermbg=cyan     cterm=bold
hi ModeMsg                 ctermfg=yellow  cterm=bold
hi MoreMsg                 ctermfg=cyan    cterm=bold
hi NonText                 ctermfg=black   ctermbg=none     cterm=bold
hi Number                  ctermfg=green   cterm=bold
hi Operator                ctermfg=red     cterm=bold
hi PreCondit               ctermfg=cyan    cterm=bold
hi PreProc                 ctermfg=blue    cterm=bold
hi Question                ctermfg=cyan    cterm=bold
hi Repeat                  ctermfg=cyan    cterm=bold
hi Search                  ctermfg=white   ctermbg=magenta  cterm=bold
hi SpecialChar             ctermfg=magenta cterm=bold
hi SpecialComment          ctermfg=black   cterm=bold
hi Special                 ctermfg=magenta cterm=bold
hi SpecialKey              ctermfg=green   cterm=bold
hi Statement               ctermfg=blue
hi StorageClass            ctermfg=blue
hi String                  ctermfg=green
hi Structure               ctermfg=cyan    cterm=bold
hi Tag                     ctermfg=magenta
hi Title                   ctermfg=white
hi Todo                    ctermfg=green   ctermbg=none
hi Typedef                 ctermfg=blue
hi Type                    ctermfg=magenta
hi Underlined              ctermfg=white   cterm=underline
hi VertSplit               ctermfg=green   ctermbg=black    cterm=bold
hi Visual                  ctermfg=white   ctermbg=black    cterm=bold
hi VisualNOS               ctermfg=green   ctermbg=black    cterm=bold
hi WarningMsg              ctermfg=red     cterm=bold
hi WildMenu                ctermbg=black   ctermfg=magenta  cterm=bold

" statusline
hi StatusLine              ctermfg=white   ctermbg=darkgrey cterm=bold 
hi StatusLineNC            ctermfg=white   ctermbg=darkgrey cterm=bold
hi StatusModFlag           ctermfg=red     ctermbg=black    cterm=bold
hi StatusRO                ctermfg=magenta ctermbg=black    cterm=bold
hi StatusHLP               ctermfg=green   ctermbg=black    cterm=bold
hi StatusPRV               ctermfg=yellow  ctermbg=black    cterm=bold
hi StatusFTP               ctermfg=blue    ctermbg=black    cterm=bold

" spellchecking
hi SpellLocal              ctermfg=black   ctermbg=cyan     cterm=bold,underline
hi SpellBad                ctermfg=white   ctermbg=red      cterm=bold,underline
hi SpellCap                ctermfg=black   ctermbg=blue     cterm=bold,underline
hi SpellRare               ctermfg=black   ctermbg=magenta  cterm=bold,underline

" pmenu
hi Pmenu                   ctermfg=white   ctermbg=black
hi PmenuSel                ctermfg=none    ctermbg=black    cterm=bold
hi PmenuSbar               ctermfg=black   ctermbg=white    cterm=bold

" html
hi htmlTag                 ctermfg=blue    cterm=bold
hi htmlEndTag              ctermfg=cyan
hi htmlTagName             ctermfg=yellow  cterm=bold

" xml
hi xmlTag                  ctermfg=cyan
hi xmlEndTag               ctermfg=cyan
hi xmlTagName              ctermfg=yellow

" perl
hi perlStatement           ctermfg=magenta cterm=bold
hi perlStatementStorage    ctermfg=red
hi perlVarPlain            ctermfg=cyan
hi perlVarPlain2           ctermfg=yellow  cterm=bold

" mini buffer explorer
hi MBENormal               ctermfg=black   cterm=bold
hi MBEChanged              ctermfg=red
hi MBEVisibleNormal        ctermfg=magenta
hi MBEVisibleNormalActive  ctermfg=magenta cterm=bold
hi MBEVisibleChanged       ctermfg=white
hi MBEVisibleChangedActive ctermfg=red     cterm=bold

" rst
hi rstEmphasis             ctermfg=white   cterm=underline

