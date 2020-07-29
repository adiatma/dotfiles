call plug#begin('~/.vim/plugged')

Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'arcticicestudio/nord-vim'
Plug 'preservim/nerdtree'
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-conflicted'
Plug 'https://github.com/alok/notational-fzf-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'tpope/vim-dispatch'
Plug 'sheerun/vim-polyglot'
Plug 'sainnhe/edge'
Plug 'itchyny/lightline.vim'

call plug#end()

"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" If FZF installed using Homebrew
set rtp+=/usr/local/opt/fzf

" Enable mousemodel to using in vim
set mousemodel=extend

" Themes
colorscheme edge
set background=dark

" Enable syntax
syntax enable

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

" Mapping leader
let mapleader = ','

" Mapping FZF
nnoremap <C-f> :Files<CR>
nnoremap <C-r> :Rg<CR>
nnoremap <C-a> :Ag<CR>

" Mapping NERDTree
nnoremap <C-t> :NERDTree<CR>

" Setup NV paths
let g:nv_search_paths = ['~/wiki']

" Mapping NV
nnoremap <silent> <c-s> :NV<CR>

" Mapping vim conflicted
nnoremap <leader>gnc :GitNextConflict<CR>

" Use `gl` and `gu` rather than the default conflicted diffget mappings
let g:diffget_local_map = 'gl'
let g:diffget_upstream_map = 'gu'

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

" Mapping COC react-code-refactor
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Golang auto organizeImport
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
