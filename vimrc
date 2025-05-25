set number
set relativenumber
set incsearch
set hlsearch
set mouse=a
set mousemodel=extend
set showmatch
syntax on
set wildmenu
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal expandtab
autocmd FileType python setlocal softtabstop=4
set background=light
" Enable true colors if your terminal supports it
if exists('+termguicolors')
  set termguicolors
endif


" Set color scheme to Desert Light
if has('nvim')
  colorscheme desert-light
else
  " For regular vim, use built-in light themes that work well
  try
    " Try zellner first - it's closest to desert light
    colorscheme zellner
  catch
    " If that fails, use morning as fallback
    colorscheme morning
  endtry
  set background=light
  
  " Override some colors to be more like desert light
  hi Normal ctermfg=Black ctermbg=White
  hi Comment ctermfg=DarkGray
  hi Constant ctermfg=DarkRed
  hi String ctermfg=DarkGreen
  hi Statement ctermfg=Brown
  hi Type ctermfg=DarkCyan
  hi Special ctermfg=DarkMagenta
endif


" Add a subtle vertical column at 80 chars
" set colorcolumn=80
" highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

" Make the status line more visible
set laststatus=2
highlight StatusLine cterm=bold gui=bold

" Highlight the current line
set cursorline
highlight CursorLine ctermbg=lightyellow guibg=lightyellow


