---@type trouble.Config
local config = {
    focus = true, -- Focus the window when opened
    restore = true, -- restores the last location in the list when opening
    warn_no_results = true, -- show a warning when there are no results

    -- Key mappings can be set to the name of a builtin action,
    -- or you can define your own custom action.
    ---@type table<string |false>
    keys = {
        gb = { -- example of a custom action that toggles the active view filter
            action = function(view)
                view:filter({ buf = 0 }, { toggle = true })
            end,
            desc = "Toggle Current Buffer Filter",
        },
        s = { -- example of a custom action that toggles the severity
            action = function(view)
                local f = view:get_filter "severity"
                local severity = ((f and f.filter.severity or 0) + 1) % 5
                view:filter({ severity = severity }, {
                    id = "severity",
                    template = "{hl:Title}Filter:{hl} {severity}",
                    del = severity == 0,
                })
            end,
            desc = "Toggle Severity Filter",
        },
    },
    ---@type table<string, trouble.Mode>
    modes = {
        -- sources define their own modes, which you can use directly,
        -- or override like in the example below
        lsp_references = {
            -- some modes are configurable, see the source code for more details
            params = {
                include_declaration = true,
            },
        },
        -- The LSP base mode for:
        -- * lsp_definitions, lsp_references, lsp_implementations
        -- * lsp_type_definitions, lsp_declarations, lsp_command
        lsp_base = {
            params = {
                -- don't include the current location in the results
                include_current = false,
            },
        },
        -- more advanced example that extends the lsp_document_symbols
        symbols = {
            desc = "document symbols",
            mode = "lsp_document_symbols",
            focus = false,
            win = { position = "right" },
            filter = {
                -- remove Package since luals uses it for control flow structures
                ["not"] = { ft = "lua", kind = "Package" },
                any = {
                    -- all symbol kinds for help / markdown files
                    ft = { "help", "markdown" },
                    -- default set of symbol kinds
                    kind = {
                        "Class",
                        "Constructor",
                        "Enum",
                        "Field",
                        "Function",
                        "Interface",
                        "Method",
                        "Module",
                        "Namespace",
                        "Package",
                        "Property",
                        "Struct",
                        "Trait",
                    },
                },
            },
        },
        diagnostics_buffer = {
            mode = "diagnostics", -- inherit from diagnostics mode
            filter = { buf = 0 }, -- filter diagnostics to the current buffer
        },
    },
    icons = {
        ---@type trouble.Indent.symbols
        indent = {
            top = "│ ",
            middle = "├╴",
            last = "└╴",
            -- last          = "-╴",
            -- last       = "╰╴", -- rounded
            fold_open = " ",
            fold_closed = " ",
            ws = "  ",
        },
        folder_closed = " ",
        folder_open = " ",
        kinds = {
            Array = " ",
            Boolean = "󰨙 ",
            Class = " ",
            Constant = "󰏿 ",
            Constructor = " ",
            Enum = " ",
            EnumMember = " ",
            Event = " ",
            Field = " ",
            File = " ",
            Function = "󰊕 ",
            Interface = " ",
            Key = " ",
            Method = "󰊕 ",
            Module = " ",
            Namespace = "󰦮 ",
            Null = " ",
            Number = "󰎠 ",
            Object = " ",
            Operator = " ",
            Package = " ",
            Property = " ",
            String = " ",
            Struct = "󰆼 ",
            TypeParameter = " ",
            Variable = "󰀫 ",
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
