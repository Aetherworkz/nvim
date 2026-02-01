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

vim.o.timeout       = true
vim.o.timeoutlen    = 50

vim.opt.tabstop     = 4
vim.opt.shiftwidth  = 4
vim.opt.expandtab   = true
vim.opt.smartindent = true

vim.g.mapleader      = " "
vim.g.maplocalleader = " "

vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase  = true
vim.opt.hlsearch   = false
vim.opt.incsearch  = true
vim.opt.scrolloff  = 8

require("keymaps")

-- =====================
-- Autosaving Solution
-- =====================
vim.o.autowriteall = true
local auto_save_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

-- the actual autosave cmd
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
    group = auto_save_group,
    callback = function()
        vim.cmd("silent! update")
    end,
})

-- =====================
-- Bootstrap lazy.nvim
-- =====================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- this diagnostic gets the lsp to shut up
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
    vim.notify("lazy.nvim not found!", vim.log.levels.ERROR)
    return
end
vim.opt.rtp:prepend(lazypath)

-- =====================
-- Plugins
-- =====================
require("lazy").setup({
    { import = "plugins" },
},
{
    checker = { enabled = false }, -- no auto internet
    change_detection = { notify = false },
})


