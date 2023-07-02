local servers = {
    "lua_ls",
    "cssls",
    "html",
    "tsserver",
    "pyright",
    "bashls",
    "jsonls",
    "yamlls",
}

local settings = {
    ui = {
        border = "none",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

require("mason").setup(settings)
local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup {
    ensure_installed = servers,
    automatic_installation = true,
}

local opts = {}

mason_lspconfig.setup_handlers {

    function(server_name)
        opts = {
            on_attach = require("user.lsp.handlers").on_attach,
            capabilities = require("user.lsp.handlers").capabilities,
        }

        local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server_name)
        if require_ok then
            opts = vim.tbl_deep_extend("force", conf_opts, opts)
        end

        if server_name == "tsserver" then
            -- Use the typescript.nvim plugin
            require("typescript").setup {
                disable_commands = false, -- prevent the plugin from creating Vim commands
                debug = false, -- enable debug logging for commands
                go_to_source_definition = {
                    fallback = true, -- fall back to standard LSP definition on failure
                },
                server = { -- pass options to lspconfig's setup method
                    on_attach = opts.on_attach,
                },
            }
            return false
        end

        require("lspconfig")[server_name].setup(opts)
    end,
}
