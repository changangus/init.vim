set scrolloff=8
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set splitbelow
set noequalalways

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'Pocco81/auto-save.nvim'
call plug#end()

set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>s :20 split \| :terminal<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>> :vsplit \| :terminal<CR>

" Terminal Remaps
tnoremap xx <C-\><C-n>
" NERDTree Remaps
nnoremap <leader>f :NERDTreeToggle<CR>
" FZR Remaps
nnoremap <S-f> :Files<CR>
nnoremap <C-p> :GFiles<CR>
" Unmap <ESC> binding for fzf buffer if binding exists or suppress unmap error
au FileType fzf silent! tunmap <Esc>
" QuickFixList Remaps
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprev<CR>
" GitGutter Remaps
nnoremap <leader>gd :GitGutterDiffOrig<CR>
" Window controls Remaps
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
