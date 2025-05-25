" Desert Light color scheme for Vim/Neovim
" Based on the Desert theme but with a light background
" Author: Claude

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "desert-light"

" Set background to light
set background=light

" GUI and terminal color definitions
let s:colors = {}
let s:colors.bg = '#f7f3e3'
let s:colors.fg = '#5f5f5f'
let s:colors.black = '#605958'
let s:colors.red = '#d75f5f'
let s:colors.green = '#5f8700'
let s:colors.yellow = '#af8700'
let s:colors.blue = '#5f87af'
let s:colors.magenta = '#af5f87'
let s:colors.cyan = '#5f8787'
let s:colors.white = '#8a8a8a'
let s:colors.brightblack = '#7f7f7f'
let s:colors.brightred = '#ff5f5f'
let s:colors.brightgreen = '#87af00'
let s:colors.brightyellow = '#d7af00'
let s:colors.brightblue = '#87afd7'
let s:colors.brightmagenta = '#d787af'
let s:colors.brightcyan = '#87afaf'
let s:colors.brightwhite = '#ffffff'

" Basic highlighting
execute 'hi Normal guifg=' . s:colors.fg . ' guibg=' . s:colors.bg
execute 'hi Comment guifg=' . s:colors.brightblack . ' gui=italic'
execute 'hi Constant guifg=' . s:colors.red
execute 'hi String guifg=' . s:colors.green
execute 'hi Character guifg=' . s:colors.green
execute 'hi Number guifg=' . s:colors.red
execute 'hi Boolean guifg=' . s:colors.red
execute 'hi Float guifg=' . s:colors.red
execute 'hi Identifier guifg=' . s:colors.blue
execute 'hi Function guifg=' . s:colors.blue
execute 'hi Statement guifg=' . s:colors.yellow . ' gui=bold'
execute 'hi Conditional guifg=' . s:colors.yellow . ' gui=bold'
execute 'hi Repeat guifg=' . s:colors.yellow . ' gui=bold'
execute 'hi Label guifg=' . s:colors.yellow
execute 'hi Operator guifg=' . s:colors.black
execute 'hi Keyword guifg=' . s:colors.yellow . ' gui=bold'
execute 'hi Exception guifg=' . s:colors.red . ' gui=bold'
execute 'hi PreProc guifg=' . s:colors.magenta
execute 'hi Include guifg=' . s:colors.magenta
execute 'hi Define guifg=' . s:colors.magenta
execute 'hi Macro guifg=' . s:colors.magenta
execute 'hi PreCondit guifg=' . s:colors.magenta
execute 'hi Type guifg=' . s:colors.cyan
execute 'hi StorageClass guifg=' . s:colors.cyan
execute 'hi Structure guifg=' . s:colors.cyan
execute 'hi Typedef guifg=' . s:colors.cyan
execute 'hi Special guifg=' . s:colors.red
execute 'hi SpecialChar guifg=' . s:colors.red
execute 'hi Tag guifg=' . s:colors.yellow
execute 'hi Delimiter guifg=' . s:colors.black
execute 'hi SpecialComment guifg=' . s:colors.brightblack . ' gui=italic'
execute 'hi Debug guifg=' . s:colors.red
execute 'hi Underlined guifg=' . s:colors.blue . ' gui=underline'
execute 'hi Error guifg=' . s:colors.brightwhite . ' guibg=' . s:colors.red
execute 'hi Todo guifg=' . s:colors.black . ' guibg=' . s:colors.brightyellow . ' gui=bold'

" UI elements
execute 'hi Cursor guifg=' . s:colors.bg . ' guibg=' . s:colors.fg
execute 'hi CursorLine gui=underline guibg=NONE'
execute 'hi CursorLineNr guifg=' . s:colors.yellow . ' gui=bold'
execute 'hi LineNr guifg=' . s:colors.brightblack
execute 'hi VertSplit guifg=' . s:colors.brightblack . ' guibg=' . s:colors.brightblack
execute 'hi MatchParen guibg=' . s:colors.brightcyan . ' gui=bold'
execute 'hi StatusLine guifg=' . s:colors.brightwhite . ' guibg=' . s:colors.black . ' gui=bold'
execute 'hi StatusLineNC guifg=' . s:colors.white . ' guibg=' . s:colors.brightblack
execute 'hi Pmenu guifg=' . s:colors.fg . ' guibg=#d7d7af'
execute 'hi PmenuSel guifg=' . s:colors.bg . ' guibg=' . s:colors.blue
execute 'hi IncSearch guifg=' . s:colors.bg . ' guibg=' . s:colors.yellow
execute 'hi Search guifg=' . s:colors.bg . ' guibg=' . s:colors.brightyellow
execute 'hi Directory guifg=' . s:colors.blue
execute 'hi Folded guifg=' . s:colors.brightblack . ' guibg=#e7e3d3'
execute 'hi FoldColumn guifg=' . s:colors.brightblack . ' guibg=#e7e3d3'
execute 'hi Visual guibg=#d7d7af'
execute 'hi VisualNOS guibg=#d7d7af'
execute 'hi WarningMsg guifg=' . s:colors.red
execute 'hi ErrorMsg guifg=' . s:colors.brightwhite . ' guibg=' . s:colors.red
execute 'hi WildMenu guifg=' . s:colors.bg . ' guibg=' . s:colors.blue
execute 'hi Question guifg=' . s:colors.green . ' gui=bold'
execute 'hi Title guifg=' . s:colors.magenta . ' gui=bold'
execute 'hi ModeMsg guifg=' . s:colors.yellow . ' gui=bold'
execute 'hi MoreMsg guifg=' . s:colors.green

" Diff highlighting
execute 'hi DiffAdd guibg=#c7e6c7'
execute 'hi DiffChange guibg=#e6e6c7'
execute 'hi DiffDelete guifg=' . s:colors.red . ' guibg=#e6c7c7'
execute 'hi DiffText guibg=#e6d8c7 gui=bold'

" Spell checking
execute 'hi SpellBad guisp=' . s:colors.red . ' gui=undercurl'
execute 'hi SpellCap guisp=' . s:colors.blue . ' gui=undercurl'
execute 'hi SpellLocal guisp=' . s:colors.cyan . ' gui=undercurl'
execute 'hi SpellRare guisp=' . s:colors.magenta . ' gui=undercurl'

" Neovim specific
if has('nvim')
  execute 'hi NormalFloat guifg=' . s:colors.fg . ' guibg=#e7e3d3'
  execute 'hi FloatBorder guifg=' . s:colors.brightblack . ' guibg=#e7e3d3'
  execute 'hi TermCursor guifg=' . s:colors.bg . ' guibg=' . s:colors.fg
  execute 'hi TermCursorNC guifg=' . s:colors.bg . ' guibg=' . s:colors.brightblack
endif