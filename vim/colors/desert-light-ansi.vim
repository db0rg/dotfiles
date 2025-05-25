" Desert Light color scheme for Vim (ANSI terminal version)
" Designed to work with terminals using Desert Light palette

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "desert-light-ansi"

" Set background to light
set background=light

" Basic highlighting using terminal colors
hi Normal ctermfg=0 ctermbg=15
hi Comment ctermfg=8 cterm=italic
hi Constant ctermfg=1
hi String ctermfg=2
hi Character ctermfg=2
hi Number ctermfg=1
hi Boolean ctermfg=1
hi Float ctermfg=1
hi Identifier ctermfg=4 cterm=none
hi Function ctermfg=4
hi Statement ctermfg=3 cterm=bold
hi Conditional ctermfg=3 cterm=bold
hi Repeat ctermfg=3 cterm=bold
hi Label ctermfg=3
hi Operator ctermfg=0
hi Keyword ctermfg=3 cterm=bold
hi Exception ctermfg=1 cterm=bold
hi PreProc ctermfg=5
hi Include ctermfg=5
hi Define ctermfg=5
hi Macro ctermfg=5
hi PreCondit ctermfg=5
hi Type ctermfg=6
hi StorageClass ctermfg=6
hi Structure ctermfg=6
hi Typedef ctermfg=6
hi Special ctermfg=1
hi SpecialChar ctermfg=1
hi Tag ctermfg=3
hi Delimiter ctermfg=0
hi SpecialComment ctermfg=8 cterm=italic
hi Debug ctermfg=1
hi Underlined ctermfg=4 cterm=underline
hi Error ctermfg=15 ctermbg=1
hi Todo ctermfg=0 ctermbg=11 cterm=bold

" UI elements
hi Cursor ctermfg=15 ctermbg=0
hi CursorLine ctermbg=7 cterm=none
hi CursorLineNr ctermfg=3 cterm=bold
hi LineNr ctermfg=8
hi VertSplit ctermfg=8 ctermbg=8
hi MatchParen ctermbg=14 cterm=bold
hi StatusLine ctermfg=15 ctermbg=0 cterm=bold
hi StatusLineNC ctermfg=7 ctermbg=8
hi Pmenu ctermfg=0 ctermbg=7
hi PmenuSel ctermfg=15 ctermbg=4
hi IncSearch ctermfg=15 ctermbg=3
hi Search ctermfg=15 ctermbg=11
hi Directory ctermfg=4
hi Folded ctermfg=8 ctermbg=7
hi FoldColumn ctermfg=8 ctermbg=7
hi Visual ctermbg=7
hi VisualNOS ctermbg=7
hi WarningMsg ctermfg=1
hi ErrorMsg ctermfg=15 ctermbg=1
hi WildMenu ctermfg=15 ctermbg=4
hi Question ctermfg=2 cterm=bold
hi Title ctermfg=5 cterm=bold
hi ModeMsg ctermfg=3 cterm=bold
hi MoreMsg ctermfg=2

" Diff highlighting
hi DiffAdd ctermbg=10
hi DiffChange ctermbg=11
hi DiffDelete ctermfg=1 ctermbg=9
hi DiffText ctermbg=3 cterm=bold

" Spell checking
hi SpellBad cterm=undercurl ctermfg=1
hi SpellCap cterm=undercurl ctermfg=4
hi SpellLocal cterm=undercurl ctermfg=6
hi SpellRare cterm=undercurl ctermfg=5