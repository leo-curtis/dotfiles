syntax on
filetype plugin indent on
set mouse=a
set clipboard=unnamed,unnamedplus
try
    colorscheme retrobox
catch
    colorscheme desert
endtry
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
set smartindent
set number
set relativenumber
set laststatus=2
set showmode
set nowrap
set ruler
set scrolloff=8
set wildmenu
set hlsearch
set incsearch
set ignorecase
set smartcase
set hidden
set noswapfile
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1

function! s:DirStart()
    if argc() == 1 && isdirectory(expand(argv(0)))
        rightbelow vnew
        wincmd h
        vertical resize 40
    endif
endfunction

augroup dir_start
    autocmd!
    autocmd VimEnter * ++nested call s:DirStart()
augroup END

let mapleader = " "
nnoremap <silent> <leader>/ :nohlsearch<CR>
nnoremap <silent> <leader>bn :bnext<CR>
nnoremap <silent> <leader>bp :bprev<CR>
nnoremap <silent> <leader>bb <C-^>
nnoremap <silent> <leader>bd :bdelete<CR>
nnoremap <leader>bl :ls<CR>:b<Space>

function! ToggleExplorer()
    let l:explorer_bufs = filter(range(1, bufnr('$')), 'getbufvar(v:val, "&filetype") == "netrw"')
    let l:explorer_buf = !empty(l:explorer_bufs) ? l:explorer_bufs[0] : -1
    let l:explorer_win = (l:explorer_buf != -1) ? bufwinnr(l:explorer_buf) : -1
    if l:explorer_win != -1
        execute l:explorer_win . 'close'
    else
        let g:netrw_altv = 0
        leftabove Vex
        let g:netrw_altv = 1
        vertical resize 40
    endif
endfunction

nnoremap <silent> <leader>e :call ToggleExplorer()<CR>
nnoremap <silent> <leader>w <C-w>w
nnoremap <silent> <leader><Left> :vertical resize -10<CR>
nnoremap <silent> <leader><Right> :vertical resize +10<CR>
nnoremap <silent> <leader><Up> :resize +10<CR>
nnoremap <silent> <leader><Down> :resize -10<CR>

function! ToggleTerminal()
    let l:term_bufs = filter(range(1, bufnr('$')), 'getbufvar(v:val, "&buftype") == "terminal"')
    let l:term_buf = !empty(l:term_bufs) ? l:term_bufs[0] : -1
    let l:term_win = (l:term_buf != -1) ? bufwinnr(l:term_buf) : -1
    if l:term_win != -1
        execute l:term_win . 'hide'
    elseif l:term_buf != -1
        execute 'botright sbuf ' . l:term_buf
        resize 10
        startinsert
    else
        botright terminal
        resize 10
    endif
endfunction

nnoremap <leader>t :call ToggleTerminal()<CR>
tnoremap <leader>w <C-w>k
tnoremap <leader>t <C-w>N:call ToggleTerminal()<CR>

if exists('##TextYankPost')
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! call s:hl_yank()
  augroup END

  function! s:hl_yank()
    if v:event.operator == 'y'
      let l:m = matchadd('Visual', '\%''\[\_.*\%'']')
      call timer_start(300, {-> matchdelete(l:m)})
    endif
  endfunction
endif
