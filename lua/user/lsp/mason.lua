local servers = {
  "lua_ls",
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "bashls",
  "emmet_language_server",
  "phpactor",
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

local handler_status_ok, handlers = pcall(require, "user.lsp.handlers")

if not handler_status_ok then
  print "LSP handlers not found, please install lspconfig"
  return
end

mason_lspconfig.setup_handlers {

  function(server_name)
    opts = {
      on_attach = handlers.on_attach,
      capabilities = handlers.capabilities,
    }

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
