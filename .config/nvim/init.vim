call plug#begin('~/.vim/plugged')

Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-conflicted'
Plug 'https://github.com/alok/notational-fzf-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'sheerun/vim-polyglot'
Plug 'ryanoasis/vim-devicons'
Plug 'sainnhe/edge'
Plug 'itchyny/calendar.vim'
Plug 'ap/vim-css-color'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
Plug 'kablamo/vim-git-log'
Plug 'gregsexton/gitv'
Plug 'mattn/emmet-vim'
Plug 'jparise/vim-graphql'

call plug#end()

" Enable termguicolors
set termguicolors

" Themes
set background=dark
colorscheme edge

" Enable syntax
syntax on

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Enable foldable
" zo opens a fold at the cursor.
" zO opens all folds at the cursor.
" zc closes a fold at the cursor.
" zm increases the foldlevel by one.
" zM closes all open folds.
" zr decreases the foldlevel by one.
" zR decreases the foldlevel to zero -- all folds will be open.
set foldmethod=syntax

" Commons Themes Setup
set laststatus=0
set textwidth=100
set noruler
set nohlsearch
set number
set spell
set formatoptions+=o
set autoindent
set cindent
set tabstop=2
set shiftwidth=2
set expandtab
set nojoinspaces
set clipboard=unnamed
set smarttab
set relativenumber

" Mapping leader
let mapleader = ','
" Setup NV paths
let g:nv_search_paths = ['~/notes']
" Use `gl` and `gu` rather than the default conflicted diffget mappings
let g:diffget_local_map = 'gl'
let g:diffget_upstream_map = 'gu'
" Empty value to disable preview window altogether
let g:fzf_preview_window = ''
" [[B]Commits] Customize the options used by 'git log':
" let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" https://github.com/ms-jpq/chadtree
nnoremap <leader>v <cmd>CHADopen<cr>

inoremap jk <ESC>

" Mapping FZF
nnoremap <C-f> :Files<CR>
nnoremap <C-a> :Ag<CR>

nnoremap <silent> <c-s> :NV<CR>

" Mapping COC react-code-refactor
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" New file with directory
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" Prettier
let g:prettier#autoformat = 0
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Enable showing google calendar
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

" Golang auto organizeImport
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" Command to open Markmap with shortcat 
command! -range=% Markmap CocCommand markmap.create <line1> <line2>

