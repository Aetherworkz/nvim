local which_key = require("wf.builtin.which_key")
local register = require("wf.builtin.register")
local bookmark = require("wf.builtin.bookmark")
local buffer = require("wf.builtin.buffer")
local mark = require("wf.builtin.mark")

-- =====================
-- Keymaps
-- =====================
-- Splits
vim.keymap.set("n", "<Leader>vv", function() vim.cmd("vsplit") end, { noremap = true, silent = true, desc = "Vertical Split" })
vim.keymap.set("n", "<Leader>vh", function() vim.cmd("split") end, { noremap = true, silent = true, desc = "Horizontal Split" })

-- Split Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Finding
vim.keymap.set("n", "<Leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true, desc = "Find Files" })
vim.keymap.set("n", "<Leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true, desc = "Live Grep" })
vim.keymap.set("n", "<Leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true, desc = "Buffers" })
vim.keymap.set("n", "<Leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true, silent = true, desc = "Help Tags" })

-- LSP Stuff
vim.keymap.set("n", "<Leader>ld", function() vim.lsp.buf.definition() end, { noremap = true, silent = true, desc = "Definition" })
vim.keymap.set("n", "<Leader>lr", function() vim.lsp.buf.references() end, { noremap = true, silent = true, desc = "References" })
vim.keymap.set("n", "<Leader>la", function() vim.lsp.buf.code_action() end, { noremap = true, silent = true, desc = "Code Action" })

-- defaults
vim.keymap.set("n", "<Space>wr", register(), { noremap = true, silent = true, desc = "[wf.nvim] register" })
vim.keymap.set("n", "<Space>wbo", bookmark({ nvim = "~/.config/nvim", zsh = "~/.zshrc" }), { noremap = true, silent = true, desc = "[wf.nvim] bookmark" })
vim.keymap.set("n", "<Space>wbu", buffer(), { noremap = true, silent = true, desc = "[wf.nvim] buffer" })
vim.keymap.set("n", "'", mark(), { nowait = true, noremap = true, silent = true, desc = "[wf.nvim] mark" })

-- ===================================================
-- <Leader> popup with small timeout to reduce lag
-- ===================================================
local function timeout(ms, callback)
local uv = vim.loop
local timer = uv.new_timer()
local _callback = vim.schedule_wrap(function()
uv.timer_stop(timer)
uv.close(timer)
callback()
end)
uv.timer_start(timer, ms, 0, _callback)
end

timeout(50, function()
vim.keymap.set(
    "n",
    "<Leader>",
    which_key({ text_insert_in_advance = "<Leader>" }),
               { noremap = true, silent = true, desc = "[wf.nvim] which-key" }
)
end)
