-- lua/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  config = function()
    -- Paste your entire current lsp.lua content here
    local on_attach = function(client, bufnr)
      local map = function(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      map("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
      map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
      map("n", "gi", vim.lsp.buf.implementation, { desc = "Goto implementation" })
      map("n", "gr", vim.lsp.buf.references, { desc = "References" })
      map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
      map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
      map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
      map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "Diagnostics list" })
      map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
      map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
    end

    local function setup_server(name, opts)
      opts = opts or {}
      opts.on_attach = on_attach
      vim.lsp.config(name, opts)
      vim.lsp.enable(name)
    end

    setup_server("rust_analyzer", {})
    setup_server("clangd", {})
    setup_server("pyright", {})
    setup_server("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = { enable = false },
        },
      },
    })

    local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
          -- optional tweaks
        end
      end,
    })
  end,
}

