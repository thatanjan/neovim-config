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
    { "folke/which-key.nvim" },
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
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
            {
                "luukvbaal/statuscol.nvim",
                config = function()
                    local builtin = require "statuscol.builtin"
                    require("statuscol").setup {
                        relculright = true,
                        segments = {
                            { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                            { text = { "%s" }, click = "v:lua.ScSa" },
                            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                        },
                    }
                end,
            },
        },
    },
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
    { "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" } },
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

    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {},
        config = {
            max_count = 10,
        },
    },

    require "user.flash",

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

    { "github/copilot.vim" },
}
