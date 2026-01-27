-- lua/plugins/which-key.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
    icons = { breadcrumb = "»", separator = "➜", group = "+" },
    win = { border = "rounded" },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)   -- pass the opts we already defined

    -- Modern group registration
    wk.add({
      { "<leader>b", group = "buffers" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>l", group = "lsp" },
      { "<leader>u", group = "ui" },
      { "<leader>w", group = "window" },
    })

    ------------------------------------------------------------
    -- Your mappings (only the ones you want WhichKey to show)
    ------------------------------------------------------------
    -- Telescope
    wk.add({
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    })

    -- LSP
    wk.add({
      { "<leader>ld", vim.lsp.buf.definition, desc = "Definition" },
      { "<leader>lr", vim.lsp.buf.references, desc = "References" },
      { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },
    })

    -- Splits & navigation (add desc if you want them in WhichKey popup)
    vim.keymap.set("n", "<Leader>vv", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
    vim.keymap.set("n", "<Leader>vh", "<cmd>split<cr>", { desc = "Horizontal Split" })

    vim.keymap.set("n", "<C-h>", "<C-w>h")
    vim.keymap.set("n", "<C-j>", "<C-w>j")
    vim.keymap.set("n", "<C-k>", "<C-w>k")
    vim.keymap.set("n", "<C-l>", "<C-w>l")

    -- Snacks / LazyGit
    local Snacks = require("snacks")
    vim.keymap.set("n", "<leader>gl", function() Snacks.lazygit.log() end, { desc = "Lazygit Log" })
    vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })

    -- Buffers etc.
    vim.keymap.set("n", "<leader>bb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>bm", function() Snacks.picker.marks() end, { desc = "Marks" })
    vim.keymap.set("n", "<leader>br", function() Snacks.picker.registers() end, { desc = "Registers" })
    vim.keymap.set("n", "<leader>.", function() Snacks.scratch() end, { desc = "Scratch Buffer" })

    -- Commenting — decide on one style
    -- If you keep custom <gcc>, consider disabling default gc in Comment.nvim setup
    vim.keymap.set("n", "<gcc>", "<Plug>(comment_toggle_linewise)", { desc = "Toggle comment line" })
  end,
}
