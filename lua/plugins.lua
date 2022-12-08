return require('packer').startup(function()
  -- Packer can manage itself
    use 'wbthomason/packer.nvim'
  -- LSP
    use 'neovim/nvim-lspconfig'
  -- FZF 
    use {'junegunn/fzf', run = ':call fzf#install()'}
    use 'junegunn/fzf.vim'
  -- Nerdtree
    use 'preservim/nerdtree'
  -- Git Gutter
    use 'airblade/vim-gitgutter'
  -- Auto Save
    use 'Pocco81/auto-save.nvim'

  -- SYNTAX HIGHLIGHTING:
  
    -- JavaScript/Typescript/JSX/TSX:
    use 'pangloss/vim-javascript'
    use { 'ianks/vim-tsx', for = 'typescriptreact' }
    use { 'HerringtonDarkholme/yats.vim', 'for': 'typescript' }
    use 'mxw/vim-jsx'
    -- syntax highlight for .sol
    use 'tomlion/vim-solidity'
    -- syntax highlight for .md
    use 'godlygeek/tabular'
    use 'preservim/vim-markdown'
    -- prisma sytnax higlighting 
    use 'pantharshit00/vim-prisma'

  -- Startup Screen
    use 'mhinz/vim-startify'
  -- Autoclose pairs
    use 'jiangmiao/auto-pairs'
  -- Emmet HTML
    use 'mattn/emmet-vim'
  -- Code Snippets
  -- React
    use 'SirVer/ultisnips'
    use 'mlaursen/vim-react-snippets'
  -- Notes
    use 'xolox/vim-notes'
    use 'xolox/vim-misc'
  -- ESLint
    use 'eslint/eslint'
  -- Github CoPilot
    use 'github/copilot.vim'
  -- Icons
    use 'ryanoasis/vim-devicons'
  -- Harpoon 
    use 'nvim-lua/plenary.nvim' -- don't forget to add this one if you don't have it yet!
    use 'ThePrimeagen/harpoon'
  -- Airline
    use 'airblade/vim-rooter'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
  -- Git Blame
    use 'zivyangll/git-blame.vim'
  -- vimspector debugging 
    use 'puremourning/vimspector'
end)
