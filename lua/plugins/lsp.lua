-- lua/plugins/lsp.lua
return {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
        -- 🔹 ADD THIS (capabilities for completion)
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
        if ok then
            capabilities = cmp_lsp.default_capabilities(capabilities)
        end

        -- Server configs
        local servers = {
            rust_analyzer = {},
            clangd = {},
            pyright = {},
            lua_ls = {
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
            },
        }

        -- 🔹 ONLY CHANGE HERE: inject capabilities
        for name, opts in pairs(servers) do
            opts = opts or {}
            opts.capabilities = capabilities
            vim.lsp.config(name, opts)
            vim.lsp.enable(name)
        end

        -- Diagnostic signs
        local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        -- Optional LspAttach tweaks
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client then
                    -- placeholder
                end
            end,
        })
    end,
}

