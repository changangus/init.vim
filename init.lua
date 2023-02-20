-- Local:
local cmd = vim.cmd
local g = vim.g
local opt = vim.opt
local fn = vim.fn
local execute = vim.api.nvim_command

-- Global Variables:
g.mapleader = " "
g.airline_theme = 'angr'
g.user_emmet_leader_key = ','
g.gitblame_enabled = 0
g.NERDTreeShowHidden = 1
g.markdown_fenced_languages = {'javascript=javascriptreact', 'typescript=typescript', 'tsx=typescriptreact', 'ts=typescriptreact'  }

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
opt.cursorline = true
opt.termguicolors = true

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
cmd('highlight CursorLine guibg=#403257')

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
  use 'nvim-lua/plenary.nvim' -- required by multiple plugins
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Coc
  use { 'neoclide/coc.nvim', branch = 'release' }
  use 'lervag/vimtex'
  -- Telescope.nvim
  use 'fannheyward/telescope-coc.nvim'
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
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- JavaScript/Typescript/JSX/TSX:
  use 'pangloss/vim-javascript'
  use 'ianks/vim-tsx'
  use 'HerringtonDarkholme/yats.vim'
  use 'mxw/vim-jsx'
  -- syntax highlight for .sol
  use 'tomlion/vim-solidity'
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
  -- autosave
  use({
	"Pocco81/auto-save.nvim",
  })
  use {
    'numToStr/Comment.nvim',
  }
  -- diffview
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
end)

-- Coc Command remaps
vim.keymap.set('n', '<leader>ff', ':CocCommand prettier.formatFile<cr>', { noremap = true })
vim.keymap.set('n', '<leader>fl', ':CocCommand eslint.executeAutofix<cr>', { noremap = true })
-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set
-- Auto complete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: There's always complete item selected by default, you may want to enable
-- no select by `"suggest.noselect": true` in your configuration file.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion.
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation.
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})


-- Use H to show documentation in preview window.
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "H", '<CMD>lua _G.show_docs()<CR>', {silent = true})


-- Highlight the symbol and its references when holding the cursor.
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming.
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


-- Formatting selected code.
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


-- Setup formatexpr specified filetype(s).
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder.
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})


-- Applying code actions to the selected code block.
-- Example: `<leader>aap` for current paragraph
local opts = {silent = true, nowait = true}
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply code actions affect whole buffer.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action to fix diagnostic on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens action on the current line.
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


-- Remap <C-f> and <C-b> for scroll float windows/popups.
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})


-- Add `:Format` command to format current buffer.
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer.
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer.
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics.
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Show commands.
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document.
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols.
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item.
keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item.
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list.
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
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
vim.keymap.set('n', '<leader>rp', ':let @+ = expand("%")<CR>', { noremap = true })
-- Move lines up and down
vim.keymap.set('n', '<S-j>', ':.move +1<CR>')
vim.keymap.set('n', '<S-k>', ':.move -2<CR>')
vim.keymap.set('v', '<S-j>', ":'<,'>move '>+1 | normal! gv<CR>")
vim.keymap.set('v', '<S-k>', ":'<,'>move '<-2 | normal! gv<CR>")
-- Split screen 50% vertically 
vim.keymap.set('n', '<leader>v', ':vsplit<CR>:resize 50<CR>', { noremap = true })

-- Harpoon
require("harpoon").setup({
  menu = {
    width = 110,
    height = 20,
  }
})
vim.keymap.set('n', '<leader>lv', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true })
vim.keymap.set('n', '<leader>la', ':lua require("harpoon.mark").add_file()<CR>', { noremap = true })
vim.keymap.set('n', '<leader>ht', ':Telescope harpoon marks<CR>', { noremap = true })

-- NERDTree
vim.keymap.set('n', '<leader>ft', ':NERDTreeToggle<CR>', { noremap = true })
vim.keymap.set('n', '<leader>nf', ':NERDTreeFind<CR>', { noremap = true })

-- Telescope.nvim
require("telescope").setup({
  defaults = {
    initial_mode = "normal",
    path_display = { "truncate" },
    layout_config = {
      preview_cutoff = 0,
      preview_width = 0.6,
    },
  },
  extensions = {
    coc = {
      theme = "ivy",
    },
    harpoon = {
      theme = "ivy",
    },
  }
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fe', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>a', ':Telescope coc diagnostics<CR>', {})
vim.keymap.set('n', 'gd', ':Telescope coc definitions<CR>', {})
vim.keymap.set('n', 'gr', ':Telescope coc references<CR>', {})

-- GitBlame
vim.keymap.set('n', '<leader>gb', ':GitBlameToggle<CR>', { noremap = true });
vim.keymap.set('n', '<leader>gO', ':GitBlameOpenCommitURL<CR>', { noremap = true });
vim.keymap.set('n', '<leader>gS', ':GitBlameCopySHA<CR>', { noremap = true });

-- LuaLine
require('lualine').setup {
  options = { theme = 'ayu_mirage' },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename' },
    lualine_c = { 'branch' },
    lualine_y = {},
    lualine_z = {},
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
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
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

-- Comment.nvim 
require('Comment').setup({
  toggler = {
    line = 'gc',
    block = 'gb',
  },
})

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  -- ensure_installed = { "lua", "vim", "help", "typescript", "typescriptreact", "javascript", "javascriptreact", "json", "html", "css", "scss", "bash", "python", "go", "rust", "yaml", "toml", "graphql", "regex" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  -- sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = {},

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- Pocco81/AutoSave
vim.keymap.set('n', '<leader>as', ':ASToggle<CR>', { noremap = false });
