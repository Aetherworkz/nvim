-- ~/.config/nvim/lua/keymaps.lua

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Normal mode
map('n', '<A-j>', ':m .+1<CR>==', opts)
map('n', '<A-k>', ':m .-2<CR>==', opts)

-- Visual mode
map('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
map('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)

-- Insert mode
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', opts)
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', opts)

-- New file in current file's directory
vim.keymap.set("n", "<leader>fn", function()
  local dir = vim.fn.expand("%:p:h") -- current file directory
  local name = vim.fn.input("New file name: ") -- prompt
  if name ~= "" then
    vim.cmd("edit " .. dir .. "/" .. name)
  end
end, { desc = "New file in current directory" })

