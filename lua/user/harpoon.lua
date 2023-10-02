local M = {
    "ThePrimeagen/harpoon",
    keys = function()
        local harpoonMark = require "harpoon.mark"
        local harpoonUI = require "harpoon.ui"

        return {
            {
                "mh",
                mode = "n",
                harpoonMark.add_file,
                desc = "Add file to harpoon",
            },
            {
                "mH",
                mode = "n",
                harpoonMark.rm_file,
                desc = "Remove file from harpoon",
            },
            {
                "<M-h>",
                mode = "n",
                harpoonUI.nav_prev, -- navigates to previous mark
                desc = "Go to previous mark file",
            },
            {
                "<M-l>",
                mode = "n",
                harpoonUI.nav_next, -- navigates to next mark
                desc = "Go to next mark file",
            },
        }
    end,
}

return M
