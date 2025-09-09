if vim.g.neovide then
    vim.g.neovide_opacity = 0.8
    vim.g.neovide_cursor_animation_length = 0.04
    vim.o.guifont = "FiraCode Nerd Font:h13"
    vim.opt.linespace = 5

    vim.api.nvim_set_keymap(
        "n",
        "<C-+>",
        ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>",
        { silent = true }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<C-->",
        ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>",
        { silent = true }
    )
    vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
end
