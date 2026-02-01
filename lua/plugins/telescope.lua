-- lua/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  cmd = "Telescope",
  config = function()
    local ok, builtin = pcall(require, "telescope.builtin")
    if not ok then
      print("Telescope failed to load")
      return
    end

    local telescope = require("telescope")
    telescope.load_extension("fzf")

    -- File finders
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "Live grep" })
    vim.keymap.set("n", "<leader>bb", builtin.buffers,    { desc = "Buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags,  { desc = "Help tags" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles,   { desc = "Recent files" })
    vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document symbols" })
  end,
}

