" This is my personal Nvim configuration supporting Mac, Linux and Windows, with various plugins configured.
" This configuration evolves as I learn more about Nvim and become more proficient in using Nvim.
" Since it is very long (more than 1000 lines!), you should read it carefully and take only the settings that suit you.
" I would not recommend cloning this repo and replace your own config. Good configurations are personal,
" built over time with a lot of polish.
"
" Author: Jie-dong Hao
" Email: jdhao@hotmail.com
" Blog: https://jdhao.github.io/

let s:core_conf_files = [
      \ 'globals.vim',
      \ 'options.vim',
      \ 'autocommands.vim',
      \ 'mappings.vim',
      \ 'neovide.vim',
      \ 'plugins.vim',
      \ 'themes.vim'
      \ ]

for s:fname in s:core_conf_files
  execute printf('source %s/core/%s', stdpath('config'), s:fname)
endfor
" system clipboard
nmap <c-c> "+y
vmap <c-c> "+y
nmap <c-v> "+p
inoremap <c-v> <c-r>+
cnoremap <c-v> <c-r>+
" use <c-r> to insert original character without triggering things like auto-pairs
inoremap <c-r> <c-v>
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa
augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:ver100
augroup END
set number
set relativenumber!
"set guicursor=a:block
let g:neovide_cursor_antialiasing=v:false

