local fn = vim.fn

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    return
end

lazy.setup {
    { "nvim-lua/plenary.nvim" },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}, -- this is equalent to setup({}) function
    },
    { "numToStr/Comment.nvim" },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    { "kyazdani42/nvim-web-devicons" },
    { "kyazdani42/nvim-tree.lua" },
    { "akinsho/bufferline.nvim" },
    { "moll/vim-bbye" },
    { "nvim-lualine/lualine.nvim" },
    { "akinsho/toggleterm.nvim" },
    { "ahmedkhalf/project.nvim" },
    { "lewis6991/impatient.nvim" },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },
    { "goolord/alpha-nvim" },
    { "folke/tokyonight.nvim" },
    { "lunarvim/darkplus.nvim" },
    { "morhetz/gruvbox" },
    { "nanotech/jellybeans.vim" },
    { "AlexvZyl/nordic.nvim" },
    { "shaunsingh/nord.nvim" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "L3MON4D3/LuaSnip" },
    { "rafamadriz/friendly-snippets" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    {
        "nvimdev/lspsaga.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter", -- optional
            "kyazdani42/nvim-web-devicons", -- optional
        },
        event = "LspAttach",
    },
    { "jose-elias-alvarez/typescript.nvim" },
    { "b0o/schemastore.nvim" },
    { "mfussenegger/nvim-lint" },
    { "mhartington/formatter.nvim" },
    { "RRethy/vim-illuminate" },

    { "nvim-telescope/telescope.nvim" },
    { "benfowler/telescope-luasnip.nvim" },

    { "nvim-treesitter/nvim-treesitter" },
    { "lewis6991/gitsigns.nvim" },
    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui" },
    { "ravenxrz/DAPInstall.nvim" },
    { "folke/which-key.nvim", event = "VeryLazy" },
    { "findango/vim-mdx" },
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            local troubleConfig = require "./trouble"
            require("trouble").setup(troubleConfig)
        end,
    },
    { "mattn/emmet-vim" },
    { "iamcco/markdown-preview.nvim", build = "cd app && yarn install" },
    { "gpanders/editorconfig.nvim" },
    { "nanotee/sqls.nvim" },
    { "pantharshit00/vim-prisma" },
    { "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim" },
    { "norcalli/nvim-colorizer.lua" },
    { "windwp/nvim-ts-autotag" },
    {
        "kylechui/nvim-surround",
        version = "*",
        config = function()
            require("nvim-surround").setup {}
        end,
    },
    { "mbbill/undotree" },
    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter" },
        config = function()
            require("treesj").setup {}
        end,
    },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-treesitter/nvim-treesitter" } },
    },
    { "AlphaTechnolog/pywal.nvim", name = "pywal" },
    {
        "catppuccin/nvim",
        config = function()
            require("catppuccin").setup {
                term_colors = true,
                -- transparent_background = true,
                color_overrides = {
                    mocha = {
                        base = "#1E1E2E",
                    },
                },
            }
        end,
    },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            -- "rcarriga/nvim-notify"
        },
    },
    { "HiPhish/rainbow-delimiters.nvim" },

    {
        "jedrzejboczar/possession.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("possession").setup {
                autosave = { current = true },
                plugins = { delete_hidden_buffers = false },
                commands = {
                    save = "SSave",
                    load = "SLoad",
                    delete = "SDelete",
                    list = "SList",
                },
            }
            require("telescope").load_extension "possession"
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
        },
    },

    { "axelvc/template-string.nvim" },
    {
        "piersolenski/telescope-import.nvim",
        requires = "nvim-telescope/telescope.nvim",
    },

    -- Telescope extenstion
    {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require("telescope").load_extension "frecency"
        end,
    },

    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {},
        config = {
            max_count = 10,
        },
    },

    require "user.flash",
    -- require "user.nvim-ufo",

    { "sindrets/diffview.nvim" }, -- optional

    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true,
    },
    {
        "AckslD/muren.nvim",
        config = true,
    },

    { "nvim-pack/nvim-spectre" },

    require "user.harpoon",
    require "user.copilot",
    require "user.avante",
    require "user.codecompanion",

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
    },

    "AndreM222/copilot-lualine",

    { "zaldih/themery.nvim" },
    { "echasnovski/mini.icons", version = false },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            file_types = { "markdown", "Avante", "codecompanion" },
        },
        ft = { "markdown", "Avante", "codecompanion" },
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    },

    -- tailwind-tools.lua
    {
        "luckasRanarison/tailwind-tools.nvim",
        name = "tailwind-tools",
        build = ":UpdateRemotePlugins",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim", -- optional
            "neovim/nvim-lspconfig", -- optional
        },
        opts = {}, -- your configuration
    },
}
