set number
set relativenumber
set autoindent
set shiftwidth=4
set scrolloff=8
set smarttab
set mouse=a
set termguicolors

"change default keybinding
imap jj <Esc>
let mapleader = " "
nnoremap <Leader>o o<esc>
nnoremap <Leader>O O<esc>

"plugins
call plug#begin()
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'jiangmiao/auto-pairs'
call plug#end()

function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  "Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

"start gogo when vim starts
autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

"colorsscheme
colorscheme tokyonight
