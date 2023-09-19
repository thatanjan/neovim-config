local M = {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = function()
        local flash = require "flash"

        return {
            {
                "<M-s>",
                mode = { "n", "o", "x" },
                function()
                    flash.jump()
                end,
                desc = "Flash",
            },
            {
                "<M-S>",
                mode = { "n", "o", "x" },
                function()
                    flash.treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    flash.remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    flash.treesitter_search()
                end,
                desc = "Treesitter Search",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    flash.toggle()
                end,
                desc = "Toggle Flash Search",
            },
        }
    end,
}

return M
