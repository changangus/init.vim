set scrolloff=8
set number
set relativenumber
set tabstop=2 softtabstop=2
set shiftwidth=2
set cmdheight=1
set expandtab
set smartindent
set splitbelow
set noequalalways
filetype on
filetype indent on
filetype plugin on
syntax on

" enable folding
let g:markdown_folding = 1

call plug#begin('~/.vim/plugged')
" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" colorscheme
Plug 'tomasiser/vim-code-dark'
" nerdtree
Plug 'preservim/nerdtree'
" git stuff
Plug 'airblade/vim-gitgutter'
" autosave
Plug 'Pocco81/auto-save.nvim'
" syntax higlighting
" javascript
Plug 'pangloss/vim-javascript'
" syntax highlight for .tsx
Plug 'ianks/vim-tsx', { 'for': 'typescript.tsx' }
" syntax highlight for .ts
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
" syntax hightlight for .jsx
Plug 'mxw/vim-jsx'
" syntax highlight for .sol
Plug 'tomlion/vim-solidity'
" syntax highlight for .md
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
" Intellisense for vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" startup screen
Plug 'mhinz/vim-startify'
" Autoclose pairs
Plug 'jiangmiao/auto-pairs'
" Emmet HTML
Plug 'mattn/emmet-vim'
" Code Snippets
" React
Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'
" Notes
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
" RipGrep 
Plug 'jremmen/vim-ripgrep'
" Prettier
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
" ESLint
Plug 'eslint/eslint'
" Github CoPilot
Plug 'github/copilot.vim'
call plug#end()

set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme
colorscheme codedark
hi Normal guibg=NONE ctermbg=NONE
highlight clear LineNr
highlight clear SignColumn 
highlight clear StatusLine
hi EndOfBuffer guibg=NONE ctermbg=NONE 

let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <nowait> <leader>e :q<CR>
nnoremap <leader>s :15 split \| :terminal<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>> :vsplit \| :terminal<CR>
" remove highlights from search 
nnoremap <leader>nh :noh<CR>
" terminal remaps
tnoremap xx <c-\><c-n>
" nerdtree remaps
nnoremap <leader>ft :NERDTreeToggle<CR>
" fzr remaps
nnoremap <s-f> :Files<CR>
nnoremap <c-p> :Gfiles<CR>
" unmap <esc> binding for fzf buffer if binding exists or suppress unmap error
au filetype fzf silent! tunmap <esc>
" quickfixlist remaps
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprev<CR>
" gitgutter remaps
nnoremap <leader>gd :GitGutterDiffOrig<CR>
" Emmet remap 
imap <F8> <c-y>,<CR> 
" window controls remaps
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
" Notes remaps 
nnoremap <leader>nn :Note<CR>
" Copy relative path to clipboard
nnoremap <leader>rp :let @+ = expand('%:')<CR>

source $HOME/.config/nvim/plug-config/coc.vim
