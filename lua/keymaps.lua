
-- ~/.config/nvim/lua/keymaps.lua

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-------------------------------------------------------------------------------
-- 1. line movement
-------------------------------------------------------------------------------

-- Normal mode
map('n', '<A-j>', ':m .+1<CR>==', opts)
map('n', '<A-k>', ':m .-2<CR>==', opts)

-- Visual mode
map('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
map('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)

-- Insert mode
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', opts)
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', opts)

-------------------------------------------------------------------------------
-- 2. File / Folder creation 
-------------------------------------------------------------------------------

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

-------------------------------------------------------------------------------
-- 3. Line / Whitespace cleanup 
-------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>cw", function()
    local view = vim.fn.winsaveview()

    -- remove trailing whitespace
    vim.cmd([[%s/\s\+$//e]])

    -- collapse multiple blank lines (2+)
    vim.cmd([[%s/\n\{2,}/\r\r/ge]])

    -- collapse extra lines at EOF
    vim.cmd([[%s#\n\n\+\%$#\r#e]])

    -- remove leading blank lines
    vim.cmd([[%s/\%^\_s*//e]])

    vim.fn.winrestview(view)
    vim.notify("Whitespace cleaned", vim.log.levels.INFO)
end, { desc = "Clean trailing spaces and extra blank lines" })

-------------------------------------------------------------------------------
-- 4. Easy Replace
-------------------------------------------------------------------------------

-- Module
_G.replace_popup = {}

-- Replace across the whole file
function _G.replace_popup.replace_all()
    vim.ui.input({ prompt = "Replace word: " }, function(old)
        if not old or old == "" then return end
        vim.ui.input({ prompt = "With: " }, function(new)
            if not new then return end
            vim.cmd("%s/" .. old .. "/" .. new .. "/gc")
        end)
    end)
end

-- Replace in visual selection
function _G.replace_popup.replace_selected()
    vim.ui.input({ prompt = "Replace word: " }, function(old)
        if not old or old == "" then return end
        vim.ui.input({ prompt = "With: " }, function(new)
            if not new then return end
            vim.cmd("'<,'>s/" .. old .. "/" .. new .. "/gc")
        end)
    end)
end

-- Keymaps for popup replace
vim.keymap.set("n", "<leader>ra", function()
    _G.replace_popup.replace_all()
end, { desc = "Replace all in file (popup)" })

vim.keymap.set("v", "<leader>rs", function()
    _G.replace_popup.replace_selected()
end, { desc = "Replace in selection (popup)" })

