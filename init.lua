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
  -- LSP
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer'
  }
  -- lsputils
  use 'RishabhRD/popfix'
  use 'RishabhRD/nvim-lsputils'
  -- Telescope.nvim
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  -- Nerdtree
  use 'preservim/nerdtree'
  -- Git Gutter
  use 'airblade/vim-gitgutter'
  -- autoclose
  use 'm4xshen/autoclose.nvim'
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
  -- autocomplete for lsp
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'onsails/lspkind.nvim'
  use({ "L3MON4D3/LuaSnip" })
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
end)

-- LSP Config:
require("nvim-lsp-installer").setup {}
local status, nvim_lsp = pcall(require, 'lspconfig')

if (not status) then return end

local on_attach = function(client, bufnr)
  -- formatting
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd('BufwritePre', {
      group = vim.api.nvim_create_augroup('Format', { clear = true });
      buffer = bufnr,
      callback = function() vim.lsp.buf.formatting_seq_sync() end
    })
  end

  -- Mappings.
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', '<leader>K', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Lua
nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
}

-- Typescript
-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities,
}

-- Python
nvim_lsp.pylsp.setup {
  on_attach = on_attach,
  filetypes = { "python" },
  cmd = { "pylsp" },
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
}

-- setup nvim-cmp
local status, cmp = pcall(require, 'cmp')
if (not status) then return end
local lspkind = require('lspkind')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'vsnip' },
  },
  formatting = {
    format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
  }
})

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]

-- lsputils chunk from repo README
if vim.fn.has('nvim-0.5.1') == 1 then
  vim.lsp.handlers['textDocument/codeAction'] = require 'lsputil.codeAction'.code_action_handler
  vim.lsp.handlers['textDocument/references'] = require 'lsputil.locations'.references_handler
  vim.lsp.handlers['textDocument/definition'] = require 'lsputil.locations'.definition_handler
  vim.lsp.handlers['textDocument/declaration'] = require 'lsputil.locations'.declaration_handler
  vim.lsp.handlers['textDocument/typeDefinition'] = require 'lsputil.locations'.typeDefinition_handler
  vim.lsp.handlers['textDocument/implementation'] = require 'lsputil.locations'.implementation_handler
  vim.lsp.handlers['textDocument/documentSymbol'] = require 'lsputil.symbols'.document_handler
  vim.lsp.handlers['workspace/symbol'] = require 'lsputil.symbols'.workspace_handler
else
  local bufnr = vim.api.nvim_buf_get_number(0)

  vim.lsp.handlers['textDocument/codeAction'] = function(_, _, actions)
    require('lsputil.codeAction').code_action_handler(nil, actions, nil, nil, nil)
  end

  vim.lsp.handlers['textDocument/references'] = function(_, _, result)
    require('lsputil.locations').references_handler(nil, result, { bufnr = bufnr }, nil)
  end

  vim.lsp.handlers['textDocument/definition'] = function(_, method, result)
    require('lsputil.locations').definition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
  end

  vim.lsp.handlers['textDocument/declaration'] = function(_, method, result)
    require('lsputil.locations').declaration_handler(nil, result, { bufnr = bufnr, method = method }, nil)
  end

  vim.lsp.handlers['textDocument/typeDefinition'] = function(_, method, result)
    require('lsputil.locations').typeDefinition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
  end

  vim.lsp.handlers['textDocument/implementation'] = function(_, method, result)
    require('lsputil.locations').implementation_handler(nil, result, { bufnr = bufnr, method = method }, nil)
  end

  vim.lsp.handlers['textDocument/documentSymbol'] = function(_, _, result, _, bufn)
    require('lsputil.symbols').document_handler(nil, result, { bufnr = bufn }, nil)
  end

  vim.lsp.handlers['textDocument/symbol'] = function(_, _, result, _, bufn)
    require('lsputil.symbols').workspace_handler(nil, result, { bufnr = bufn }, nil)
  end
end

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

-- null-ls
local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>fl", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})

-- Prettier
local prettier = require("prettier")

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.22+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
  ["null-ls"] = {
    condition = function()
      return prettier.config_exists({
        -- if `false`, skips checking `package.json` for `"prettier"` key
        check_package_json = true,
      })
    end,
    runtime_condition = function(params)
      -- return false to skip running prettier
      return true
    end,
    timeout = 5000,
  },
})

