---@type trouble.Config
local config = {
    focus = true, -- Focus the window when opened

    -- Key mappings can be set to the name of a builtin action,
    -- or you can define your own custom action.
    ---@type table<string |false>
    keys = {},

    ---@type table<string, trouble.Mode>
    modes = {
        diagnostics_buffer = {
            mode = "diagnostics", -- inherit from diagnostics mode
            filter = { buf = 0 }, -- filter diagnostics to the current buffer
        },
    },
}

local M = {
    "folke/trouble.nvim",
    opts = config,
    cmd = "Trouble",
    dependencies = "kyazdani42/nvim-web-devicons",
}

return M
