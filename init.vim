set scrolloff=8
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set splitbelow
set noequalalways
filetype on
filetype indent on
filetype plugin on

call plug#begin('~/.vim/plugged')
" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" colorscheme
Plug 'ayu-theme/ayu-vim'
Plug 'larsbs/vimterial_dark'
" nerdtree
Plug 'preservim/nerdtree'
" git stuff
Plug 'airblade/vim-gitgutter'
" autosave
Plug 'pocco81/auto-save.nvim'
" syntax higlighting
" javascript
Plug 'pangloss/vim-javascript'
" syntax highlight for .tsx
Plug 'ianks/vim-tsx', { 'for': 'typescript.tsx' }
" syntax highlight for .ts
Plug 'herringtondarkholme/yats.vim', { 'for': 'typescript' }
" syntax hightlight for .jsx
Plug 'mxw/vim-jsx'
" 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" startup screen
Plug 'mhinz/vim-startify'
call plug#end()

set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme
syntax on
colorscheme ayu

let mapleader = " "
nnoremap <leader>pv :Vex<cr>
nnoremap <leader><cr> :so ~/.config/nvim/init.vim<cr>
nnoremap <nowait> <leader>e :q<cr>
nnoremap <leader>s :15 split \| :terminal<cr>
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>> :vsplit \| :terminal<cr>

" terminal remaps
tnoremap xx <c-\><c-n>
" nerdtree remaps
nnoremap <leader>ft :NERDtreetoggle<cr>
" fzr remaps
nnoremap <s-f> :Files<cr>
nnoremap <c-p> :Gfiles<cr>
" unmap <esc> binding for fzf buffer if binding exists or suppress unmap error
au filetype fzf silent! tunmap <esc>
" quickfixlist remaps
nnoremap <leader>cn :cnext<cr>
nnoremap <leader>cp :cprev<cr>
" gitgutter remaps
nnoremap <leader>gd :GitGutterDiffOrig<cr>
" window controls remaps
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k

source $HOME/.config/nvim/plug-config/coc.vim
