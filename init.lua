-- Local:
local cmd = vim.cmd
local g = vim.g
local opt = vim.opt
local fn = vim.fn
local execute = vim.api.nvim_command

-- Global Variables:
g.mapleader = " "
g.markdown_folding = 1
g.airline_theme = 'angr'
g.user_emmet_leader_key = ','
g.gitblame_enabled = 0
g.NERDTreeShowHidden = 1

-- Options:
opt.scrolloff = 8
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 2
opt.cmdheight = 1
opt.expandtab = true
opt.smartindent = true
opt.splitbelow = true
opt.equalalways = false
opt.filetype = "on"
opt.filetype = "indent"
opt.filetype = "plugin"
opt.syntax = "on"
opt.mouse = "a"
opt.winheight = 20
opt.undofile = true

-- Commands:
cmd('colorscheme codedark')
cmd('highlight Normal guibg=NONE ctermbg=NONE')
cmd('highlight SignColumn guibg=NONE ctermbg=NONE')
cmd('highlight LineNr guibg=NONE ctermbg=NONE')
cmd('highlight CursorLineNr guibg=NONE ctermbg=NONE')
cmd('highlight StatusLine gui=NONE cterm=NONE')
cmd('highlight StatusLineNC gui=NONE cterm=NONE')
cmd('highlight EndOfBuffer guibg=NONE ctermbg=NONE')
cmd('highlight Directory gui=NONE cterm=NONE')
cmd('highlight WinSeparator gui=NONE cterm=NONE')

-- ensure that packer is installed
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')
local packer = require 'packer'
local util = require 'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

-- Plugins:
packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Coc
  use { 'neoclide/coc.nvim', branch = 'release' }
  use 'lervag/vimtex'
  -- Telescope.nvim
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  -- Nerdtree
  use 'preservim/nerdtree'
  -- autoclose
  use 'jiangmiao/auto-pairs'
  -- Themes:
  use 'tomasiser/vim-code-dark'

  -- SYNTAX HIGHLIGHTING:

  -- JavaScript/Typescript/JSX/TSX:
  use 'pangloss/vim-javascript'
  use 'ianks/vim-tsx'
  use 'HerringtonDarkholme/yats.vim'
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
  -- LuaLine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- Git Blame
  use 'f-person/git-blame.nvim'
  -- surround text
  use {
    "ur4ltz/surround.nvim",
    config = function()
      require "surround".setup { mappings_style = "sandwich" }
    end
  }
  -- Prettier
  use('jose-elias-alvarez/null-ls.nvim')
  use('MunifTanjim/prettier.nvim')
  -- nvim dap
  use 'mfussenegger/nvim-dap'
  -- git signs
  use {
    'lewis6991/gitsigns.nvim',
    -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
  }
end)

-- Coc Command remaps
vim.keymap.set('i', '<cr>', 'coc#pum#visible() ? coc#pum#confirm() : "<cr>"', { expr = true, noremap = true })
vim.keymap.set('n', '<leader>fl', ':CocCommand prettier.formatFile<cr>', { noremap = true })

-- Vim Command Remaps:
vim.keymap.set('n', '<leader><CR>', ':luafile ~/.config/nvim/init.lua<CR>', { noremap = true })
vim.keymap.set('n', '<leader>s', ':wq<CR>', { noremap = true })
vim.keymap.set('n', '<leader>e', ':q<CR>', { noremap = true })
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true })
vim.keymap.set('n', '<c-h>', '<c-w>h', { noremap = true })
vim.keymap.set('n', '<c-j>', '<c-w>j', { noremap = true })
vim.keymap.set('n', '<c-k>', '<c-w>k', { noremap = true })
vim.keymap.set('n', '<c-l>', '<c-w>l', { noremap = true })
vim.keymap.set('n', '<leader>nh', ':noh<CR>', { noremap = true })
vim.keymap.set('x', '<leader>y', '"+y', { noremap = true })
vim.keymap.set('n', '<leader>rp', ':let @+=expand("%:")<CR>', { noremap = true })

-- Harpoon
vim.keymap.set('n', '<leader>lv', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true })
vim.keymap.set('n', '<leader>la', ':lua require("harpoon.mark").add_file()<CR>', { noremap = true })

-- NERDTree
vim.keymap.set('n', '<leader>ft', ':NERDTreeToggle<CR>', { noremap = true })

-- GitBlame
vim.keymap.set('n', '<leader>gb', ':<C-u>call gitblame#echo()<CR>', { noremap = true })

-- Telescope.nvim
require("telescope").setup({
  defaults = {
    layout_config = {
      horizontal = {
        preview_cutoff = 0,
      },
    },
  },
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<S-f>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- GitBlame
vim.keymap.set('n', '<leader>gb', ':GitBlameToggle<CR>', { noremap = true });
vim.keymap.set('n', '<leader>gO', ':GitBlameOpenCommitURL<CR>', { noremap = true });
vim.keymap.set('n', '<leader>gS', ':GitBlameCopySHA<CR>', { noremap = true });

-- LuaLine
require('lualine').setup {
  options = { theme = 'ayu_mirage' },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 'filename' },
  }
}

-- surround
require "surround".setup {
  context_offset = 100,
  load_autogroups = false,
  mappings_style = "sandwich",
  map_insert_mode = true,
  quotes = { "'", '"' },
  brackets = { "(", '{', '[' },
  space_on_closing_char = false,
  pairs = {
    nestable = { b = { "(", ")" }, s = { "[", "]" }, B = { "{", "}" }, a = { "<", ">" } },
    linear = { q = { "'", "'" }, t = { "`", "`" }, d = { '"', '"' } }
  },
  prefix = "S",
}

-- git signs
require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line { full = true } end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

-- Harpoon
require("harpoon").setup({
  menu = {
    width = 90,
  }
})
