if vim.g.neovide then
    vim.g.neovide_opacity = 0.9
    vim.g.neovide_cursor_animation_length = 0.04
    vim.o.guifont = "FiraCode Nerd Font:h13"
    vim.opt.linespace = 30

    vim.g.neovide_refresh_rate = 165
    vim.g.neovide_cursor_smooth_blink = false

    vim.opt.guicursor = {
        "n-v-c:block", -- Normal/Visual/Command mode = block
        "i-ci-ve:ver25", -- Insert/Visual-Excl. mode = vertical bar (25% width)
        "r-cr:hor20", -- Replace/Command-Replace mode = horizontal bar (20% height)
        -- The 'a:' part applies the blinking settings to all modes
        "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
        "sm:block-blinkwait175-blinkoff150-blinkon175",
    }

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
