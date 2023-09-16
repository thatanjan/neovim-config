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

-- Install your plugins here
lazy.setup {
    -- My plugins here
    { "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
    { "windwp/nvim-autopairs" }, -- Autopairs, integrates with both cmp and treesitter
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
    { "lukas-reineke/indent-blankline.nvim" },
    { "goolord/alpha-nvim" }, -- Colorschemes
    { "folke/tokyonight.nvim" },
    { "lunarvim/darkplus.nvim" },
    { "morhetz/gruvbox" },
    { "nanotech/jellybeans.vim" },
    "AlexvZyl/nordic.nvim",
    "shaunsingh/nord.nvim", -- cmp plugins
    { "hrsh7th/nvim-cmp" }, -- The completion plugin
    { "hrsh7th/cmp-buffer" }, -- buffer completions
    { "hrsh7th/cmp-path" }, -- path completions
    { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" }, -- snippets
    { "L3MON4D3/LuaSnip" }, --snippet engine
    { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use -- LSP

    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    {
        "nvimdev/lspsaga.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("lspsaga").setup {}
        end,
    },
    {
        "jose-elias-alvarez/typescript.nvim",
    },
    "b0o/schemastore.nvim", -- For Linting
    "mfussenegger/nvim-lint",
    { "mhartington/formatter.nvim" },
    { "RRethy/vim-illuminate" }, -- Telescope
    { "nvim-telescope/telescope.nvim" }, -- Treesitter
    { "nvim-treesitter/nvim-treesitter" }, -- Git
    { "lewis6991/gitsigns.nvim" }, -- DAP
    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui" },
    { "ravenxrz/DAPInstall.nvim" }, -- Which Key
    { "folke/which-key.nvim" }, -- Copilot -- , { "github/copilot.vim" } -- MDX
    "findango/vim-mdx", -- Trouble.nvim
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            local troubleConfig = require "./trouble"
            require("trouble").setup(troubleConfig)
        end,
    }, -- Emmet
    "mattn/emmet-vim", -- For markdown
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
    }, -- For Neovim with editor config
    {
        "gpanders/editorconfig.nvim",
    }, -- For SQL lsp
    "nanotee/sqls.nvim", -- For Prisma
    "pantharshit00/vim-prisma", --For Todo nvim
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
    }, -- For previewing colors on code
    {
        "norcalli/nvim-colorizer.lua",
    }, -- For Foldings
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
    }, -- For auto close tag
    "windwp/nvim-ts-autotag",
    {
        "kylechui/nvim-surround",
        version = "*", -- , for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup {
                -- Configuration here, or leave empty to , defaults
            }
        end,
    },
    "mbbill/undotree",
    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter" },
        config = function()
            require("treesj").setup {}
        end,
    },
    {
        "jedrzejboczar/possession.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("possession").setup {
                autosave = {
                    current = true,
                },
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
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
        },
    },
    { "AlphaTechnolog/pywal.nvim", name = "pywal" },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },
    { "HiPhish/rainbow-delimiters.nvim" },
}
