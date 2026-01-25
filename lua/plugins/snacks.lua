-- lua/plugins/snacks.lua

local ok, Snacks = pcall(require, "snacks")
if not ok then
  vim.notify("snacks.nvim not found", vim.log.levels.ERROR)
  return
end

------------------------------------------------------------
-- SETUP
------------------------------------------------------------
Snacks.setup({
  bigfile = { enabled = true },
  explorer = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },

  notifier = {
    enabled = true,
    timeout = 3000,
  },

  dashboard = {
    enabled = true,

    width = 60,
    pane_gap = 4,

    preset = {
      pick = nil,

      keys = {
        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        {
          icon = " ",
          key = "c",
          desc = "Config",
          action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })",
        },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },

      header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]],
    },

    sections = {
      { section = "header" },

      {
        pane = 2,
        icon = " ",
        title = "Recent Files",
        section = "recent_files",
        indent = 2,
        padding = 1,
      },

      {
        pane = 2,
        icon = " ",
        title = "Projects",
        section = "projects",
        indent = 2,
        padding = 1,
      },

      {
        pane = 2,
        icon = " ",
        title = "Git Status",
        section = "terminal",
        enabled = function()
          return Snacks.git.get_root() ~= nil
        end,
        cmd = "git status --short --branch --renames",
        height = 6,
        padding = 1,
        ttl = 300,
        indent = 3,
      },

      { section = "keys", gap = 1, padding = 1 },
      -- 🚫 NO startup section (requires lazy.nvim)
    },
  },
})

------------------------------------------------------------
-- KEYMAPS (explicit & correct)
------------------------------------------------------------
vim.keymap.set("n", "<leader>z",  function() Snacks.zen() end, { desc = "Toggle Zen Mode" })
vim.keymap.set("n", "<leader>Z",  function() Snacks.zen.zoom() end, { desc = "Toggle Zoom" })
vim.keymap.set("n", "<leader>.",  function() Snacks.scratch() end, { desc = "Scratch Buffer" })
vim.keymap.set("n", "<leader>S",  function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })
vim.keymap.set("n", "<leader>n",  function() Snacks.notifier.show_history() end, { desc = "Notification History" })
vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename File" })

-- Git browse (normal + visual)
vim.keymap.set({ "n", "v" }, "<leader>gB",
  function() Snacks.gitbrowse() end,
  { desc = "Git Browse" }
)

vim.keymap.set("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss Notifications" })
vim.keymap.set({ "n", "t" }, "<C-/>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
vim.keymap.set({ "n", "t" }, "<C-_>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })


------------------------------------------------------------
-- TOGGLES (manual replacement for VeryLazy)
------------------------------------------------------------
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.option("conceallevel", { off = 0, on = 2 }):map("<leader>uc")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.dim():map("<leader>uD")

------------------------------------------------------------
-- AUTO-OPEN DASHBOARD
------------------------------------------------------------
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      Snacks.dashboard.open()
    end
  end,
})

