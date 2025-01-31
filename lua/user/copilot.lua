local M = {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup {
            panel = {
                enabled = true,
                auto_refresh = false,
                keymap = {
                    jump_prev = "[[",
                    jump_next = "]]",
                    accept = "<CR>",
                    refresh = "gr",
                    open = "<M-CR>",
                },
                layout = {
                    position = "bottom", -- | top | left | right | horizontal | vertical
                    ratio = 0.4,
                },
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                hide_during_completion = false,
                debounce = 75,
                keymap = {
                    accept = "<M-y>",
                    accept_line = "<C-[>",
                    accept_word = "<C-]>",
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-x>",
                },
            },
            filetypes = {
                help = false,
                gitrebase = false,
                ["."] = true,
            },
            copilot_node_command = "node", -- Node.js version must be > 18.x
            server_opts_overrides = {},
        }
    end,
}

return M
