-- Telescope setup + keymaps
local ok, builtin = pcall(require, "telescope.builtin")
if not ok then
    print("Telescope not found – did you clone it?")
    return
    end

    -- Optional: load fzf extension if you installed it
    pcall(require("telescope").load_extension, "fzf")

    vim.keymap.set("n", "<leader>ff", builtin.find_files,  { desc = "Find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep,   { desc = "Live grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers,     { desc = "Buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags,   { desc = "Help tags" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles,    { desc = "Recent files" })
    vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document symbols" })
