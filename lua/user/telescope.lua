local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local open_with_trouble = require("trouble.sources.telescope").open

local actions = require "telescope.actions"

telescope.setup {
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules" },

        mappings = {
            i = {
                ["<Down>"] = actions.cycle_history_next,
                ["<Up>"] = actions.cycle_history_prev,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<c-t>"] = open_with_trouble,
            },
        },
    },
    extensions = {
        frecency = {
            auto_validate = true,
            db_validate_threshold = 10,
            path_display = { "filename_first" },
            show_filter_column = false,
        },
    },
}

local extenstion_list = {
    "luasnip",
    "undo",
    "import",
    "harpoon",
    "codecompanion",
}

for _, extension in pairs(extenstion_list) do
    telescope.load_extension(extension)
end
