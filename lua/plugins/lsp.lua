-- Minimal LSP setup using native Neovim 0.11+ API
-- No more require('lspconfig') framework

-- Common on_attach function (keymaps when LSP attaches)
local on_attach = function(client, bufnr)
local map = function(mode, lhs, rhs, opts)
opts = opts or {}
opts.buffer = bufnr
vim.keymap.set(mode, lhs, rhs, opts)
end

-- Standard LSP actions
map("n", "gd",        vim.lsp.buf.definition,       { desc = "Goto definition" })
map("n", "gD",        vim.lsp.buf.declaration,      { desc = "Goto declaration" })
map("n", "gi",        vim.lsp.buf.implementation,   { desc = "Goto implementation" })
map("n", "gr",        vim.lsp.buf.references,       { desc = "References" })
map("n", "K",         vim.lsp.buf.hover,            { desc = "Hover" })
map("n", "<leader>rn", vim.lsp.buf.rename,          { desc = "Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action,     { desc = "Code action" })
map("n", "<leader>ds", vim.diagnostic.setloclist,   { desc = "Diagnostics list" })

-- Diagnostic navigation
map("n", "[d", vim.diagnostic.goto_prev,  { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next,  { desc = "Next diagnostic" })
end

-- Helper to configure + enable servers
local function setup_server(name, opts)
opts = opts or {}
opts.on_attach = on_attach   -- always use our keymaps

-- Merge any server-specific settings
vim.lsp.config(name, opts)
vim.lsp.enable(name)
end

-- Your servers (only the ones you care about)
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

-- Optional: nicer diagnostic signs (same as before)
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Optional: global on_attach override or extra behavior
    -- (you can also use autocmd LspAttach instead of on_attach if you prefer)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            -- You could disable things like semantic tokens here if you want
            -- client.server_capabilities.semanticTokensProvider = nil
            end
            end,
    })
