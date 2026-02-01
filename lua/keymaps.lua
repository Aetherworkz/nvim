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
    local dir = vim.fn.expand("%:p:h")
    local name = vim.fn.input("New file name: ")
    if name ~= "" then
        vim.cmd("edit " .. dir .. "/" .. name)
    end
end, { desc = "New file in current directory" })

-- New folder in current file's directory
vim.keymap.set("n", "<leader>Fn", function()
    local dir = vim.fn.expand("%:p:h")
    local name = vim.fn.input("New folder name: ")

    if name ~= "" then
        local path = dir .. "/" .. name
        vim.fn.mkdir(path, "p")
        vim.notify("Created folder: " .. path)
    end
end, { desc = "New folder in current file directory" })

vim.keymap.set("n", "<leader>cw", function()
    local view = vim.fn.winsaveview()

    -- remove trailing whitespace
    vim.cmd([[%s/\s\+$//e]])

    -- collapse multiple blank lines (2+)
    vim.cmd([[%s/\n\{2,}/\r\r/ge]])

    -- collapsing for EOF
    vim.cmd([[%s#\n\n\+\%$#\r#e]])

    -- no extra lines at file start
    vim.cmd([[%s/\%^\_s*//e]])

    vim.fn.winrestview(view)
    vim.notify("Whitespace cleaned", vim.log.levels.INFO)
end, { desc = "Clean trailing spaces and extra blank lines" })

