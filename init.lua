-- =====================
-- Core / basic options
-- =====================
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.clipboard      = "unnamedplus"
vim.opt.termguicolors  = true
vim.opt.signcolumn     = "yes"
vim.opt.updatetime     = 250
vim.opt.completeopt    = { "menu", "menuone", "noselect" }

vim.o.timeout = true
vim.o.timeoutlen = 50  -- 50ms instead of 1000ms

vim.opt.tabstop     = 4
vim.opt.shiftwidth  = 4
vim.opt.expandtab   = true
vim.opt.smartindent = true

-- Spacebar leader.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better default experience
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase  = true
vim.opt.hlsearch   = false     -- don't keep search highlight
vim.opt.incsearch  = true

-- Keep some context when scrolling
vim.opt.scrolloff = 8

require('keymaps')

-- =====================
-- Load plugins (manual paths)
-- =====================

-- You must clone these repositories yourself (one time setup):

-- git clone https://github.com/nvim-lua/plenary.nvim       ~/.local/share/nvim/site/pack/manual/start/plenary.nvim
-- git clone https://github.com/neovim/nvim-lspconfig      ~/.local/share/nvim/site/pack/manual/start/nvim-lspconfig
-- git clone https://github.com/folke/which-key.nvim ~/.local/share/nvim/site/pack/manual/start/which-key.nvim

-- =====================
-- Telescope w/ fzf
-- =====================
-- git clone https://github.com/nvim-telescope/telescope.nvim ~/.local/share/nvim/site/pack/manual/start/telescope.nvim
-- git clone https://github.com/nvim-telescope/telescope-fzf-native.nvim ~/.local/share/nvim/site/pack/manual/start/telescope-fzf-native.nvim
-- cd ~/.local/share/nvim/site/pack/manual/start/telescope-fzf-native.nvim && make

-- =====================
-- Snacks
-- =====================
-- git clone https://github.com/folke/snacks.nvim ~/.local/share/nvim/site/pack/manual/start/snacks.nvim


-- =====================
-- Icons n' such
-- =====================
-- git clone https://github.com/nvim-tree/nvim-web-devicons ~/.local/share/nvim/site/pack/manual/start/nvim-web-devicons

require("plugins.telescope")
require("plugins.lsp")
require("plugins.snacks")

-- =====================
-- wf.nvim setup
-- =====================
local ok, wf = pcall(require, "wf")
if ok then
    wf.setup({ theme = "default" })

    -- Require bindings **after** plugin is loaded
    require("plugins.wf")
    else
        vim.notify("wf.nvim failed to load!", vim.log.levels.ERROR)
        end


