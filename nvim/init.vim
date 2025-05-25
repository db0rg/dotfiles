set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
source /opt/homebrew/opt/fzf/plugin/fzf.vim
set completeopt=menu,menuone,noselect
set inccommand=split

set undofile
set undodir=~/.vim/undodir


" Highlight yanked text briefly
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=200}
augroup END

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  }
}
EOF

"lua require "coq"
"
"lua vim.lsp.enable('pyright')
"lua vim.lsp.enable('ruff')
"vim.lsp.config(<server>, <stuff...>)                              -- before
" vim.lsp.config(<server>, coq.lsp_ensure_capabilities(<stuff...>)) -- after
" vim.lsp.enable(<server>)


" Load LSP configuration
luafile ~/.config/nvim/lsp.lua

nnoremap <leader>F :let @+=expand("%")<CR>
nnoremap <leader>D :vsplit %:h<CR>
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>e :tabnew ~/.config/nvim/init.vim<CR>
vnoremap <leader>v "+p
vnoremap <leader>c "+y


let g:fzf_history_dir = expand('~/.local/share/nvim/fzf_hist')

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction


" Buffer search with actions
function! s:bufopen_with_actions(lines)
  if len(a:lines) < 2
    return
  endif
  
  let key = a:lines[0]
  let buffers = a:lines[1:]
  
  let actions = get(g:, 'fzf_action', {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' })
  
  let cmd = get(actions, key, 'buffer')
  
  for buffer in buffers
    let bufnr = matchstr(buffer, '^[ 0-9]*')
    if cmd == 'buffer'
      execute 'buffer' bufnr
    else
      execute cmd
      execute 'buffer' bufnr
    endif
  endfor
endfunction

" Updated buffer search
function! BufferSearch()
  let actions = get(g:, 'fzf_action', {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' })

  
  call fzf#run(fzf#wrap("BufferSearch", {
  \   'source':  reverse(<sid>buflist()),
  \   'sink*':   function('s:bufopen_with_actions'),
  \   'options': '--multi --prompt "Buffers>" --expect=' . join(keys(actions), ','),
  \ }))
endfunction

nnoremap <leader>b :call BufferSearch()<CR>

" Search lines in current buffer
function! s:line_handler(line)
  let line_num = split(a:line, ':')[0]
  execute line_num
endfunction

function! s:buffer_lines()
  let res = []
  for i in range(1, line('$'))
    call insert(res, i . ': ' . getline(i))
  endfor
  return res
endfunction

nnoremap <leader>l :call fzf#run(fzf#wrap({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--no-sort --prompt "Lines> "',
\ }))<CR>


function! s:file_handler_with_actions(lines)
  if len(a:lines) < 2
    return
  endif
  
  let key = a:lines[0]
  let files = a:lines[1:]
  
  let actions = get(g:, 'fzf_action', {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' })
  
  let cmd = get(actions, key, 'e')
  
  for file in files
    execute cmd . ' ' . fnameescape(file)
  endfor
endfunction

function! FileSearchWithPreview()
  let preview_cmd = executable('bat') ? 'bat --style=numbers --color=always {}' : 'cat {}'
  
  let actions = get(g:, 'fzf_action', {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' })
  
  call fzf#run(fzf#wrap("FileSearch", {
  \   'sink*': function('s:file_handler_with_actions'),
  \   'options': '--multi --expect=' . join(keys(actions), ',') . ' --preview "' . preview_cmd . '"',
  \ }))
endfunction

nnoremap <leader>f :call FileSearchWithPreview()<CR>

" Search all files using ripgrep
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let actions = get(g:, 'fzf_action', {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' })
  call fzf#run(fzf#wrap({
  \ 'source': initial_command,
  \ 'sink*': function('s:rg_handler_with_actions'),
  \ 'options': '--multi --ansi --delimiter : --nth 3.. '.
  \            '--preview "bat --style=numbers --color=always --highlight-line {2} {1}" '.
  \            '--preview-window "+{2}/2" --expect=' . join(keys(actions), ','),
  \ }, a:fullscreen))
endfunction

function! s:rg_handler_with_actions(lines)
  if len(a:lines) < 2
    return
  endif
  
  let key = a:lines[0]
  let results = a:lines[1:]
  
  let actions = get(g:, 'fzf_action', {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' })
  
  let cmd = get(actions, key, 'e')
  
  for result in results
    let parts = split(result, ':')
    if len(parts) < 2
      continue
    endif
    
    let [file, linenr] = parts[0:1]
    
    execute cmd . ' ' . fnameescape(file)
    execute linenr
    normal! zz
  endfor
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
nnoremap <leader>/ :RG<CR>


function! VisualCmdWithQuotedSelection(cmd)
  " Get the selected text
  normal! gv"xy
  let selection = @x
  
  " Escape special characters for ripgrep
  let escaped = escape(selection, '\\^$.*+?()[]{}|')

  "sleep 5
  
  " Call RG with the escaped selection
  " call a:cmd escaped
  execute a:cmd . ' ' . escaped
endfunction

" Visual mode mapping for RG
vnoremap <leader>/ :call VisualCmdWithQuotedSelection('RG')<CR>

" Search only in all open buffers
function! RipgrepBuffers(query, fullscreen)
  " Get all buffer filenames
  let buffers = []
  for i in range(1, bufnr('$'))
    if buflisted(i) && bufname(i) != ''
      call add(buffers, bufname(i))
    endif
  endfor
  
  if empty(buffers)
    echo "No buffers open"
    return
  endif

  let actions = get(g:, 'fzf_action', {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' })
  
  " Create ripgrep command for only these files
  let files = join(map(buffers, 'shellescape(v:val)'), ' ')
  let command = 'rg --column --line-number --no-heading --color=always --smart-case -- ' . shellescape(a:query) . ' ' . files
  
  call fzf#run(fzf#wrap({
  \ 'source': command,
  \ 'sink*': function('s:rg_handler_with_actions'),
  \ 'options': '--multi --ansi --delimiter : --nth 3.. '.
  \            '--preview "bat --style=numbers --color=always --highlight-line {2} {1}" '.
  \            '--preview-window "+{2}/2" --expect=' . join(keys(actions), ','),
  \ }, a:fullscreen))
endfunction

command! -nargs=* -bang RGBuffers call RipgrepBuffers(<q-args>, <bang>0)
nnoremap <leader>? :RGBuffers<CR>
vnoremap <leader>? :call VisualCmdWithQuotedSelection('RGBuffers')<CR>
